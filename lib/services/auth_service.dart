import 'dart:convert';
import 'dart:io';
import 'package:fotoin/model/booking_status.dart';
import 'package:fotoin/model/catalog.dart';
import 'package:fotoin/model/chat.dart';
import 'package:fotoin/model/group_chat.dart';
import 'package:fotoin/model/notification.dart';
import 'package:fotoin/model/protofolio.dart';
import 'package:fotoin/model/request.dart';
import 'package:fotoin/model/store.dart';
import 'package:fotoin/model/user_model.dart';
import 'package:fotoin/model/cart.dart';
import 'package:fotoin/model/wallet.dart';
import 'package:fotoin/model/wallet_admin.dart';
import 'package:fotoin/session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:tuple/tuple.dart';

class AuthService {
  String UrlBase = 'http://fotoin.biz.id';

 Future login({
    String? email,
    String? password,
  }) async {
    var url = '$UrlBase/auth/login';
    var header = {
      'Content-Type': 'application/json',
    };

    var body = jsonEncode(
      {
        'email': email,
        'password': password,
      },
    );

    print(body);

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 201) {
      var token = jsonDecode(response.body)['token'];
      var url1 = '$UrlBase/profile-user';
    var header1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token
    };

    var response1 = await http.get(Uri.parse(url1), headers: header1);
      // user.id = data['user']['id'];


