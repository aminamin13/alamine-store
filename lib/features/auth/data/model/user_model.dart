class UserModel {
  int? usersId;
  String? usersName;
  String? usersUsername;
  String? usersPassword;

  UserModel(
      {this.usersId, this.usersName, this.usersUsername, this.usersPassword});

  UserModel.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    usersName = json['users_name'];
    usersUsername = json['users_username'];
    usersPassword = json['users_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['users_id'] = usersId;
    data['users_name'] = usersName;
    data['users_username'] = usersUsername;
    data['users_password'] = usersPassword;
    return data;
  }
}
