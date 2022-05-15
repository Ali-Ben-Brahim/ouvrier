class User {
  int? id;
  String? nom;
  String? prenom;
  String? email;
  String? cin;
  String? zoneTravailId;
  String? camionId;
  String? poste;
  String? numeroTelephone;
  String? adresse;
  String? token;
  User(
      {this.id,
      this.nom,
      this.cin,
      this.zoneTravailId,
      this.camionId,
      this.poste,
      this.email,
      this.numeroTelephone,
      this.adresse,
      this.token});

  User.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    zoneTravailId = json['zone_travail_id'].toString();
    camionId = json['camion_id'].toString();
    nom = json['nom'].toString();
    prenom = json['prenom'].toString();
    email = json['email'].toString();
    cin = json['CIN'].toString();
    poste = json['poste'].toString();
    numeroTelephone = json['numero_telephone'].toString();
    adresse = json['adresse'].toString();
    email = json['email'].toString();
  }

  // Map<String, dynamic> toJson() {
  // 	final Map<String, dynamic> data = Map<String, dynamic>();
  // 	data['id'] = this.id;
  // 	data['name'] = this.name;
  // 	data['email'] = this.email;
  // 	return data;
  // }
}
