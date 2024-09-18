class Catalog {
  String? id;
  String? title;
  String? price;
  String? description;
  String? availableDate;
  String? location;
  String? ownerId;
  bool? statusData;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  List<Gallery>? gallery;
  Category? category;
  List<Reviews>? reviews;
  Portofolio? portofolio;
  Owner? owner;
  String? averageRating;

  Catalog(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.availableDate,
      this.location,
      this.ownerId,
      this.statusData,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.gallery,
      this.category,
      this.reviews,
      this.portofolio,
      this.owner,
      this.averageRating});

  Catalog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    availableDate = json['availableDate'];
    location = json['location'];
    ownerId = json['ownerId'];
    statusData = json['statusData'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery.fromJson(v));
      });
    }
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    portofolio = json['portofolio'] != null
        ? new Portofolio.fromJson(json['portofolio'])
        : null;
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    averageRating = json['averageRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['availableDate'] = this.availableDate;
    data['location'] = this.location;
    data['ownerId'] = this.ownerId;
    data['statusData'] = this.statusData;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    if (this.portofolio != null) {
      data['portofolio'] = this.portofolio!.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['averageRating'] = this.averageRating;
    return data;
  }
}

class Gallery {
  String? id;
  String? imageUrl;

  Gallery({this.id, this.imageUrl});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? description;

  Category({this.id, this.name, this.description});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

class Reviews {
  String? id;
  int? rating;
  String? text;
  String? photo;
  String? createdAt;
  String? updatedAt;
  Reviewer? reviewer;

  Reviews(
      {this.id,
      this.rating,
      this.text,
      this.photo,
      this.createdAt,
      this.updatedAt,
      this.reviewer});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    text = json['text'];
    photo = json['photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reviewer = json['reviewer'] != null
        ? new Reviewer.fromJson(json['reviewer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['text'] = this.text;
    data['photo'] = this.photo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.reviewer != null) {
      data['reviewer'] = this.reviewer!.toJson();
    }
    return data;
  }
}

class Reviewer {
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

  Reviewer(
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
      this.updatedBy});

  Reviewer.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Portofolio {
  String? id;
  String? title;
  String? ownerId;
  List<Gallery1>? gallery;

  Portofolio({this.id, this.title, this.ownerId, this.gallery});

  Portofolio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    ownerId = json['ownerId'];
    if (json['gallery'] != null) {
      gallery = <Gallery1>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['ownerId'] = this.ownerId;
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gallery1 {
  String? id;
  String? path;
  String? portfolioId;

  Gallery1({this.id, this.path, this.portfolioId});

  Gallery1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    portfolioId = json['portfolioId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    data['portfolioId'] = this.portfolioId;
    return data;
  }
}

class Owner {
  String? userId;
  String? companyName;

  Owner({this.userId, this.companyName});

  Owner.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['company_name'] = this.companyName;
    return data;
  }
}