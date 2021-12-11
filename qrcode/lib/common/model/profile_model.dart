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
  int? isAgency;
  int? nextQrSerialNo;
  int? isNotification;
String? avatar;
  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    country = json['country'];
    if(json['avatar']!=null){
      avatar = 'https://admin.sinhairvietnam.vn/api${json['avatar']}';
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
    isAgency = json['is_agency'];
    nextQrSerialNo = json['next_qr_serial_no'];
    isNotification = json['is_notification'];
  }
}
