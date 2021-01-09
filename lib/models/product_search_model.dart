class ProductSearchModel {
  int message;
  List<Data> data;

  ProductSearchModel({this.message, this.data});

  ProductSearchModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int productId;
  int categoryId;
  String productName;
  String productImage;
  String productImageLarge;
  String descriptions;
  int amount;
  int stock;
  String productPacktype;

  Data(
      {this.productId,
      this.categoryId,
      this.productName,
      this.productImage,
      this.productImageLarge,
      this.descriptions,
      this.amount,
      this.stock,
      this.productPacktype});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    categoryId = json['category_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    productImageLarge = json['product_image_large'];
    descriptions = json['descriptions'];
    amount = json['amount'];
    stock = json['stock'];
    productPacktype = json['product_packtype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['category_id'] = this.categoryId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['product_image_large'] = this.productImageLarge;
    data['descriptions'] = this.descriptions;
    data['amount'] = this.amount;
    data['stock'] = this.stock;
    data['product_packtype'] = this.productPacktype;
    return data;
  }
}
