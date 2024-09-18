import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  int? id;
  String? tokenUser;
  int? idproduct;
  bool? cekReg;

  Future<void> saveSession(String? token, int? id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token ?? "");
    prefs.setInt('id', id ?? 0);
  }

  Future<void> saveSessionCekReg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('cekReg', false);
  }

  Future<void> saveSessionOrder(int? idproduk) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('idproduct', idproduk ?? 0);
  }

  Future getSessioncekReg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cekReg = prefs.getBool('cekReg');
    return cekReg;
  }

  Future getSessionOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idproduct = prefs.getInt('idproduct');
    return idproduct ?? 0;
  }

  Future getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenUser = prefs.getString('token');
    return tokenUser ?? "";
  }

  Future getSession1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('id');
    return id ?? 0;
  }

  Future clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future removeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("idproduct");
  }

  Future removeSessioncekReg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("cekReg");
  }
}

final session = SessionManager();
