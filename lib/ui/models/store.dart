class Store {
  int? id;
  String? photo;
  String? banner;
  String? email;
  bool? active;
  String? companyName;
  String? fantasyName;
  String? cNPJ;
  String? ie;
  String? note;
  int? categoryId;
  int? contactId;
  int? addressId;
  String? createdAt;
  String? updatedAt;
  int? statusId;
  int? ownerId;
  Category? category;
  Address? address;
  Contact? contact;

  Store(
      {this.id,
      this.photo,
      this.banner,
      this.email,
      this.active,
      this.companyName,
      this.fantasyName,
      this.cNPJ,
      this.ie,
      this.note,
      this.categoryId,
      this.contactId,
      this.addressId,
      this.createdAt,
      this.updatedAt,
      this.statusId,
      this.ownerId,
      this.category,
      this.address,
      this.contact});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    banner = json['banner'];
    email = json['email'];
    active = json['active'];
    companyName = json['companyName'];
    fantasyName = json['fantasyName'];
    cNPJ = json['CNPJ'];
    ie = json['ie'];
    note = json['note'];
    categoryId = json['categoryId'];
    contactId = json['contactId'];
    addressId = json['addressId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    statusId = json['statusId'];
    ownerId = json['ownerId'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['banner'] = this.banner;
    data['email'] = this.email;
    data['active'] = this.active;
    data['companyName'] = this.companyName;
    data['fantasyName'] = this.fantasyName;
    data['CNPJ'] = this.cNPJ;
    data['ie'] = this.ie;
    data['note'] = this.note;
    data['categoryId'] = this.categoryId;
    data['contactId'] = this.contactId;
    data['addressId'] = this.addressId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['statusId'] = this.statusId;
    data['ownerId'] = this.ownerId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? category;

  Category({this.id, this.category});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    return data;
  }
}

class Address {
  int? id;
  String? street;
  int? number;
  String? district;
  String? city;
  Null? state;
  Null? cep;
  String? createdAt;
  String? updatedAt;

  Address(
      {this.id,
      this.street,
      this.number,
      this.district,
      this.city,
      this.state,
      this.cep,
      this.createdAt,
      this.updatedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    street = json['street'];
    number = json['number'];
    district = json['district'];
    city = json['city'];
    state = json['state'];
    cep = json['cep'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['street'] = this.street;
    data['number'] = this.number;
    data['district'] = this.district;
    data['city'] = this.city;
    data['state'] = this.state;
    data['cep'] = this.cep;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Contact {
  int? id;
  String? number;
  String? createdAt;
  String? updatedAt;

  Contact({this.id, this.number, this.createdAt, this.updatedAt});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
