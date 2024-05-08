class ResponseModel {
  ResponseModel({this.statusCode, this.message, this.data});

  final int? statusCode;
  final String? message;
  final dynamic data;

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data']
    );
  }
}
