import '../../app/managers/config_manager.dart';

class ProfileModel {
  int? id;
  String? userType;
  String? name;
  String? email;
  String? address;
  String? country;
  String? city;
  String? districtCode;
  String? wardCode;
  String? phone;
  dynamic balance;
  String? createdAt;
  String? updatedAt;
  int? turnEarn;
  int? isApproval;
  int? isSpecial;
  int? isVendor;
  int? nextQrSerialNo;
  int? isNotification;
  String? avatar;
  num? currentDebt;

  bool get isAgency => isVendor == 1;

  String get getAvatar =>
      '${ConfigManager.getInstance().apiBaseUrl.substring(0, ConfigManager.getInstance().apiBaseUrl.length - 1)}$avatar'
          .replaceAll('api/', '');

  ProfileModel({
    this.id,
    this.userType,
    this.name,
    this.email,
    this.address,
    this.country,
    this.city,
    this.districtCode,
    this.wardCode,
    this.phone,
    this.balance,
    this.createdAt,
    this.updatedAt,
    this.turnEarn,
    this.isApproval,
    this.isSpecial,
    this.isVendor,
    this.nextQrSerialNo,
    this.isNotification,
    this.avatar,
    this.currentDebt,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    country = json['country'];
    if (json['avatar'] != null) {
      avatar = json['avatar'];
    }

    city = json['city'];
    districtCode = json['district_code'];
    wardCode = json['ward_code'];
    phone = json['phone'];
    balance = json['balance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    turnEarn = json['turn_earn'];
    isApproval = json['is_approval'];
    isSpecial = json['is_special'];
    isVendor = json['is_vendor'];
    nextQrSerialNo = json['next_qr_serial_no'];
    isNotification = json['is_notification'];
    currentDebt = json['currentDebt'];
  }
}
