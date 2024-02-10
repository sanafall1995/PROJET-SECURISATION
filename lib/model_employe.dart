class Model_employe {
  String? uid;
  String? fullName;
  String? email;
  String? matricule;
  String? statut;
  String? phone;

  Model_employe({
    this.uid,
    this.fullName,
    this.email,
    this.matricule,
    this.statut,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'matricule': matricule,
      'statut': statut,
      'phone': phone,
    };
  }

  factory Model_employe.fromMap(Map<String, dynamic> map) {
    return Model_employe(
      uid: map['uid'],
      fullName: map['fullName'],
      email: map['email'],
      matricule: map['matricule'],
      statut: map['statut'],
      phone: map['phone'],
    );
  }
}
