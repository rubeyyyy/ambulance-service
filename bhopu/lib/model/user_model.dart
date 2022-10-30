class UserModel {
  String? uid;
  String? email;
  String? name;
  String? phonenum;

  UserModel({this.uid, this.email, this.name, this.phonenum});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      phonenum: map['ph_num'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'ph_num': phonenum,
    };
  }
}
