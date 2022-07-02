class Requests {
  int? id;
  int? storeId;
  int? userId;
  int? statusId;
  int? productId;
  int? productFoodId;
  int? addressId;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  int? deliverId;

  Requests(
      {this.id,
      this.storeId,
      this.userId,
      this.statusId,
      this.productId,
      this.productFoodId,
      this.addressId,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.deliverId});

  Requests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['storeId'];
    userId = json['userId'];
    statusId = json['statusId'];
    productId = json['productId'];
    productFoodId = json['productFoodId'];
    addressId = json['addressId'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deliverId = json['deliverId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['storeId'] = this.storeId;
    data['userId'] = this.userId;
    data['statusId'] = this.statusId;
    data['productId'] = this.productId;
    data['productFoodId'] = this.productFoodId;
    data['addressId'] = this.addressId;
    data['quantity'] = this.quantity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deliverId'] = this.deliverId;
    return data;
  }
}
