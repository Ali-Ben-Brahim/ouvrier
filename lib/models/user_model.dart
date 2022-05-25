class UserModel {
  int? id;
  String? nom_entreprise;
  String? matricule_fiscale;
  String? nom_responsable;
  String? numero_fixe;
  String? adresse;
  String? numero_telephone;
  String? email;

  UserModel({this.id, this.nom_entreprise, this.matricule_fiscale, this.nom_responsable, this.adresse,this.numero_telephone, this.email, this.numero_fixe});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom_entreprise = json['nom_entreprise'].toString();
    matricule_fiscale = json['matricule_fiscale'].toString();
    nom_responsable = json['nom_responsable'].toString();
    numero_fixe = json['numero_fixe'].toString();
    adresse = json['adresse'].toString();
    numero_telephone = json['numero_telephone'].toString();
    email = json['email'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom_entreprise'] = this.nom_entreprise;
    data['matricule_fiscale'] = this.matricule_fiscale;
    data['nom_responsable'] = this.nom_responsable;
    data['numero_fixe'] = this.numero_fixe;
    data['adresse'] = this.adresse;
    data['numero_telephone'] = this.numero_telephone;
    data['email'] = this.email;
    return data;
  }
}