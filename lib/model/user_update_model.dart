class UserUpdateModel {
  final String updBy, username, password, updDate;
  final int roleId, accountId, disable, waiting;
  String notiToken;

  UserUpdateModel(
      {this.disable,
      this.updBy,
      this.updDate,
      this.accountId,
      this.username,
      this.password,
      this.roleId,
      this.waiting,
      this.notiToken});

  Map<String, dynamic> toJson() => {
        "disabled": disable,
        "updBy": updBy,
        "updDatetime": updDate,
        "accountId": accountId,
        "username": username,
        "password": password,
        "roleId": roleId,
        "waiting": waiting,
        "notiToken": notiToken,
      };
}
