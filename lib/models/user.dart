class User {
  final String id;
  final String token;
  final String email;
  final String name;
  final String phoneNumber;
  final int gender;
  final bool emailConfirmed;
  final String size;
  final String role;

  User({
    required this.id,
    required this.token,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.gender,
    required this.emailConfirmed,
    required this.size,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      token: json['token'],
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      emailConfirmed: json['emailConfirmed'],
      size: json['size'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'emailConfirmed': emailConfirmed,
      'size': size,
      'role': role,
    };
  }
}
