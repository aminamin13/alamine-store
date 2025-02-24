class ProductModel {
  int? id;
  String? carType;
  String? name;
  int? year;
  String? color;
  String? location;
  int? price;
  int? sellPrice;
  String? note;
  DateTime? createdAt;
  int? itemCount;

  ProductModel({
    this.id,
    this.carType,
    this.name,
    this.year,
    this.color,
    this.location,
    this.price,
    this.sellPrice,
    this.note,
    this.createdAt,
    this.itemCount,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['items_id'] = id;
    data['item_car_type'] = carType;
    data['item_name'] = name;
    data['item_year'] = year;
    data['item_color'] = color;
    data['item_location'] = location;
    data['item_price'] = price;
    data['item_sell_price'] = sellPrice;
    data['item_note'] = note;
    data['item_count'] = itemCount;
    if (createdAt != null) {
      data['item_createdAt'] =
          createdAt!.toIso8601String(); // Convert DateTime to ISO string
    }
    return data;
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['items_id'];
    carType = json['item_car_type'];
    name = json['item_name'];
    year = json['item_year'];
    color = json['item_color'];
    location = json['item_location'];
    price = json['item_price'];
    sellPrice = json['item_sell_price'];
    note = json['item_note'];
    itemCount = json['item_count'];

    // Handle DateTime field correctly
    if (json['item_createdAt'] != null) {
      createdAt = DateTime.parse(json['item_createdAt']);
    }

    // Debugging each field
    print("Parsing product:$id, $name, $price, $sellPrice");
  }
  ProductModel copyWith({
    int? id,
    String? carType,
    String? name,
    int? year,
    String? color,
    String? location,
    int? price,
    int? sellPrice,
    String? note,
    int? itemCount,
  }) {
    return ProductModel(
      id: id ?? this.id,
      carType: carType ?? this.carType,
      name: name ?? this.name,
      year: year ?? this.year,
      color: color ?? this.color,
      location: location ?? this.location,
      price: price ?? this.price,
      sellPrice: sellPrice ?? this.sellPrice,
      note: note ?? this.note,
      itemCount: itemCount ?? this.itemCount,
    );
  }
}
