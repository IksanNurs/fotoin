
import 'package:fotoin/model/catalog.dart';

class Gallery {
  String? id;
  String? path;

  Gallery({this.id, this.path});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    return data;
  }
}

class ProtofolioModel {
  String? id;
  String? title;
  String? tags;
  String? ownerId;
  List<Gallery>? gallery;
  Category? category;

  ProtofolioModel({this.id, this.title, this.tags, this.ownerId, this.gallery});

  ProtofolioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    tags = json['tags'];
    ownerId = json['ownerId'];
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery.fromJson(v));
      });
    };
       category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['tags'] = this.tags;
    data['ownerId'] = this.ownerId;
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

