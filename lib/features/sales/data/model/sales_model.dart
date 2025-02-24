class SalesModel {
  int? salesId;
  DateTime? salesDate;
  int? salesPrice;
  int? salesProfit;
  String? salesCustomer;
  String? salesItemLocation;
  String? salesItemName;
  String? salesItemCarType;
  int? salesItemYear;
  int? itemsId;

  SalesModel({
    this.salesId,
    this.salesDate,
    this.salesPrice,
    this.salesProfit,
    this.salesCustomer,
    this.salesItemLocation,
    this.salesItemName,
    this.salesItemCarType,
    this.salesItemYear,
    this.itemsId,
  });

  // Convert the model to a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sales_id'] = salesId;
    data['sales_date'] =
        salesDate?.toIso8601String(); // Convert DateTime to ISO string
    data['sales_price'] = salesPrice;
    data['sales_profit'] = salesProfit;
    data['sales_customer'] = salesCustomer;
    data['sales_item_location'] = salesItemLocation;
    data['sales_item_name'] = salesItemName;
    data['sales_item_car_type'] = salesItemCarType;
    data['sales_item_year'] = salesItemYear;
    data['items_id'] = itemsId;

    return data;
  }

  // Create a model from a JSON map
  SalesModel.fromJson(Map<String, dynamic> json) {
    salesId = json['sales_id'];
    salesDate =
        json['sales_date'] != null ? DateTime.parse(json['sales_date']) : null;
    salesPrice = json['sales_price'];
    salesProfit = json['sales_profit'];
    salesCustomer = json['sales_customer'];
    salesItemLocation = json['sales_item_location'];
    salesItemName = json['sales_item_name'];
    salesItemCarType = json['sales_item_car_type'];
    salesItemYear = json['sales_item_year'];
    itemsId = json['items_id'];

    // Debugging each field
    print("Parsing sale: $salesId, $salesCustomer, $salesPrice, $salesProfit");
  }
}
