import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aayush_machine_test/core/db/app_db.dart';
import 'package:aayush_machine_test/core/navigation/navigation_service.dart';
import 'package:aayush_machine_test/core/navigation/routes.dart';

import 'app_exceptions.dart';

class DioErrorUtil {
  // general methods:------------------------------------------------------------
  static handleError(DioException error) {
    String errorDescription = "";
    if (error is DioException) {
      debugPrint(error.toString());
      switch (error.type) {
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            throw ConnectionException("Connection to server failed due to internet connection.");
          } else if (error.response!.statusCode == -9) {
            throw NoInternetException("No Active Internet Connection");
          } else {
            throw InvalidInputException("Something went wrong. Please try after sometime.");
          }
          break;
        case DioExceptionType.cancel:
          errorDescription = "Request to server was cancelled";
          break;
        case DioExceptionType.connectionTimeout:
          throw RequestCanceledException("Connection timeout with server");

        case DioExceptionType.receiveTimeout:
          throw ServerSideException("Request can't be handled for now. Please try after sometime.");

        case DioExceptionType.badResponse:
          debugPrint("Response:");
          debugPrint(error.toString());
          if (error.response!.statusCode == 12039 || error.response!.statusCode == 12040) {
            throw ConnectionException("Connection to server failed due to internet connection.");
          } else if (401 == error.response!.statusCode) {
            throw UnauthorisedException("Please login again.");
          } else if (401 < error.response!.statusCode! && error.response!.statusCode! <= 417) {
            throw BadRequestException("Something when wrong. Please try again.");
          } else if (500 <= error.response!.statusCode! && error.response!.statusCode! <= 505) {
            throw ServerSideException(
                "Request can't be handled for now. Please try after sometime.");
          } else {
            throw InvalidInputException("Something went wrong. Please try after sometime.");
          }

        case DioExceptionType.sendTimeout:
          throw ServerSideException("Request can't be handled for now. Please try after sometime.");

        case DioExceptionType.badCertificate:
          // TODO: Handle this case.
          break;

        case DioExceptionType.connectionError:
          // TODO: Handle this case.
          break;
      }
    } else {
      throw InvalidInputException("Something went wrong. Please try after sometime.");
    }
    return errorDescription;
  }
}
