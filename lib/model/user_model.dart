class UserModel {
  String id;
  dynamic adminData;
  dynamic name;
  String userName;
  dynamic givenName;
  dynamic familyName;
  dynamic displayName;
  dynamic userType;
  dynamic preferredLanguage;
  dynamic locale;
  String email;
  String phone;
  String pwdHash;
  dynamic userStatus;
  dynamic roles;
  dynamic profilePictures;
  dynamic loginAttempts;
  dynamic passwordModifiedAt;
  dynamic passwordModifiedBy;
  dynamic gender;
  dynamic notes;
  dynamic countryCode;
  List<AddressList> addressList;
  dynamic twilio;
  dynamic userTokenDetails;

  UserModel(
      {this.id,
        this.adminData,
        this.name,
        this.userName,
        this.givenName,
        this.familyName,
        this.displayName,
        this.userType,
        this.preferredLanguage,
        this.locale,
        this.email,
        this.phone,
        this.pwdHash,
        this.userStatus,
        this.roles,
        this.profilePictures,
        this.loginAttempts,
        this.passwordModifiedAt,
        this.passwordModifiedBy,
        this.gender,
        this.notes,
        this.countryCode,
        this.addressList,
        this.twilio,
        this.userTokenDetails});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminData = json['adminData'];
    name = json['name'];
    userName = json['userName'];
    givenName = json['givenName'];
    familyName = json['familyName'];
    displayName = json['displayName'];
    userType = json['userType'];
    preferredLanguage = json['preferredLanguage'];
    locale = json['locale'];
    email = json['email'];
    phone = json['phone'];
    pwdHash = json['pwdHash'];
    userStatus = json['userStatus'];
    roles = json['roles'];
    profilePictures = json['profilePictures'];
    loginAttempts = json['loginAttempts'];
    passwordModifiedAt = json['passwordModifiedAt'];
    passwordModifiedBy = json['passwordModifiedBy'];
    gender = json['gender'];
    notes = json['notes'];
    countryCode = json['countryCode'];
    if (json['addressList'] != null) {
      // ignore: deprecated_member_use
      addressList = new List<AddressList>();
      json['addressList'].forEach((v) {
        addressList.add(new AddressList.fromJson(v));
      });
    }
    twilio = json['twilio'];
    userTokenDetails = json['userTokenDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adminData'] = this.adminData;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['givenName'] = this.givenName;
    data['familyName'] = this.familyName;
    data['displayName'] = this.displayName;
    data['userType'] = this.userType;
    data['preferredLanguage'] = this.preferredLanguage;
    data['locale'] = this.locale;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['pwdHash'] = this.pwdHash;
    data['userStatus'] = this.userStatus;
    data['roles'] = this.roles;
    data['profilePictures'] = this.profilePictures;
    data['loginAttempts'] = this.loginAttempts;
    data['passwordModifiedAt'] = this.passwordModifiedAt;
    data['passwordModifiedBy'] = this.passwordModifiedBy;
    data['gender'] = this.gender;
    data['notes'] = this.notes;
    data['countryCode'] = this.countryCode;
    if (this.addressList != null) {
      data['addressList'] = this.addressList.map((v) => v.toJson()).toList();
    }
    data['twilio'] = this.twilio;
    data['userTokenDetails'] = this.userTokenDetails;
    return data;
  }
}

class AddressList {
  String addressName;
  String mobileNumber;
  String buildingNo;
  String area;
  String city;
  String state;
  String pincode;
  String landmark;
  String type;

  AddressList(
      {this.addressName,
        this.mobileNumber,
        this.buildingNo,
        this.area,
        this.city,
        this.state,
        this.pincode,
        this.landmark,
        this.type});

  AddressList.fromJson(Map<String, dynamic> json) {
    addressName = json['addressName'];
    mobileNumber = json['mobile_number'];
    buildingNo = json['buildingNo'];
    area = json['area'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    landmark = json['landmark'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressName'] = this.addressName;
    data['mobile_number'] = this.mobileNumber;
    data['buildingNo'] = this.buildingNo;
    data['area'] = this.area;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['landmark'] = this.landmark;
    data['type'] = this.type;
    return data;
  }
}
