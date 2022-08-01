class AcceptRequestModel {
  int? statusId;
  int? statusSendId;
  int? userDeliverId;
  int? storeId;
  int? productId;
  int? productFoodId;
  int? requestId;

  AcceptRequestModel(
      {this.productFoodId,
      this.productId,
      this.statusId,
      this.statusSendId,
      this.storeId,
      this.userDeliverId,
      this.requestId,
      });
}
