class UserModel {
  String name;
  String uid;
  String pfp;
  String phoneNumber;

  UserModel({
    required this.name,
    required this.uid,
    required this.pfp,
    required this.phoneNumber,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      uid: map['uid'],
      pfp: map['pfp'],
      phoneNumber: map['phoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "uid": uid,
      "phoneNumber": phoneNumber,
      "pfp": pfp,
    };
  }
}
