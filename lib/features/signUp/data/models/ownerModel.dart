class UserModel {
  final String name;
  final String gmail;
  final String password;
  final String section;
  final String phoneNumber;
  String userID;

  UserModel({
    required this.name,
    required this.gmail,
    required this.password,
    required this.userID,
    required this.section,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['user_name'] ?? '',
      section: json['section'] ?? '',
      userID: json['userID'] ?? '',
      gmail: json['email_address'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      password: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': name,
      'userID': userID,
      'phone_number': phoneNumber,
      'section': section,

      'email_address': gmail,
    };
  }
}
