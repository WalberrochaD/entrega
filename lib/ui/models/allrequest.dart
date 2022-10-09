class AllRequestModel {
  String? createdAt;
  String? updatedAt;
  Requests? requests;
  List<Products>? products;
  List<ProductsFood>? productsFood;

  AllRequestModel(
      {this.createdAt,
      this.updatedAt,
      this.requests,
      this.products,
      this.productsFood});

  AllRequestModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    requests = json['requests'] != null
        ? new Requests.fromJson(json['requests'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['productsFood'] != null) {
      productsFood = <ProductsFood>[];
      json['productsFood'].forEach((v) {
        productsFood!.add(new ProductsFood.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.requests != null) {
      data['requests'] = this.requests!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.productsFood != null) {
      data['productsFood'] = this.productsFood!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Requests {
  int? id;
  int? storeId;
  int? userId;
  int? statusId;
  int? addressId;
  int? quantity;
  int? deliverId;
  int? value;
  String? createdAt;
  String? updatedAt;
  Address? address;

  Requests(
      {this.id,
      this.storeId,
      this.userId,
      this.statusId,
      this.addressId,
      this.quantity,
      this.deliverId,
      this.value,
      this.createdAt,
      this.updatedAt,
      this.address});

  Requests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['storeId'];
    userId = json['userId'];
    statusId = json['statusId'];
    addressId = json['addressId'];
    quantity = json['quantity'];
    deliverId = json['deliverId'];
    value = json['value'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['storeId'] = this.storeId;
    data['userId'] = this.userId;
    data['statusId'] = this.statusId;
    data['addressId'] = this.addressId;
    data['quantity'] = this.quantity;
    data['deliverId'] = this.deliverId;
    data['value'] = this.value;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
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

class Products {
  int? id;
  String? name;
  String? description;
  String? code;
  String? photo;
  String? weight;
  int? stock;
  int? price;
  bool? active;
  int? saleOff;
  int? storeId;
  String? createdAt;
  String? updatedAt;

  Products(
      {this.id,
      this.name,
      this.description,
      this.code,
      this.photo,
      this.weight,
      this.stock,
      this.price,
      this.active,
      this.saleOff,
      this.storeId,
      this.createdAt,
      this.updatedAt});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    code = json['code'];
    photo = json['photo'];
    weight = json['weight'];
    stock = json['stock'];
    price = json['price'];
    active = json['active'];
    saleOff = json['saleOff'];
    storeId = json['storeId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['code'] = this.code;
    data['photo'] = this.photo;
    data['weight'] = this.weight;
    data['stock'] = this.stock;
    data['price'] = this.price;
    data['active'] = this.active;
    data['saleOff'] = this.saleOff;
    data['storeId'] = this.storeId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ProductsFood {
  int? id;
  String? name;
  String? description;
  String? code;
  String? photo;
  int? price;
  bool? active;
  dynamic saleOff;
  int? categoryProductId;
  int? storeId;
  String? createdAt;
  String? updatedAt;
  Category? category;

  ProductsFood(
      {this.id,
      this.name,
      this.description,
      this.code,
      this.photo,
      this.price,
      this.active,
      this.saleOff,
      this.categoryProductId,
      this.storeId,
      this.createdAt,
      this.updatedAt,
      this.category});

  ProductsFood.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    code = json['code'];
    photo = json['photo'];
    price = json['price'];
    active = json['active'];
    saleOff = json['saleOff'];
    categoryProductId = json['categoryProductId'];
    storeId = json['storeId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['code'] = this.code;
    data['photo'] = this.photo;
    data['price'] = this.price;
    data['active'] = this.active;
    data['saleOff'] = this.saleOff;
    data['categoryProductId'] = this.categoryProductId;
    data['storeId'] = this.storeId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? category;
  String? iconUrl;
  int? typeProduct;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.category,
      this.iconUrl,
      this.typeProduct,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    iconUrl = json['iconUrl'];
    typeProduct = json['typeProduct'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['iconUrl'] = this.iconUrl;
    data['typeProduct'] = this.typeProduct;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

