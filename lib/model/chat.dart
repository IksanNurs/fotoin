class ChatModel {
  UserReceiver? userReceiver;
  List<Chat>? chat;

  ChatModel({this.userReceiver, this.chat});

  ChatModel.fromJson(Map<String, dynamic> json) {
    userReceiver = json['userReceiver'] != null
        ? new UserReceiver.fromJson(json['userReceiver'])
        : null;
    if (json['chat'] != null) {
      chat = <Chat>[];
      json['chat'].forEach((v) {
        chat!.add(new Chat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userReceiver != null) {
      data['userReceiver'] = this.userReceiver!.toJson();
    }
    if (this.chat != null) {
      data['chat'] = this.chat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserReceiver {
  String? id;
  String? name;
  String? province;
  String? city;

  UserReceiver({this.id, this.name, this.province, this.city});

  UserReceiver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    province = json['province'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['province'] = this.province;
    data['city'] = this.city;
    return data;
  }
}

class Chat {
  String? id;
  String? text;
  String? createdAt;
  String? position;
  bool? isRead;

  Chat({this.id, this.text, this.createdAt, this.position, this.isRead});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    createdAt = json['createdAt'];
    position = json['position'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['createdAt'] = this.createdAt;
    data['position'] = this.position;
    data['isRead'] = this.isRead;
    return data;
  }
}