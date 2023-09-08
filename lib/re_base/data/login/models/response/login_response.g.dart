// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      userPhone: json['userPhone'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      'userPhone': instance.userPhone,
      'createdAt': instance.createdAt,
    };
