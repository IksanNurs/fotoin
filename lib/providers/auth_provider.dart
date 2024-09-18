import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fotoin/model/booking_status.dart';
import 'package:fotoin/model/cart.dart';
import 'package:fotoin/model/catalog.dart';
import 'package:fotoin/model/chat.dart';
import 'package:fotoin/model/group_chat.dart';
import 'package:fotoin/model/notification.dart';
import 'package:fotoin/model/protofolio.dart';
import 'package:fotoin/model/request.dart';
import 'package:fotoin/model/store.dart';
import 'package:fotoin/model/user_model.dart';
import 'package:fotoin/model/wallet.dart';
import 'package:fotoin/model/wallet_admin.dart';
import 'package:tuple/tuple.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  RequestModel _requestModel = RequestModel();
  //RequestModel? _userModel1;

  RequestModel get requestModel => _requestModel;

   UserModel _userModel = UserModel();
  //RequestModel? _userModel1;

  UserModel get userModel => _userModel;

  set requestModel(RequestModel requestModel) {
    _requestModel = requestModel;
    notifyListeners();
  }

 set userModel(UserModel requestModel) {
    _userModel = userModel;
    notifyListeners();
  }

   List<Catalog> _catalogs = [];

  List<Catalog> get catalogs => _catalogs;

  set catalogs(List<Catalog> catalogs) {
    _catalogs = catalogs;
    notifyListeners();
  }

   List<NotificationModel> _notification = [];

  List<NotificationModel> get notification => _notification;

  set notification(List<NotificationModel> notification) {
    _notification = notification;
    notifyListeners();
  }

 List<ProtofolioModel> _protofolio = [];

  List<ProtofolioModel> get protofolio => _protofolio;

  set protofolio(List<ProtofolioModel> protofolio) {
    _protofolio = protofolio;
    notifyListeners();
  }