       session.saveSession(token,  int.parse(jsonDecode(response1.body)['data']['userId']));
      return null;
    } else {
      var data = jsonDecode(response.body);

      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }

  Future register({
    String? email,
    String? password,
  }) async {
    var url = '$UrlBase/auth/sign-up';
    var header = {
      'Content-Type': 'application/json',
    };

    var body = jsonEncode(
      {
        'email': email,
        'password': password,
      },
    );

    print(body);

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 201) {
      return null;
    } else {
      var data = jsonDecode(response.body);

      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }

  Future verifyAccount({
    String? email,
    int? code,
  }) async {
    var url = '$UrlBase/auth/verify-account';
    var header = {
      'Content-Type': 'application/json',
    };

    var body = jsonEncode(
      {
        'email': email,
        'verificationCode': code,
      },
    );

    print(body);

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 201) {
      return null;
    } else {
      var data = jsonDecode(response.body);

      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }


   Future forgot({
    String? email
  }) async {
    var url = '$UrlBase/auth/forgot-password';
    var header = {
      'Content-Type': 'application/json',
    };

    var body = jsonEncode(
      {
        'email': email
      },
    );

    print(body);

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 201) {
      return null;
    } else {
      var data = jsonDecode(response.body);

      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }


   Future change({
    String? password,
    int? code
  }) async {
    var url = '$UrlBase/auth/reset-password';
    var header = {
      'Content-Type': 'application/json',
    };

    var body = jsonEncode(
      {
  'newPassword':password,
  'resetToken': code
    }
    );

    print(body);

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 201) {
      return null;
    } else {
      var data = jsonDecode(response.body);

      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }

   Future<UserModel> getProfile() async {
    var url = '$UrlBase/profile-user';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    print(await session.getSession());
    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data: ${response.body}');

    if (response.statusCode == 200) {
    
      var data = jsonDecode(response.body)['data'];
      print(data);
      UserModel user = UserModel.fromJson(data);

      return user;
    } else {
      throw Exception('Failed to load');
    }
  }

   Future createStore({
    required String companyName,
    required String experience,
    required String phoneNumber,
    required String country,
    required String province,
    required String city,
    required String address,
    required String cameraUsed,
    required List<File> images,
  }) async {
     try {
      final String token = await session.getSession();
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    final Uri uri = Uri.parse('$UrlBase/stores');
    final http.MultipartRequest request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields['name'] = "deprecated"
      ..fields['companyName'] = companyName
      ..fields['experience'] = experience
      ..fields['phoneNumber'] = phoneNumber
      ..fields['country'] = country
      ..fields['province'] = province
      ..fields['city'] = city
      ..fields['address'] = address
      ..fields['cameraUsed'] = cameraUsed;

    for (var image in images) {
      // Determine the file extension and set content type accordingly
      final fileExtension = image.path.split('.').last.toLowerCase();
      final contentType = fileExtension == 'png' 
        ? MediaType('image', 'png')
        : MediaType('image', 'jpeg');

      request.files.add(await http.MultipartFile.fromPath(
        'cameraPhoto', // Ensure this matches what the server expects
        image.path,
        contentType: contentType,
      ));
    }

    final http.StreamedResponse response = await request.send();
    final http.Response responseData = await http.Response.fromStream(response);

   if (response.statusCode == 201) {
      return true; // Success
    } else {
      print('Error: ${response.statusCode} - ${responseData.body}');
      return false; // Failure
    }
     } catch (e, stackTrace) {
    // Log the error and stack trace for better debugging
    print('Error while creating portfolio: $e');
    print('Stack trace: $stackTrace');
    return false; // Indicate failure
  }
  }



  Future createCatalog({
    required String title,
    required String description,
    required String price,
    required String tag,
    required String location,
    required String category_id,
    required String availableDate,
    required List<File> images,
    required String protofolioid,
  }) async {
    var url = '$UrlBase/catalog';
    var header = {
      'Content-Type':'multipart/form-data',
      'Authorization': 'Bearer ' + await session.getSession(),
    };

    print(await session.getSession());
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers.addAll(header)
      ..fields['title'] = title
      ..fields['description'] = description
      ..fields['price'] = price
      ..fields['tags'] = tag
      ..fields['location'] = location
      ..fields['availableDate'] = availableDate
      ..fields['categoryId'] = category_id
      ..fields['portofolioId'] = protofolioid;

 print(request);
    // Add images to the request
   for (var image in images) {
      // Determine the file extension and set content type accordingly
      final fileExtension = image.path.split('.').last.toLowerCase();
      final contentType = fileExtension == 'png' 
        ? MediaType('image', 'png')
        : MediaType('image', 'jpeg');

      request.files.add(await http.MultipartFile.fromPath(
        'uploads', // Ensure this matches what the server expects
        image.path,
        contentType: contentType,
      ));
    }

    print(request);

    print('Request body: ${request.fields}');
    
    var response = await request.send();

    // Check response status
    var responseData = await http.Response.fromStream(response);
    print('Catalog creation response: ${responseData.body}');
     print(await session.getSession());
    if (responseData.statusCode == 201) {
      return null;
    } else {
    
      return null;
    }
  }
  Future<bool> createPortfolio({
  required String title,
  required String category_id,
  required List<File> images,
}) async {
  try {
    final String token = await session.getSession();
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    final Uri uri = Uri.parse('$UrlBase/portofolio');
    final http.MultipartRequest request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields['title'] = title
      ..fields['categoryId'] = category_id;

    for (var image in images) {
      // Determine the file extension and set content type accordingly
      final fileExtension = image.path.split('.').last.toLowerCase();
      final contentType = fileExtension == 'png' 
        ? MediaType('image', 'png')
        : MediaType('image', 'jpeg');

      request.files.add(await http.MultipartFile.fromPath(
        'photos', // Ensure this matches what the server expects
        image.path,
        contentType: contentType,
      ));
    }

    final http.StreamedResponse response = await request.send();
    final http.Response responseData = await http.Response.fromStream(response);

    if (response.statusCode == 201) {
      return true; // Success
    } else {
      print('Error: ${response.statusCode} - ${responseData.body}');
      return false; // Failure
    }
  } catch (e, stackTrace) {
    // Log the error and stack trace for better debugging
    print('Error while creating portfolio: $e');
    print('Stack trace: $stackTrace');
    return false; // Indicate failure
  }
}

   Future<Tuple2<int, List<Catalog>>> getCatalogs() async {
    var url = '$UrlBase/catalog';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data product: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<Catalog> listProducts = [];

      for (var item in data) {
        listProducts.add(Catalog.fromJson(item));
      }

      return Tuple2(response.statusCode, listProducts);
    } else {
      List<Catalog> listProducts = [];
         return Tuple2(response.statusCode, listProducts);
    }
  }

  Future <Tuple2<bool, String>> createBooking({
   String? catalogId,
String? name,
String? email,
String? phone,
String? address,
String? day,
String? time,

  }) async {
    var url = '$UrlBase/booking';
    var url1 = '$UrlBase/notification';
    var header = {
      'Content-Type': 'application/json',
           'Authorization': 'Bearer ' + await session.getSession()
    };

    var body = jsonEncode(
      {
     "catalogId": catalogId,
  "name": name,
  "email": email,
  "phone": phone,
  "address": address,
  "day": day,
  "time": time,
      },
    );

  

    print(body);

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 201) {
       var id = jsonDecode(response.body)["data"]["id"];

         var body1 = jsonEncode(
    {
    "title" : "Photographer Booked Succesfully",
    "body" : "Hi, "+name!+", welcome to FotoIn. We’re here to make your...",
    "to" : jsonDecode(response.body)["data"]["userBookingId"]
    }
    );
     var response1 = await http.post(
      Uri.parse(url1),
      headers: header,
      body: body1,
    );
     print('notif: ${response1.body}');
      return Tuple2(true, id);
    } else {
      var data = jsonDecode(response.body);

      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return Tuple2(false, data['message']);
    }
  }


   Future <Tuple2<bool, String>> createPayment({
   String? orderId,
   String? catalogId,
   String? paymentType,
   String? bank,
   int? amount,

  }) async {
    var url = '$UrlBase/transactions';
    var header = {
      'Content-Type': 'application/json',
           'Authorization': 'Bearer ' + await session.getSession()
    };

    var body = jsonEncode(
     {
  "paymentType": paymentType,
  "bank" : bank,
  "catalogId": catalogId
}
    );

    print(body);

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 201) {
         var id = jsonDecode(response.body)["va_numbers"];
      return Tuple2(true, id);
    } else {
     var data = jsonDecode(response.body);
      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return Tuple2(false, data['message']);
    }
  }


