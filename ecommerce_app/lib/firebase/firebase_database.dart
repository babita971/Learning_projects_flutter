import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/modules/dashboard/modal/kicker_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection('order_history');
final CollectionReference _addressCollection =
    FirebaseFirestore.instance.collection('user_address');
final CollectionReference _paymentCollection =
    FirebaseFirestore.instance.collection('user_card_info');
const String _historyCollection = 'history';

class FirebaseOrderDatabase {
  static String? userUid;

  Future<void> addPurchasedOrderToDB({required KickerModel kickerOrder}) async {
    userUid = userUid ?? FirebaseAuth.instance.currentUser?.uid;

    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection(_historyCollection).doc();

    Map<String, dynamic> data = <String, dynamic>{
      "kickerPid": kickerOrder.kickerPid,
      "orderTime": DateTime.now()
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("order added to the database"))
        .catchError((e) => print(e));
  }

  Stream<QuerySnapshot> fetchAllOrdersOfUser() {
    CollectionReference orderCollection =
        _mainCollection.doc(userUid).collection(_historyCollection);
    return orderCollection.snapshots();
  }

  Future<void> saveUserAddressToDatabase(
      {required String addressFirstLine,
      required String addressSecondLine,
      required String city,
      required String zip,
      required String country,
      required String phone}) async {
    userUid = userUid ?? FirebaseAuth.instance.currentUser?.uid;

    DocumentReference documentReferencer = _addressCollection.doc(userUid);

    Map<String, dynamic> data = <String, dynamic>{
      "addressFirstLine": addressFirstLine,
      "addressSecondLine": addressSecondLine,
      "city": city,
      "zip": zip,
      "country": country,
      "phone": phone,
      "updateTime": DateTime.now()
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("address saved to the database"))
        .catchError((e) => print(e));
  }

  fetchUserSavedAddress() async {
    userUid = userUid ?? FirebaseAuth.instance.currentUser?.uid;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('user_address')
        .doc(userUid)
        .get();
    var data = documentSnapshot.data() != null
        ? documentSnapshot.data() as Map<String, dynamic>
        : null;
    return data;
  }

  Future<void> saveUserCardInfoToDatabase(
      {required String cardName,
      required String cardNumber,
      required String expirationDate,
      required String cvv}) async {
    userUid = userUid ?? FirebaseAuth.instance.currentUser?.uid;
    DocumentReference documentReferencer = _paymentCollection.doc(userUid);

    Map<String, dynamic> data = <String, dynamic>{
      "cardName": cardName,
      "cardNumber": cardNumber,
      "expirationDate": expirationDate,
      "cvv": cvv,
      "updateTime": DateTime.now()
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("payment saved to the database"))
        .catchError((e) => print(e));
  }

  fetchUserCardInfo() async {
    userUid = userUid ?? FirebaseAuth.instance.currentUser?.uid;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('user_card_info')
        .doc(userUid)
        .get();
    var data = documentSnapshot.data() != null
        ? documentSnapshot.data() as Map<String, dynamic>
        : null;
    return data;
  }
}
