
class UserAuth {
  UserAuth({
    this.id,
    this.adminData,
    this.userName,
    this.email,
    this.password,
    this.phone,
    this.countryCode,
    this.mfaUserId,
    this.mfaToken,
  });

  dynamic id;
  dynamic adminData;
  String userName;
  String email;
  dynamic password;
  String phone;
  String countryCode;
  int mfaUserId;
  dynamic mfaToken;

  factory UserAuth.fromJson(Map<String, dynamic> json) => UserAuth(
    id: json["id"],
    adminData: json["adminData"],
    userName: json["userName"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    countryCode: json["countryCode"],
    mfaUserId: json["mfaUserId"],
    mfaToken: json["mfaToken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "adminData": adminData,
    "userName": userName,
    "email": email,
    "password": password,
    "phone": phone,
    "countryCode": countryCode,
    "mfaUserId": mfaUserId,
    "mfaToken": mfaToken,
  };
}