Future readNotification({
  String? id
  }) async {
    var url = '$UrlBase/notification/read?id='+id!;
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

   var response = await http.patch(Uri.parse(url), headers: header);
    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 200) {
      return null;
    } else {
      var data = jsonDecode(response.body);

      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }


Future<List<NotificationModel>> getNotification() async {
    var url = '$UrlBase/notification/to';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data product: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<NotificationModel> listProducts = [];

      for (var item in data) {
        listProducts.add(NotificationModel.fromJson(item));
      }

      return listProducts;
    } else {
      throw Exception('Failed to load product');
    }
  }

 Future createChat({
    String? text,
    int? receiverId,
  }) async {
    var url = '$UrlBase/chat';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var body = jsonEncode(
    {
    "receiverId" : receiverId,
    "text" : text
}
    );

    print(body);

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 201) {
      return null;
    } else {
      var data = jsonDecode(response.body);

      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }


Future <ChatModel> getChat({
    String? receiverId,
  }) async {
    var url = '$UrlBase/chat?receiverId='+receiverId!;
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);
      print(url);
    print('kumpulan data product: ${response.body}');

    if (response.statusCode == 200) {
       var data = jsonDecode(response.body)['data'];
      ChatModel chat = ChatModel.fromJson(data);

      return chat;
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<List<ProtofolioModel>> getProtofolio() async {
    var url = '$UrlBase/portofolio/owner';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data product: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<ProtofolioModel> listProducts = [];

      for (var item in data) {
        listProducts.add(ProtofolioModel.fromJson(item));
      }

      return listProducts;
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<List<Catalog>> getCatalogsByCategory({
    String? catrgoryId,
    String? search
  }) async {
    var url = '$UrlBase/catalog/category/search?categoryId='+catrgoryId!+'&search='+search!;
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data product: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<Catalog> listProducts = [];

      for (var item in data) {
        listProducts.add(Catalog.fromJson(item));
      }

      return listProducts;
    } else {
      throw Exception('Failed to load product');
    }
  }

   Future<List<Catalog>> getCatalogsByOwner() async {
    var url = '$UrlBase/catalog/owner';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data product: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<Catalog> listProducts = [];

      for (var item in data) {
        listProducts.add(Catalog.fromJson(item));
      }

      return listProducts;
    } else {
      throw Exception('Failed to load product');
    }
  }


