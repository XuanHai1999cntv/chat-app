class UserModel {
  final String userName;
  final String phoneNumber;
  final String email;
  final String status;
  final String uid;

  const UserModel(
      {required this.userName, required this.email, required this.phoneNumber,required this.status,required this.uid});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['name'],
      email: json['email'],
      phoneNumber: json['phone'],
      status: json['status'],
      uid: json['uid'],
    );
  }
}
