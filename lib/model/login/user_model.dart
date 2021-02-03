class UserModel {
  final String token, userName, expiration, role;
  final int userId, profileId;
  final bool waiting;

  UserModel({
    this.expiration,
    this.profileId,
    this.token,
    this.userId,
    this.userName,
    this.role,
    this.waiting,
  });

  Map<String, dynamic> toJson() => {
        "phoneNumber": this.userName,
        "roleID": this.role,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] as String,
      profileId: json['profileId'] as int,
      expiration: json['expiration'] as String,
      userId: json['userId'] as int,
      role: json['role'] as String,
      userName: json['phone'] as String,
      waiting: json['waiting'] as bool,
    );
  }
}
