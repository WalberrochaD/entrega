class UserBuyer {
  int? id;
  String? email;
  String? cpf;
  String? name;
  String? cep;
  String? customerId;
  String? photo;

  UserBuyer(
      {this.id,
      this.email,
      this.cpf,
      this.name,
      this.cep,
      this.customerId,
      this.photo});

  UserBuyer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    cpf = json['cpf'];
    name = json['name'];
    cep = json['cep'];
    customerId = json['customerId'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['cpf'] = this.cpf;
    data['name'] = this.name;
    data['cep'] = this.cep;
    data['customerId'] = this.customerId;
    data['photo'] = this.photo;
    return data;
  }
}

