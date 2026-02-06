// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      token: json['token'] as String,
      userInfo: UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'token': instance.token,
      'userInfo': instance.userInfo,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      avatar: json['avatar'] as String,
      nickName: json['nickName'] as String,
      role: json['role'] as String,
      roleId: (json['roleId'] as num).toInt(),
      roleName: json['roleName'] as String,
      status: json['status'] as bool,
      desc: json['desc'] as String,
      isDeleted: json['isDeleted'] as bool,
      createdTime: DateTime.parse(json['createdTime'] as String),
      updatedTime: DateTime.parse(json['updatedTime'] as String),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'mobile': instance.mobile,
      'avatar': instance.avatar,
      'nickName': instance.nickName,
      'role': instance.role,
      'roleId': instance.roleId,
      'roleName': instance.roleName,
      'status': instance.status,
      'desc': instance.desc,
      'isDeleted': instance.isDeleted,
      'createdTime': instance.createdTime.toIso8601String(),
      'updatedTime': instance.updatedTime.toIso8601String(),
    };
