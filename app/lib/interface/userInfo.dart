/// 用户信息类
class MyUserInfo {
  late String email, userName, password;
  late int phoneNumber;

  MyUserInfo.name(this.email, this.userName, this.password, this.phoneNumber);

  static MyUserInfo fromMap(Map<String, dynamic> map) {
    return MyUserInfo(
        email: map["email"],
        userName: map["userName"],
        password: map["password"],
        phoneNumber: map["phoneNumber"]);
  }

  MyUserInfo({
    required this.email,
    required this.userName,
    required this.password,
    required this.phoneNumber,
  });

  @override
  String toString() {
    return 'MyUserInfo{email: $email, userName: $userName, password: $password, phoneNumber: $phoneNumber}';
  }
}
