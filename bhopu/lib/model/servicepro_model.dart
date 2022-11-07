class ServiceModel {
  String? uid;
  String? email;
  String? name;
  String? phonenum;
  String? Ambnum;
  String? type;
  double Longitude=0;
  double Latitude=0;
  ServiceModel({this.uid, this.email, this.name, this.phonenum, this.type, this.Ambnum,required this.Longitude, required this.Latitude});

  // receiving data from server
  factory ServiceModel.fromMap(map) {
    return ServiceModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      type: map['type'],
      phonenum: map['ph_num'],
      Ambnum: map['amb_num'],
      Longitude: map['Longitude'],
      Latitude: map["Latitude"],);

  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'ph_num': phonenum,
      'amb_num': Ambnum,
      'type': type,
      'Longitude': Longitude,
      'Latitude': Latitude,
    };
  }
}