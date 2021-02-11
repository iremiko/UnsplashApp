class StatusError{
  final int statusCode;
  final String exception;

  StatusError(this.statusCode, this.exception);

  @override
  String toString() {
    return 'StatusError{statusCode: $statusCode, exception: $exception}';
  }
}