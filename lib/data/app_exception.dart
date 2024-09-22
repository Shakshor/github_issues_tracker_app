class AppException implements Exception{

  final _message;
  final _prefix;

  // constructor
  AppException([this._message, this._prefix]);

  @override
  String toString(){
    return '$_prefix$_message';
  }
}


// time_out_exception
class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, 'Error During Communication:');
}

// invalid_route
class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid  Request:');
}

// unauthorised_error_showing
class UnAuthorisedException extends AppException {
  UnAuthorisedException([String? message]) : super(message, 'Unauthorised Access:');
}

// invalid_input_error_showing
class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input Request:');
}