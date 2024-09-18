class StoreModal {
  String? id;
  String? userId;
  String? companyName;
  String? cameraPhoto;
  String? experience;
  String? cameraUsed;
  String? phoneNumber;
  String? country;
  String? province;
  String? city;
  String? address;

  StoreModal(
      {this.id,
      this.userId,
      this.companyName,
      this.cameraPhoto,
      this.experience,
      this.cameraUsed,
      this.phoneNumber,
      this.country,
      this.province,
      this.city,
      this.address});

  StoreModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    companyName = json['companyName'];
    cameraPhoto = json['cameraPhoto'];
    experience = json['experience'];
    cameraUsed = json['cameraUsed'];
    phoneNumber = json['phoneNumber'];
    country = json['country'];
    province = json['province'];
    city = json['city'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['companyName'] = this.companyName;
    data['cameraPhoto'] = this.cameraPhoto;
    data['experience'] = this.experience;
    data['cameraUsed'] = this.cameraUsed;
    data['phoneNumber'] = this.phoneNumber;
    data['country'] = this.country;
    data['province'] = this.province;
    data['city'] = this.city;
    data['address'] = this.address;
    return data;
  }
}