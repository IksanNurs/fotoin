class GroupChat {
  String? userId;
  String? chatPartnerName;
  String? text;
  String? createdAt;

  GroupChat({this.userId, this.chatPartnerName, this.text, this.createdAt});

  GroupChat.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    chatPartnerName = json['chatPartnerName'];
    text = json['text'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['chatPartnerName'] = this.chatPartnerName;
    data['text'] = this.text;
    data['createdAt'] = this.createdAt;
    return data;
  }
}