// ignore_for_file: public_member_api_docs, sort_constructors_first
class ExpensesModel {
  int? id;
  String? name;
  String? location;
  String? note;
  DateTime? date;
  int? price;
  ExpensesModel({
    this.id,
    this.name,
    this.location,
    this.note,
    this.date,
    this.price,
  });

  ExpensesModel.fromJson(Map<String, dynamic> json) {
    id = json['expenses_id'];
    name = json['expenses_name'];
    location = json['expenses_location'];
    note = json['expenses_note'];
    date = DateTime.parse(json['expenses_date']);
    price = json['expenses_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expenses_id'] = id;
    data['expenses_name'] = name;
    data['expenses_location'] = location;
    data['expenses_note'] = note;
    data['expenses_date'] = date.toString();
    data['expenses_price'] = price;
    return data;
  }
}
