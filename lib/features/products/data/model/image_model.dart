class ImageModel {
  int? imageId;
  int? itemsId;
  String? imageUrl;

  ImageModel({
    this.imageId,
    this.itemsId,
    this.imageUrl,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    itemsId = json['items_id'];
    imageUrl = json['image_url'];
  }

  // Convert ImageModel instance to a Map (for inserting into database)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['image_id'] = imageId;
    data['items_id'] = itemsId;
    data['image_url'] = imageUrl;
    return data;
  }

  // Override toString() for easy debugging
  @override
  String toString() {
    return 'ImageModel(imageId: $imageId, itemsId: $itemsId, imageUrl: $imageUrl)';
  }
}
