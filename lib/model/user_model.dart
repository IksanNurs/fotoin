class UserModel {
  String? id;
  String? name;
  String? country;
  String? province;
  String? city;
  String? address;
  String? phoneNumber;
  String? emailConfirmation;
  bool? isAdmin;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  int? countCatalog;
  int? countPorto;
  int? totalReviews;
  String? averageRating;
  int? bookingAccepted;
  int? bookingAppointment;
  int? bookingCanceled;
  int? bookingDone;
  String? userId;

  UserModel(
      {this.id,
      this.name,
      this.country,
      this.province,
      this.city,
      this.address,
      this.phoneNumber,
      this.emailConfirmation,
      this.isAdmin,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.countCatalog,
      this.countPorto,
      this.totalReviews,
      this.averageRating,
      this.bookingAccepted,
      this.bookingAppointment,
      this.bookingCanceled,
      this.bookingDone,
      this.userId});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    province = json['province'];
    city = json['city'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    emailConfirmation = json['email_confirmation'];
    isAdmin = json['is_admin'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    countCatalog = json['countCatalog'];
    countPorto = json['countPorto'];
    totalReviews = json['totalReviews'];
    averageRating = json['averageRating'];
    bookingAccepted = json['bookingAccepted'];
    bookingAppointment = json['bookingAppointment'];
    bookingCanceled = json['bookingCanceled'];
    bookingDone = json['bookingDone'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country'] = this.country;
    data['province'] = this.province;
    data['city'] = this.city;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['email_confirmation'] = this.emailConfirmation;
    data['is_admin'] = this.isAdmin;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['countCatalog'] = this.countCatalog;
    data['countPorto'] = this.countPorto;
    data['totalReviews'] = this.totalReviews;
    data['averageRating'] = this.averageRating;
    data['bookingAccepted'] = this.bookingAccepted;
    data['bookingAppointment'] = this.bookingAppointment;
    data['bookingCanceled'] = this.bookingCanceled;
    data['bookingDone'] = this.bookingDone;
    data['userId'] = this.userId;
    return data;
  }
}