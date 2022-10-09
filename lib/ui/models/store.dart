class Store {
  int? id;
  String? photo;
  String? banner;
  String? email;
  bool? active;
  bool? freeShipping;
  String? shippingValue;
  String? companyName;
  String? fantasyName;
  int? ownerId;
  String? cNPJ;
  String? ie;
  String? note;
  int? categoryId;
  int? contactId;
  int? addressId;
  int? accountId;
  String? createdAt;
  String? updatedAt;
  int? statusId;
  Category? category;
  Address? address;
  Contact? contact;
  Account? account;

  Store(
      {this.id,
      this.photo,
      this.banner,
      this.email,
      this.active,
      this.freeShipping,
      this.shippingValue,
      this.companyName,
      this.fantasyName,
      this.ownerId,
      this.cNPJ,
      this.ie,
      this.note,
      this.categoryId,
      this.contactId,
      this.addressId,
      this.accountId,
      this.createdAt,
      this.updatedAt,
      this.statusId,
      this.category,
      this.address,
      this.contact,
      this.account});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    banner = json['banner'];
    email = json['email'];
    active = json['active'];
    freeShipping = json['freeShipping'];
    shippingValue = json['shippingValue'];
    companyName = json['companyName'];
    fantasyName = json['fantasyName'];
    ownerId = json['ownerId'];
    cNPJ = json['CNPJ'];
    ie = json['ie'];
    note = json['note'];
    categoryId = json['categoryId'];
    contactId = json['contactId'];
    addressId = json['addressId'];
    accountId = json['accountId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    statusId = json['statusId'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['banner'] = this.banner;
    data['email'] = this.email;
    data['active'] = this.active;
    data['freeShipping'] = this.freeShipping;
    data['shippingValue'] = this.shippingValue;
    data['companyName'] = this.companyName;
    data['fantasyName'] = this.fantasyName;
    data['ownerId'] = this.ownerId;
    data['CNPJ'] = this.cNPJ;
    data['ie'] = this.ie;
    data['note'] = this.note;
    data['categoryId'] = this.categoryId;
    data['contactId'] = this.contactId;
    data['addressId'] = this.addressId;
    data['accountId'] = this.accountId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['statusId'] = this.statusId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    if (this.account != null) {
      data['account'] = this.account!.toJson();
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
  String? state;
  String? cep;
  String? lat;
  String? long;
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
      this.lat,
      this.long,
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
    lat = json['lat'];
    long = json['long'];
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
    data['lat'] = this.lat;
    data['long'] = this.long;
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

class Account {
  int? id;
  String? wallet;
  int? agency;
  int? account;
  int? accountDigit;
  String? key;
  String? createdAt;
  String? updatedAt;

  Account(
      {this.id,
      this.wallet,
      this.agency,
      this.account,
      this.accountDigit,
      this.key,
      this.createdAt,
      this.updatedAt});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wallet = json['wallet'];
    agency = json['agency'];
    account = json['account'];
    accountDigit = json['accountDigit'];
    key = json['key'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wallet'] = this.wallet;
    data['agency'] = this.agency;
    data['account'] = this.account;
    data['accountDigit'] = this.accountDigit;
    data['key'] = this.key;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

