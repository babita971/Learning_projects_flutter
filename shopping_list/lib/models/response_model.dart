class CustomResponse {
  CustomResponse(
      {required this.statusCode, required this.data, required this.errorMsg});

  final int statusCode;
  final dynamic data;
  final String errorMsg;
}
