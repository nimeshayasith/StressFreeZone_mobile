import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String? password;
  final String? googleId;
  final DateTime? birthday;
  final double? height;
  final double? weight;
  final String gender;
  final String? resetPasswordToken;
  final DateTime? resetPasswordExpires;
  final bool premium;
  final String? stripeCustomerId;
  final String? subscriptionId;
  final DateTime? trialEnd;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.googleId,
    this.birthday,
    this.height,
    this.weight,
    this.gender = 'Male',
    this.resetPasswordToken,
    this.resetPasswordExpires,
    this.premium = false,
    this.stripeCustomerId,
    this.subscriptionId,
    this.trialEnd,
    required String token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'googleId': googleId,
      'birthday': birthday?.toIso8601String(),
      'height': height,
      'weight': weight,
      'gender': gender,
      'resetPasswordToken': resetPasswordToken,
      'resetPasswordExpires': resetPasswordExpires?.toIso8601String(),
      'premium': premium,
      'stripeCustomerId': stripeCustomerId,
      'subscriptionId': subscriptionId,
      'trialEnd': trialEnd?.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'],
      googleId: map['googleId'],
      birthday:
          map['birthday'] != null ? DateTime.parse(map['birthday']) : null,
      height: map['height']?.toDouble(),
      weight: map['weight']?.toDouble(),
      gender: map['gender'] ?? 'Male',
      resetPasswordToken: map['resetPasswordToken'],
      resetPasswordExpires: map['resetPasswordExpires'] != null
          ? DateTime.parse(map['resetPasswordExpires'])
          : null,
      premium: map['premium'] ?? false,
      stripeCustomerId: map['stripeCustomerId'],
      subscriptionId: map['subscriptionId'],
      trialEnd:
          map['trialEnd'] != null ? DateTime.parse(map['trialEnd']) : null,
      token: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
