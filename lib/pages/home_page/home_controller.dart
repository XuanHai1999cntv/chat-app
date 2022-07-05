import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with WidgetsBindingObserver{
  FirebaseAuth get auth => FirebaseAuth.instance;
  FirebaseFirestore get db => FirebaseFirestore.instance;

  Rxn<UserModel> userProfile = Rxn();
  List<UserModel> listUser = [];
  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit(){
    super.onInit();
    getListUser();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");

  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      setStatus("Online");
    }else{
      setStatus("Offline");
    }
  }
  Future logOut() async {
    setStatus("Offline");
    await auth.signOut();
  }

  Future<void> getInfoUser()async{
    _isLoading.value = true;
    final userUid = auth.currentUser?.uid;

    final query = db.collection('user').doc(userUid);


    final map = (await query.get()).data();

    if(map == null) return;
    userProfile.value = UserModel.fromJson(map);
    _isLoading.value = false;
  }
  
  Future<void> getListUser() async{
    await getInfoUser();
    _isLoading.value = true;
    List<UserModel> users = [];
    //_isLoading.value = true;
    final query =  db.collection('user');

    final ee = await query.get();

    for(final json in ee.docs){
      final user = UserModel.fromJson(json.data());
      if(user.email != userProfile.value?.email){
        users.add(user);
      }
    }
    listUser = users;
    _isLoading.value = false;
  }
  String getConversationId({required String email1, required String email2}) {
    if (email1[0].toLowerCase().codeUnits[0] >
        email2[0].toLowerCase().codeUnits[0]) {
      return "$email1$email2";
    } else {
      return "$email2$email1";
    }
  }
  void setStatus(String status)async{
    await db.collection("user").doc(auth.currentUser!.uid).update({
      "status": status,
    });
  }
}