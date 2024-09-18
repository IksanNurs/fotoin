class WalletModel {
  String? id;
  String? type;
  String? status;
  String? amount;
  String? proofLink;
  String? method;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  WalletModel(
      {this.id,
      this.type,
      this.status,
      this.amount,
      this.proofLink,
      this.method,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy});

  WalletModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    amount = json['amount'];
    proofLink = json['proofLink'];
    method = json['method'];
    accountName = json['accountName'];
    accountNumber = json['accountNumber'];
    bankName = json['bankName'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    data['amount'] = this.amount;
    data['proofLink'] = this.proofLink;
    data['method'] = this.method;
    data['accountName'] = this.accountName;
    data['accountNumber'] = this.accountNumber;
    data['bankName'] = this.bankName;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}