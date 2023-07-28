class UserLogin {
  String? uuid;
  String? displayName;
  String? userName;
  String? password;
  String? photoURL;
  UserLogin({
    this.uuid,
    this.displayName,
    this.userName,
    this.password,
    this.photoURL
  });

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'userName': userName,
        'photoURL': photoURL,
      };
}
