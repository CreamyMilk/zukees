class TenantData {
  String name;
  String houseNo;
  int rentDue;
  String paymentStatus;

  TenantData({this.name, this.houseNo, this.rentDue, this.paymentStatus});

  TenantData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    houseNo = json['houseNo'];
    rentDue = json['rentDue'];
    paymentStatus = json['paymentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['houseNo'] = this.houseNo;
    data['rentDue'] = this.rentDue;
    data['paymentStatus'] = this.paymentStatus;
    return data;
  }
}


// [
//     {
//         "name": "j",
//         "houseNo": "a2",
//         "rentDue": 3000,
//         "paymentStatus": "paid"
//     }
// ]