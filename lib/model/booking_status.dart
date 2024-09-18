import 'package:fotoin/model/catalog.dart';

class BookingStatus {
  String? id;
  String? catalogId;
  String? userBookingId;
  String? ownerId;
  String? status;
  CustomerInformation? customerInformation;
  Catalog? catalog;

  BookingStatus(
      {this.id,
      this.catalogId,
      this.userBookingId,
      this.ownerId,
      this.status,
      this.customerInformation,
      this.catalog});

  BookingStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catalogId = json['catalogId'];
    userBookingId = json['userBookingId'];
    ownerId = json['ownerId'];
    status = json['status'];
    customerInformation = json['customerInformation'] != null
        ? new CustomerInformation.fromJson(json['customerInformation'])
        : null;
    catalog =
        json['catalog'] != null ? new Catalog.fromJson(json['catalog']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['catalogId'] = this.catalogId;
    data['userBookingId'] = this.userBookingId;
    data['ownerId'] = this.ownerId;
    data['status'] = this.status;
    if (this.customerInformation != null) {
      data['customerInformation'] = this.customerInformation!.toJson();
    }
    if (this.catalog != null) {
      data['catalog'] = this.catalog!.toJson();
    }
    return data;
  }
}

class CustomerInformation {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? day;
  String? time;

  CustomerInformation(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.day,
      this.time});

  CustomerInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    day = json['day'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['day'] = this.day;
    data['time'] = this.time;
    return data;
  }
}

