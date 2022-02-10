class ChangeFavorit {
  bool? status;
  String? message;

  ChangeFavorit.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}