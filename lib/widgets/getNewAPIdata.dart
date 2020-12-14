Future<void> getLatestTrans() async {
  Future.delayed(Duration(seconds: 3));
  // PaymentUpdateModel data;
  // String transaction;
  // var userBox = Hive.box('user');
  // final prefs = await SharedPreferences.getInstance();
  // var uid = userBox.get("uid", defaultValue: 0);
  // if (uid != 0) {
  //   final response = await http.post(
  //     ("https://auth.i-crib.co.ke/" + "getnewtrans"),
  //     headers: {
  //       "Accept": "application/json",
  //       "content-type": "application/json",
  //     },
  //     body: jsonEncode(
  //       {
  //         'uid': uid, //mobile,
  //       },
  //     ),
  //   );
  //   var myjson = json.decode(response.body);
  //   data = PaymentUpdateModel.fromJson(myjson);
  //   userBox.put("rent", data.rent.toJson());
  //   transaction = jsonEncode(data.transaction.toJson());
  //   userBox.put("transaction", transaction); //lastIssue
  //   userBox.put("lastIssue", myjson["lastIssue"]);
  //   prefs.setString("user_transactions", transaction);
  //   print("Transactions Added");
  // }
}