Future<Tuple2<int, List<Catalog>>> getCatalogsByRecomendation({
    String? catrgoryId,
       String? search
  }) async {
    var url = '$UrlBase/catalog/category/search?categoryId='+catrgoryId!+'&search='+search!;
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data product: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<Catalog> listProducts = [];

      for (var item in data) {
        listProducts.add(Catalog.fromJson(item));
      }

      return Tuple2(response.statusCode, listProducts);
    } else {
      List<Catalog> listProducts = [];
         return Tuple2(response.statusCode, listProducts);
    }
  }



  Future getGroupChats() async {
    var url = '$UrlBase/chat/group-chat';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data product: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<GroupChat> listProducts = [];

      for (var item in data) {
        listProducts.add(GroupChat.fromJson(item));
      }

      return listProducts;
    } else {
      return null;
    }
  }


  Future postCart({
  int? id,
  int? type
  }) async {
    var url = '$UrlBase/cart';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

  var body = jsonEncode(
      {
        'type': type,
        'catalogId': id,
      },
    );
   var response = await http.post(Uri.parse(url), headers: header,  body: body,);
    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      var data = jsonDecode(response.body);
      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }

   Future<List<CartModel>> getCart({
    String? type
   }) async {
    var url = '$UrlBase/cart?type='+type!;
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data product: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<CartModel> listProducts = [];

      for (var item in data) {
        listProducts.add(CartModel.fromJson(item));
      }

      return listProducts;
    } else {
      throw Exception('Failed to load product');
    }
  }


  Future deleteCart({
  String? id,
  }) async {
    var url = '$UrlBase/cart?id='+id!;
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

   var response = await http.delete(Uri.parse(url), headers: header);
    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      var data = jsonDecode(response.body);
      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }

    Future updateCart({
  String? id,
  }) async {
    var url = '$UrlBase/cart?id='+id!;
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

   var response = await http.patch(Uri.parse(url), headers: header);
    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      var data = jsonDecode(response.body);
      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }


Future changeStatusBooking({
  String? id,
  String? status
  }) async {
    var url = '$UrlBase/booking/update-status?id='+id!;
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

 var body = jsonEncode(
      {
        'status': status,
      },
    );
   var response = await http.patch(Uri.parse(url), headers: header, body: body);
    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      var data = jsonDecode(response.body);

      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }


  Future postIncome({
  int? id,
  }) async {
    var url = '$UrlBase/wallet/transaction';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

  var body = jsonEncode(
      {
        'type': "INCOME",
        'catalogId': id,
      },
    );
   var response = await http.post(Uri.parse(url), headers: header,  body: body,);
    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      var data = jsonDecode(response.body);
      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }


  Future postWithdraw({
  int? amount,
  String? method,
  String? number,
  String? name,
  String? bankName,
  }) async {
    var url = '$UrlBase/wallet/transaction';
       var url1 = '$UrlBase/notification';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

  var body = jsonEncode(
      {
    "type" : "WITHDRAW",
    "amount" : amount,
    "method" : "BANK_TRANSFER",
    "accountNumber" : number,
    "accountName" : name,
    "bankName" : bankName

      },
    );
   var response = await http.post(Uri.parse(url), headers: header,  body: body,);
    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 201) {
           var body1 = jsonEncode(
    {
    "title" : "Withdraw Funs",
    "body" : jsonDecode(response.body)["result"]["amount"],
    "to" :  jsonDecode(response.body)["result"]["user"]["id"]
    }
    );
     var response1 = await http.post(
      Uri.parse(url1),
      headers: header,
      body: body1,
    );
       print('kumpulan data login1: ${response1.body}');
      return true;
    } else {
      var data = jsonDecode(response.body);
      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }


  Future approveWithdraw({
  int? id,
  }) async {
    var url = '$UrlBase/wallet/transaction/status';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

  var body = jsonEncode(
      {
    "id" : id,
    "status" : "APPROVE"

      },
    );
   var response = await http.patch(Uri.parse(url), headers: header,  body: body,);
    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      var data = jsonDecode(response.body);
      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }


