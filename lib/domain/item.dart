class Items {
  String itemImage;
  String itemMass;
  int itemCost;
  int itemAmount;
  String itemName;
  Items(
      {this.itemCost,
      this.itemImage,
      this.itemMass,
      this.itemName,
      this.itemAmount});

  Items.fromJson(Map<String, dynamic> json) {
    itemCost = json["itemCost"];
    itemImage = json["itemImage"];
    itemMass = json["itemMass"];
    itemName = json["itemName"];
    itemAmount = json["itemAmount"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["itemCost"] = this.itemCost;
    data["itemImage"] = this.itemImage;
    data["itemMass"] = this.itemMass;
    data["itemName"] = this.itemName;
    data["itemAmount"] = this.itemAmount;
    return data;
  }
}
