class UserInfor {
  String? phoneNumber;
  int? sizeUpload;
  String? name;
  dynamic password;
  String? email;
  String? fullName;
  dynamic appleId;
  String? avatar;
  dynamic facebookId;
  String? organizationId;
  int? accountType;
  int? point;
  String? address;
  String? jobPosition;
  int? status;
  dynamic roleNames;
  dynamic roleIds;

  UserInfor(
      {this.phoneNumber,
      this.sizeUpload,
      this.name,
      this.password,
      this.email,
      this.fullName,
      this.appleId,
      this.avatar,
      this.facebookId,
      this.organizationId,
      this.accountType,
      this.point,
      this.address,
      this.jobPosition,
      this.status,
      this.roleNames,
      this.roleIds});

  UserInfor.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    sizeUpload = json['sizeUpload'];
    name = json['name'];
    password = json['password'];
    email = json['email'];
    fullName = json['fullName'];
    appleId = json['appleId'];
    avatar = json['avatar'];
    facebookId = json['facebookId'];
    organizationId = json['organizationId'];
    accountType = json['accountType'];
    point = json['point'];
    address = json['address'];
    jobPosition = json['jobPosition'];
    status = json['status'];
    roleNames = json['roleNames'];
    roleIds = json['roleIds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['sizeUpload'] = this.sizeUpload;
    data['name'] = this.name;
    data['password'] = this.password;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['appleId'] = this.appleId;
    data['avatar'] = this.avatar;
    data['facebookId'] = this.facebookId;
    data['organizationId'] = this.organizationId;
    data['accountType'] = this.accountType;
    data['point'] = this.point;
    data['address'] = this.address;
    data['jobPosition'] = this.jobPosition;
    data['status'] = this.status;
    data['roleNames'] = this.roleNames;
    data['roleIds'] = this.roleIds;
    return data;
  }
}
