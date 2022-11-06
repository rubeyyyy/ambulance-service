class ComplaintModel {
  String? uid;
  String? email;
  String? name;
  String? against;
  String? complaint;

  ComplaintModel(
      {this.uid, this.email, this.name, this.against, this.complaint});

  // receiving data from server
  factory ComplaintModel.fromMap(map) {
    return ComplaintModel(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        against: map['against'],
        complaint: map['complaint']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'against': against,
      'complaint': complaint,
    };
  }
}
