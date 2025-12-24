class CreateUserModel {
  final String fullName;
  final String email;
  final String password;

  CreateUserModel({
    required this.fullName,
    required this.email,
    required this.password,
  });

  factory CreateUserModel.fromJson(Map<String, dynamic> json) {
    return CreateUserModel(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'fullName': fullName, 'email': email, 'password': password};
  }
}
