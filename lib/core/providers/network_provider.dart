import 'dart:convert';

import 'package:base_project/core/providers/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

typedef GenericApiCallBack<T> = T Function(String value);

class NetworkAssistantProvider extends Provider<INetworkAssistant> {
  NetworkAssistantProvider({super.key})
      : super(
          create: (context) => MainNetworkAssistant(),
          lazy: false,
        );
}

class MainNetworkAssistant extends INetworkAssistant {
  MainNetworkAssistant();
}

abstract class INetworkAssistant extends IAssistant {
  @override
  void prepare() {
    // Do nothing
  }

  Future<INetworkResponse<T>> parseResponse<T>({
    required ApiResponseModel apiResponse,
    required GenericApiCallBack<T> fromJson,
    required String api,
  }) async {
    if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
      try {
        T parsedResponse = await compute(fromJson, apiResponse.response ?? "");
        return INetworkResponse<T>.success(
          statusCode: apiResponse.statusCode ?? 200,
          data: parsedResponse,
        );
      } catch (e) {
        return INetworkResponse<T>.failure(
          statusCode: apiResponse.statusCode ?? 400,
          errorMessage: "Something went wrong. Please try again later.",
        );
      }
    } else {
      try {
        final decodedJson = json.decode(apiResponse.response ?? "");
        ErrorBody errorBody = ErrorBody.fromMap(decodedJson);
        return INetworkResponse<T>.failure(
          statusCode: apiResponse.statusCode ?? 400,
          errorMessage: errorBody.message ??
              "Something went wrong. Please try again later.",
        );
      } catch (e) {
        return INetworkResponse<T>.failure(
          statusCode: apiResponse.statusCode ?? 400,
          errorMessage: "Something went wrong. Please try again later.",
        );
      }
    }
  }

  Future<INetworkResponse<T>> makeGetCall<T>({
    required String api,
    required INetworkRequest request,
    required GenericApiCallBack<T> fromJson,
  }) async {
    try {
      final uri = Uri.parse(api).replace(queryParameters: request.queryParams);
      final response = await http.get(uri, headers: request.headers);

      final apiResponse = ApiResponseModel(
        response: response.body,
        statusCode: response.statusCode,
      );

      return parseResponse<T>(
        apiResponse: apiResponse,
        fromJson: fromJson,
        api: api,
      );
    } catch (e) {
      return INetworkResponse<T>.failure(
        statusCode: 500,
        errorMessage: "Network error occurred. Please try again later.",
      );
    }
  }

  Future<INetworkResponse<T>> makePostCall<T>({
    required String api,
    required INetworkRequest request,
    required GenericApiCallBack<T> fromJson,
  }) async {
    try {
      final uri = Uri.parse(api);
      final response = await http.post(
        uri,
        headers: request.headers,
        body: json.encode(request.body),
      );

      final apiResponse = ApiResponseModel(
        response: response.body,
        statusCode: response.statusCode,
      );

      return parseResponse<T>(
        apiResponse: apiResponse,
        fromJson: fromJson,
        api: api,
      );
    } catch (e) {
      return INetworkResponse<T>.failure(
        statusCode: 500,
        errorMessage: "Network error occurred. Please try again later.",
      );
    }
  }
}

class ErrorBody {
  String? message;
  String? rawMessage;

  ErrorBody({
    this.message,
    this.rawMessage,
  });

  ErrorBody copyWith({
    String? message,
    String? rawMessage,
  }) =>
      ErrorBody(
        message: message ?? this.message,
        rawMessage: rawMessage ?? this.rawMessage,
      );

  factory ErrorBody.fromMap(Map<String, dynamic> json) => ErrorBody(
        message: json['message'],
        rawMessage: json['rawMessage'],
      );

  @override
  String toString() {
    return '{ message : ${message.toString()}, rawMessage : ${rawMessage.toString()}, }';
  }
}

class INetworkRequest {
  final Map<String, String>? headers;
  final Map<String, String>? queryParams;
  final Map<String, dynamic>? body;
  final INetworkChannel channel;
  final int numberOfRetryAttempts;

  INetworkRequest({
    this.headers,
    this.body,
    this.queryParams,
    this.channel = INetworkChannel.secure,
    this.numberOfRetryAttempts = 1,
  }) : assert(numberOfRetryAttempts >= 1 && numberOfRetryAttempts <= 8);
}

enum INetworkChannel { secure, unsecure }

class INetworkResponse<T> {
  final bool isSuccess;
  final int statusCode;
  final T? data;
  final String? errorMessage;

  INetworkResponse.success({
    required this.data,
    required this.statusCode,
  })  : isSuccess = true,
        errorMessage = null;

  INetworkResponse.failure({
    required this.statusCode,
    this.errorMessage,
  })  : isSuccess = false,
        data = null;
}

class ApiResponseModel {
  final String? response;
  final int? statusCode;

  const ApiResponseModel({
    required this.response,
    required this.statusCode,
  });

  factory ApiResponseModel.fromMap(Map<String, dynamic> json) =>
      ApiResponseModel(
        response: json['response'],
        statusCode: json['statusCode'],
      );

  @override
  String toString() {
    return '{ statusCode : ${statusCode.toString()}, response : ${response.toString()} }';
  }
}
