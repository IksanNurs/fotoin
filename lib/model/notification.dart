class NotificationModel {
  String? id;
  String? title;
  String? body;
  String? from;
  String? to;
  bool? isRead;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? elapsedTime;

  NotificationModel(
      {this.id,
      this.title,
      this.body,
      this.from,
      this.to,
      this.isRead,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.elapsedTime});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    from = json['from'];
    to = json['to'];
    isRead = json['isRead'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    elapsedTime = json['elapsedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['from'] = this.from;
    data['to'] = this.to;
    data['isRead'] = this.isRead;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['updatedAt'] = this.updatedAt;
    data['updatedBy'] = this.updatedBy;
    data['elapsedTime'] = this.elapsedTime;
    return data;
  }
}