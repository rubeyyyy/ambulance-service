class ServiceModel {
  String? uid;
  String? email;
  String? name;
  String? phonenum;
  String? Ambnum;
  String? type;

  ServiceModel(
      {this.uid, this.email, this.name, this.phonenum, this.Ambnum, this.type});

  // receiving data from server
  factory ServiceModel.fromMap(map) {
    return ServiceModel(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        phonenum: map['ph_num'],
        Ambnum: map['amb_num'],
        type: map['type']);
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
    };
  }
}
