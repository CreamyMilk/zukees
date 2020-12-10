class OtpResponse {
  int message;
  String description;

  OtpResponse({this.message, this.description});

  OtpResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['description'] = this.description;
    return data;
  }
}
