class UpdateUserModel {
  final String updBy, updDatetime, username, password;
  final int disable, accountId, roleId, profileId, waiting;

  UpdateUserModel(
      {this.disable,
      this.updBy,
      this.updDatetime,
      this.accountId,
      this.username,
      this.password,
      this.roleId,
      this.profileId,
      this.waiting});

  Map<String, dynamic> toJson() => {
        "disable": disable,
        "updBy": updBy,
        "updDatetime": updDatetime,
        "accountId": accountId,
        "username": username,
        "password": password,
        "roleId": roleId,
        "profileId": profileId,
        "waiting": waiting,
      };
}
