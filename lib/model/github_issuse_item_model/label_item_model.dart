class LabelItemModel{
  int? id;
  String? nodeId;
  String? url;
  String? name;
  String? color;
  bool? labelDefault;
  String? description;

  LabelItemModel({
  this.id,
  this.nodeId,
  this.url,
  this.name,
  this.color,
  this.labelDefault,
  this.description,
  });

  factory LabelItemModel.fromJson(Map<String, dynamic> json){
    return LabelItemModel(
        id:json['id'],
        nodeId: json['node_id'],
        url: json['url'],
        name: json['name'],
        color: json['color'],
        labelDefault: json['default'],
        description: json['description'],
    );
  }
}