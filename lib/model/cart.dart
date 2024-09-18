
import 'package:fotoin/model/catalog.dart';
import 'package:fotoin/model/user_model.dart';

class CartModel {
  String? id;
  int? type;
  bool? statusData;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  UserModel? user;
  Catalog? catalog;

  CartModel(
      {this.id,
      this.type,
      this.statusData,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.user,
      this.catalog});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    statusData = json['statusData'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    catalog =
        json['catalog'] != null ? new Catalog.fromJson(json['catalog']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['statusData'] = this.statusData;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.catalog != null) {
      data['catalog'] = this.catalog!.toJson();
    }
    return data;
  }
}

