class RegisterModel {
  final bool status;
  final String? message;
  final String username;
  final String fullName;
  final String email;

  RegisterModel({
    required this.status,
    required this.message,
    required this.username,
    required this.fullName,
    required this.email,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"] ?? {};
    return RegisterModel(
      status: json["status"] ?? false,
      message: json["message"],
      username: data["username"] ?? "",
      fullName: data["full_name"] ?? "",
      email: data["email"] ?? "",
    );
  }
}
