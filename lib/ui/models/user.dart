class UserModel {
  String? email;
  String? password;
  String? name;
  String? cpf;
  String? cnh;
  String? dataNc;
  String? tel;
  String? cep;

  UserModel({
    this.cnh,
    this.cpf,
    this.dataNc,
    this.email,
    this.name,
    this.password,
    this.tel,
    this.cep,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "confirmPassword": password,
        "CNH": cnh,
        "NCDate": dataNc,
        "cpf": cpf,
        "name": name,
        "cep": cep
      };
}
