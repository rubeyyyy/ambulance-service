

class UserModel {
  String? uid;
  String? email;
  String? name;
  String? phonenum;
  double Longitude=0;
  double Latitude=0;
  UserModel({this.uid, this.email, this.name, this.phonenum,required this.Longitude, required this.Latitude});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      phonenum: map['ph_num'],
      Longitude: map['Longitude'],
      Latitude: map["Latitude"],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'ph_num': phonenum,
      'Longitude': Longitude,
      'Latitude': Latitude,
    };
  }
}
