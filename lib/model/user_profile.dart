class UserProfile {
  int profileId;
  String fullName, birthday, gender, phone, image, email, idCard;

  UserProfile(
      {this.profileId,
      this.fullName,
      this.birthday,
      this.gender,
      this.phone,
      this.image,
      this.email,
      this.idCard});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        profileId: json['profileId'] as int,
        fullName: json['fullName'] as String,
        birthday: json['birthday'] as String,
        gender: json['gender'] as String,
        phone: json['phone'] as String,
        image: json['image'] as String,
        email: json['email'] as String,
        idCard: json['idCard'] as String);
  }

  Map<String, dynamic> toJson() => {
        "profileId": profileId,
        "fullName": fullName,
        "birthday": birthday,
        "gender": gender,
        "phone": phone,
        "image": image,
        "email": email,
        "idCard": idCard
      };
}