Future rejectWithdraw({
  int? id,
  }) async {
    var url = '$UrlBase/wallet/transaction/status';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

  var body = jsonEncode(
      {
    "id" : id,
    "status" : "REJECT"

      },
    );
   var response = await http.patch(Uri.parse(url), headers: header,  body: body,);
    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      var data = jsonDecode(response.body);
      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }


 Future<StoreModal> getStores() async {
    var url = '$UrlBase/stores';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    print(await session.getSession());
    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data: ${response.body}');

    if (response.statusCode == 200) {
    
      var data = jsonDecode(response.body)['data'];
      print(data);
      StoreModal user = StoreModal.fromJson(data);

      return user;
    } else {
      throw Exception('Failed to load');
    }
  }

   Future createProfile({
    String? email,
    String? company_name,
    String? province,
    String? city,
    String? address,
    String? phone_number,
  }) async {
    var url = '$UrlBase/profile-user';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var body = jsonEncode(
      {
       "name" : company_name,
        "province" : province,
        "city" : city,
        "address" : address,
        "phone_number" : phone_number,
        "email_confirmation" : email,
      },
    );

    print(body);

    var response = await http.patch(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    print('kumpulan data login: ${response.body}');
    if (response.statusCode == 200) {
      return null;
    } else {
      var data = jsonDecode(response.body);

      RequestModel user = RequestModel.fromJson(data);
      user.message = data['message'];
      return user;
    }
  }


  Future<String> getBallance() async {
    var url = '$UrlBase/wallet/balance';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    print(await session.getSession());
    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data: ${response.body}');

    if (response.statusCode == 200) {
    
      var data = jsonDecode(response.body)['saldo'];
      return data.toString();
    } else {
      throw Exception('Failed to load');
    }
  }


  Future<List<WalletModel>> getAllIncome({
    String? catrgoryId,
    String? search
  }) async {
    var url = '$UrlBase/wallet/history/income';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data product: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['result'];
      List<WalletModel> listProducts = [];

      for (var item in data) {
        listProducts.add(WalletModel.fromJson(item));
      }

      return listProducts;
    } else {
      throw Exception('Failed to load product');
    }
  } 


  Future<List<WalletModel>> getAllWithdraw({
    String? catrgoryId,
    String? search
  }) async {
    var url = '$UrlBase/wallet/history/withdraw';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data product: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['result'];
      List<WalletModel> listProducts = [];

      for (var item in data) {
        listProducts.add(WalletModel.fromJson(item));
      }

      return listProducts;
    } else {
      throw Exception('Failed to load product');
    }
  } 

    Future<List<WalletAdminModel>> getAllProgress({
    String? type,
  }) async {
    var url = '$UrlBase/wallet/withdraw/inprogress?status='+ type!;
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data product: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['result'];
      List<WalletAdminModel> listProducts = [];

      for (var item in data) {
        listProducts.add(WalletAdminModel.fromJson(item));
      }

      return listProducts;
    } else {
      throw Exception('Failed to load product');
    }
  } 


    Future<List<BookingStatus>> getAllBookingStatus({
  String? status,
  String? type
  }) async {
    var url = '$UrlBase/booking/status?status='+status!+'&type='+type.toString();
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data product: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<BookingStatus> listProducts = [];

      for (var item in data) {
        listProducts.add(BookingStatus.fromJson(item));
      }

      return listProducts;
    } else {
      throw Exception('Failed to load product');
    }
  } 

  Future<bool> createReview({
  required String rating,
  required String text,
  required String catalog_id,
  required List<File> images,
}) async {
  try {
    final String token = await session.getSession();
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
        var url1 = '$UrlBase/notification';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + await session.getSession()
    };


    final Uri uri = Uri.parse('$UrlBase/catalog/review');
    final http.MultipartRequest request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields['catalogId'] = catalog_id
      ..fields['rating'] = rating
      ..fields['text'] = text;

    for (var image in images) {
      // Determine the file extension and set content type accordingly
      final fileExtension = image.path.split('.').last.toLowerCase();
      final contentType = fileExtension == 'png' 
        ? MediaType('image', 'png')
        : MediaType('image', 'jpeg');

      request.files.add(await http.MultipartFile.fromPath(
        'photo', // Ensure this matches what the server expects
        image.path,
        contentType: contentType,
      ));
    }

    final http.StreamedResponse response = await request.send();
    final http.Response responseData = await http.Response.fromStream(response);
      print('kumpulan data product1: ${responseData.body}');

    if (response.statusCode == 201) {
         var url2 = '$UrlBase/wallet/transaction';

  var body = jsonEncode(
      {
        'type': "INCOME",
        'catalogId':  int.parse(catalog_id),
      },
    );
   var response2 = await http.post(Uri.parse(url2), headers: header,  body: body,);
     print('kumpulan data product2: ${response2.body}');
            var body1 = jsonEncode(
    {
    "title" : "Monney Added to Wallet",
    "body" : jsonDecode(response2.body)["result"]["amount"],
    "to" : jsonDecode(responseData.body)["data"]["catalog"]["ownerId"]
    }
    );
     var response1 = await http.post(
      Uri.parse(url1),
      headers: header,
      body: body1,
    );
      print('kumpulan data product3: ${response1.body}');
      return true; // Success
    } else {
      print('Error: ${response.statusCode} - ${responseData.body}');
      return false; // Failure
    }
  } catch (e, stackTrace) {
    // Log the error and stack trace for better debugging
    print('Error while creating portfolio: $e');
    print('Stack trace: $stackTrace');
    return false; // Indicate failure
  }
}

  
}


