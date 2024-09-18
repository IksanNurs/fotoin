class RequestModel {
  String? message;

  RequestModel({
    this.message,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
