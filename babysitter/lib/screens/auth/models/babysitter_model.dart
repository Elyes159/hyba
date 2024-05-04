class BabysitterModel {
  final String id;
  final String nom;
  final String prenom;
  final String email;
  final String password;
  final String phone;
  final String description;
  final String accepte;

  BabysitterModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.phone,
    required this.description,
    required this.accepte,
  });

  factory BabysitterModel.fromJson(Map<String, dynamic> json) {
    return BabysitterModel(
      id: json['_id'] ?? '',
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      description: json['description'] ?? '',
      accepte: json['accepte'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "password": password,
        "phone": phone,
        "description,": description,
        "accepte": accepte,
      };
}
