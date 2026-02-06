import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class LoginData {
  final String token;
  final UserInfo userInfo;

  LoginData({required this.token, required this.userInfo});

  // json_serializable 自动生成的解析方法
  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

@JsonSerializable()
class UserInfo {
  final int id;
  final String username;
  final String email;
  final String mobile;
  final String avatar;
  final String nickName;
  final String role;
  final int roleId;
  final String roleName;
  final bool status;
  final String desc;
  final bool isDeleted;
  final DateTime createdTime;
  final DateTime updatedTime;

  UserInfo({
    required this.id,
    required this.username,
    required this.email,
    required this.mobile,
    required this.avatar,
    required this.nickName,
    required this.role,
    required this.roleId,
    required this.roleName,
    required this.status,
    required this.desc,
    required this.isDeleted,
    required this.createdTime,
    required this.updatedTime,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
