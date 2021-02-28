import 'package:flutter/material.dart';
import 'package:products/domain/models/service_response.dart';
import 'package:products/utils/response_utils.dart';

abstract class CustomProvider<T> extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setIsLoading(value) {
    if (_isLoading == value) {
      return;
    }

    _isLoading = value;
  }

  T _data;
  T get data => _data;

  String _error;
  String get error => _error;

  setData(T value) {
    _data = value;

    notifyListeners();
  }

  setError(String value) {
    _error = value;

    notifyListeners();
  }

  treatBooleanResponse(ServiceResponse<Map> response) {
    if (response.data != null) {
      if (!getErrorCodes().contains(response.data['statusCode'])) {
        return true;
      }

      setError(response.data['message']);
    } else if (response.error != null) {
      setError(response.error);
    }

    return false;
  }

  treatDataResponse(ServiceResponse<T> response) {
    setData(response.data);

    if (response.error != null) {
      setError(response.error);
    }

    return response.data;
  }
}