ChatModel _chat = ChatModel();

  ChatModel get chat => _chat;

  set chat(ChatModel chat) {
    _chat = chat;
    notifyListeners();
  }

  List<GroupChat> _groupchat = [];

  List<GroupChat> get groupchat => _groupchat;

  set groupchat(List<GroupChat> groupchat) {
    _groupchat = groupchat;
    notifyListeners();
  }

  List<CartModel> _cartModel = [];

  List<CartModel> get cartModel => _cartModel;

  set cartModel(List<CartModel> cartModel) {
    _cartModel = cartModel;
    notifyListeners();
  }

  List<WalletModel> _walletModel = [];

  List<WalletModel> get walletModel => _walletModel;

  set walletModel(List<WalletModel> cartModel) {
    _walletModel = walletModel;
    notifyListeners();
  }

  List<WalletAdminModel> _walletAdminModel = [];

  List<WalletAdminModel> get walletAdminModel => _walletAdminModel;

  set walletAdminModel(List<WalletAdminModel> cartModel) {
    _walletAdminModel = walletAdminModel;
    notifyListeners();
  }

 StoreModal _storeModel = StoreModal();

  StoreModal get storeModel => _storeModel;

  set storeModel(StoreModal storeModel) {
    _storeModel = storeModel;
    notifyListeners();
  }


  Future<bool> login({
    String? email,
    String? password,
    String? name,
  }) async {
    try {
      var response = await AuthService().login(
      email: email,
      password: password,
    );

    if (response == null) {
    return true;
    }{
        RequestModel request = await AuthService().login(
        email: email,
        password: password,
      );
      _requestModel = request;
      return false;
    }
    } catch (e) {
      RequestModel request = await AuthService().login(
        email: email,
        password: password,
      );
      _requestModel = request;
      return false;
    }
  }

  Future<bool> register({
    String? email,
    String? password,
  }) async {
    try {
      var response = await AuthService().register(
      email: email,
      password: password,
    );

    if (response == null) {
    return true;
    }{
        RequestModel request = await AuthService().register(
        email: email,
        password: password,
      );
      _requestModel = request;
      return false;
    }
    } catch (e) {
      RequestModel request = await AuthService().register(
        email: email,
        password: password,
      );
      _requestModel = request;
      return false;
    }
  }


  Future<bool> verifyAccount({
    String? email,
    int? code
  }) async {
    try {
      var response = await AuthService().verifyAccount(
      email: email,
      code: code
    );

    if (response == null) {
    return true;
    }{
        RequestModel request = await AuthService().verifyAccount(
        email: email,
        code: code,
      );
      _requestModel = request;
      return false;
    }
    } catch (e) {
      RequestModel request = await AuthService().verifyAccount(
        email: email,
       code: code,
      );
      _requestModel = request;
      return false;
    }
  }

  Future<bool> forgot({
    String? email,
  }) async {
    try {
      var response = await AuthService().forgot(
      email: email,
    );

    if (response == null) {
    return true;
    }{
        RequestModel request = await AuthService().forgot(
        email: email,
      );
      _requestModel = request;
      return false;
    }
    } catch (e) {
      RequestModel request = await AuthService().forgot(
        email: email,
      );
      _requestModel = request;
      return false;
    }
  }

  Future<bool> change({
    String? password,
    int? code
  }) async {
    try {
      var response = await AuthService().change(
      password: password,
      code: code,
    );

    if (response == null) {
    return true;
    }{
        RequestModel request = await AuthService().change(
       password: password,
        code: code,
      );
      _requestModel = request;
      return false;
    }
    } catch (e) {
      RequestModel request = await AuthService().change(
       password: password,
      code: code,
      );
      _requestModel = request;
      return false;
    }
  }

   Future<UserModel> getProfile() async {
    try {

      UserModel userModel = await AuthService().getProfile();
         _userModel = userModel;
        print("jd");
        print(userModel);
        return userModel;
    } catch (e) {
   
      return UserModel();
    }
  }


  Future<bool> createStore({
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
      var response = await AuthService().createStore(
     address: address,
     cameraUsed: cameraUsed,
     city: city,
     companyName: companyName,
     country: country,
     experience: experience,
     images: images,
     phoneNumber: phoneNumber,
     province: province,
    );

      return response;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createCatalog({
    required String catalogName,
    required String description,
    required String fee,
    required String tag,
    required String location,
    required String availabledate,
    required String categoryid,
    required String protofolioid,
    required List<File> images,
  }) async {
    try {
      var response = await  AuthService().createCatalog(
        protofolioid: protofolioid,
        category_id: categoryid,
        description: description,
        price: fee,
        tag: tag,
        location: location,
        availableDate: availabledate,
        title: catalogName,
        images: images,
      );

      if (response == null) {
        return true;
      } else {
        _requestModel = response;
        return false;
      }
    } catch (e) {
      print(e);
     RequestModel response = await  AuthService().createCatalog(
      protofolioid: protofolioid,
      category_id: categoryid,
        description: description,
        price: fee,
        tag: tag,
        location: location,
        availableDate: availabledate,
        title: catalogName,
        images: images,
      );
       _requestModel = response;
      return false;
    }
  }

    Future<bool> createPortfolio({
    required String title,
    required String categoryId,
    required List<File> images,
  }) async {
    try {
      var response = await AuthService().createPortfolio(
        title: title,
        category_id: categoryId,
        images: images,
      );

        return response;
      
    } catch (e) {
      return false;
    }
  }

Future<Tuple2<int, List<Catalog>>> getCatalogs() async {
  try {
    var catalogsRes = await AuthService().getCatalogs();
      _catalogs = catalogsRes.item2;
    return Tuple2<int, List<Catalog>>(catalogsRes.item1, catalogsRes.item2);
  } catch (e) {
    // Handle error, bisa dicetak atau di log, atau throw kembali
      var catalogsRes = await AuthService().getCatalogs();
    print('Error while fetching catalogs: $e');
    return Tuple2<int, List<Catalog>>(catalogsRes.item1, catalogsRes.item2);// Melemparkan kembali exception agar dapat ditangkap oleh pemanggil
  }
}

Future<Tuple2<bool, String>> createPayment({
  String? orderId,
  String? catalogId,
  String? paymentType,
  String? bank,
  int? amount,
}) async {
  try {
    // Attempt to create the payment
    var response = await AuthService().createPayment(
      catalogId: catalogId,
      amount: amount,
      bank: bank,
      orderId: orderId,
      paymentType: paymentType,
    );

    return response;
  } catch (e) {
    // Log the error if needed
    print('Error creating payment: $e');

    // Handle the error as needed, you can return a failure response here
    return Tuple2(false, 'Failed to create payment: ${e.toString()}');
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
    try {
      var response = await AuthService().createBooking(
       address: address,
       catalogId: catalogId,
       day: day,
       email: email,
       name: name,
       phone: phone,
       time: time,
      );

       return response;
    } catch (e) {
           // Log the error if needed
    print('Error creating payment: $e');

    // Handle the error as needed, you can return a failure response here
    return Tuple2(false, 'Failed to create payment: ${e.toString()}');
    }
  }


  Future<bool> readNotification({
    String? id
  }) async {
    try {
      var response = await AuthService().readNotification(
       id: id
    );

    if (response == null) {
    return true;
    }{
        RequestModel request =  await AuthService().readNotification(
       id: id
    );
      _requestModel = request;
      return false;
    }
    } catch (e) {
      RequestModel request =  await AuthService().readNotification(
       id: id
    );
      _requestModel = request;
      return false;
    }
  }

    Future<void> getNotifictions() async {
    try {
      List<NotificationModel> notification = await AuthService().getNotification();
      _notification = notification;
    } catch (e) {
      // print(e);
    }
  }

  Future<bool> createChat({
     String? text,
    int? receiverId,
  }) async {
    try {
      var response = await AuthService().createChat(
       receiverId: receiverId,
       text: text
    );

    if (response == null) {
    return true;
    }{
        RequestModel request =  await AuthService().createChat(
       receiverId: receiverId,
       text: text
    );
      _requestModel = request;
      return false;
    }
    } catch (e) {
      RequestModel request =  await AuthService().createChat(
      receiverId: receiverId,
       text: text
    );
      _requestModel = request;
      return false;
    }
  }


  Future<void> getChat({
    String? receiverId,
  }) async {
    try {
      ChatModel chat = await AuthService().getChat(
        receiverId: receiverId,
      );
      _chat = chat;
    } catch (e) {
       print(e);
    }
  }

  Future<void> getGroupChat() async {
    try {
      List<GroupChat> groupchat = await AuthService().getGroupChats();
      _groupchat = groupchat;
    } catch (e) {
       print(e);
    }
  }


Future<void> getProtofolio() async {
    try {
      List<ProtofolioModel> protofolio = await AuthService().getProtofolio();
      _protofolio = protofolio;
    } catch (e) {
       print(e);
    }
  }

  Future<void> getCatalogsByCategoryID(
    {
     String? catrgoryId, 
     String? search 
    }
  ) async {
    try {
      List<Catalog> catalogs = await AuthService().getCatalogsByCategory(
        catrgoryId: catrgoryId,
        search: search
      );
      _catalogs = catalogs;
    } catch (e) {
      // print(e);
    }
  }

  Future<Tuple2<int, List<Catalog>>> getCatalogsByRecomendation(
    {
     String? catrgoryId, 
     String? search 
    }
  ) async {
    try {
    var catalogsRes = await AuthService().getCatalogsByRecomendation(catrgoryId: catrgoryId, search: search);
      _catalogs = catalogsRes.item2;
    return Tuple2<int, List<Catalog>>(catalogsRes.item1, catalogsRes.item2);
  } catch (e) {
    // Handle error, bisa dicetak atau di log, atau throw kembali
    var catalogsRes = await AuthService().getCatalogsByRecomendation(catrgoryId: catrgoryId, search: search);
    print('Error while fetching catalogs: $e');
    return Tuple2<int, List<Catalog>>(catalogsRes.item1, catalogsRes.item2);// Melemparkan kembali exception agar dapat ditangkap oleh pemanggil
  }
  }

 Future<void> getCatalogsByOwner(
  ) async {
    try {
      List<Catalog> catalogs = await AuthService().getCatalogsByOwner();
      _catalogs = catalogs;
    } catch (e) {
      // print(e);
    }
  }

Future<bool> postCart({
     int? id,
  int? type
  }) async {
    try {
      var response = await AuthService().postCart(
        id: id,
        type: type,   
    );
     return response;
    } catch (e) {
      
      return false;
    }
  }

 Future<void> getCart(
  {
    String? type
  }
  ) async {
    try {
      List<CartModel> catalogs = await AuthService().getCart(
        type: type
      );
      _cartModel = catalogs;
    } catch (e) {
      // print(e);
    }
  }


Future<bool> deleteCart({
  String? id
  }) async {
    try {
      var response = await AuthService().deleteCart(
        id: id,   
    );
     return response;
    } catch (e) {
      RequestModel request = await AuthService().deleteCart(
        id: id,   
    );
      _requestModel = request;
      return false;
    }
  }


  Future<bool> changeStatusBooking({
  String? id,
  String? status
  }) async {
    try {
      var response = await AuthService().changeStatusBooking(
        status: status,
        id: id,   
    );
     return response;
    } catch (e) {
      RequestModel request = await AuthService().changeStatusBooking(
        status: status,
        id: id,   
    );
      _requestModel = request;
      return false;
    }
  }


Future<bool> postIncome({
     int? id,
  int? type
  }) async {
    try {
      var response = await AuthService().postIncome(
        id: id, 
    );
     return response;
    } catch (e) {
      RequestModel request = await AuthService().postIncome(
        id: id,
       
    );
      _requestModel = request;
      return false;
    }
  }


Future<bool> postWithdraw({
  int? amount,
  String? method,
  String? number,
  String? name,
  String? bankname,
  }) async {
    try {
      var response = await AuthService().postWithdraw(
        amount: amount,
        method: method,
        name: name,
        number: number,
        bankName: bankname
    );
     return response;
    } catch (e) {
      RequestModel request = await AuthService().postWithdraw(
          amount: amount,
        method: method,
        name: name,
        number: number,
        bankName: bankname
    );
      _requestModel = request;
      return false;
    }
  }
  

  Future<bool> approveWithdraw({
  int? id,
  }) async {
    try {
      var response = await AuthService().approveWithdraw(
        id: id
    );
     return response;
    } catch (e) {
      RequestModel request = await AuthService().approveWithdraw(
      id: id
    );
      _requestModel = request;
      return false;
    }
  }

  Future<bool> rejectWithdraw({
  int? id,
  }) async {
    try {
      var response = await AuthService().rejectWithdraw(
        id: id
    );
     return response;
    } catch (e) {
      RequestModel request = await AuthService().rejectWithdraw(
      id: id
    );
      _requestModel = request;
      return false;
    }
  }

   Future<StoreModal> getStores() async {
    try {

      StoreModal storeModal = await AuthService().getStores();
         _storeModel = storeModal;
  
        return storeModal;
    } catch (e) {
      return StoreModal();
    }
  }

Future<bool> createProfile({
       String? email,
    String? company_name,
    String? province,
    String? city,
    String? address,
    String? phone_number,
  }) async {
    try {
      var response = await AuthService().createProfile(
      address: address,
      city: city,
      company_name: company_name,
      email: email,
      phone_number: phone_number,
      province: province,
    );

    if (response == null) {
           UserModel userModel = await AuthService().getProfile();
         _userModel = userModel;
    return true;
    }{
        RequestModel request = await AuthService().createProfile(
             address: address,
      city: city,
      company_name: company_name,
      email: email,
      phone_number: phone_number,
      province: province,
      );
      _requestModel = request;
      return false;
    }
    } catch (e) {
      RequestModel request = await AuthService().createProfile(
        address: address,
      city: city,
      company_name: company_name,
      email: email,
      phone_number: phone_number,
      province: province,
      );
      _requestModel = request;
      return false;
    }
  }

   Future<String> getBallance() async {
    try {

      String saldo = await AuthService().getBallance();
        return saldo;
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<List<WalletModel>> getAllIncome() async {
  try {
    List<WalletModel> catalogsRes = await AuthService().getAllIncome();
      _walletModel = catalogsRes;
    return _walletModel;
  } catch (e) {
     List<WalletModel> catalogsRes = await AuthService().getAllIncome();
    print('Error while fetching catalogs: $e');
    return catalogsRes;
  }
}

Future<List<WalletModel>> getAllWithdraw() async {
  try {
    List<WalletModel> catalogsRes = await AuthService().getAllWithdraw();
      _walletModel = catalogsRes;
    return _walletModel;
  } catch (e) {
     List<WalletModel> catalogsRes = await AuthService().getAllWithdraw();
    print('Error while fetching catalogs: $e');
    return catalogsRes;
  }
}

Future<List<WalletAdminModel>> getAllProgress({
   String? type,
}) async {
  try {
    List<WalletAdminModel> catalogsRes = await AuthService().getAllProgress(type: type);
      _walletAdminModel = catalogsRes;
    return _walletAdminModel;
  } catch (e) {
     List<WalletAdminModel> catalogsRes = await AuthService().getAllProgress(type: type);
    print('Error while fetching catalogs: $e');
    return catalogsRes;
  }
}

Future<List<BookingStatus>> getBookingStatus({
  String? status,
  String? type
}) async {
  try {
    List<BookingStatus> catalogsRes = await AuthService().getAllBookingStatus(
type: type,
status: status
    );
    return catalogsRes;
  } catch (e) {
     List<BookingStatus> catalogsRes = await AuthService().getAllBookingStatus(
type: type,
status: status
    );
    print('Error while fetching catalogs: $e');
    return catalogsRes;
  }
}


Future<bool> createReview({
    required String rating,
  required String text,
  required String catalog_id,
  required List<File> images,
  }) async {
    try {
      var response = await AuthService().createReview(
        catalog_id: catalog_id,
        rating: rating,
        text: text,
        images: images,
      );

        return response;
      
    } catch (e) {
      return false;
    }
  }

}



