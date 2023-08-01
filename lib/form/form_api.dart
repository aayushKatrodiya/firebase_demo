import 'package:firebase_database/firebase_database.dart';

class FirbaseNameApi {
  static final db = FirebaseDatabase.instance.ref("User");
  static List<Map> myUserList = [];
  static String selectedKey = " ";

  static Future<void> addUserData({required String userName}) async {
    String key = db.push().key!;
    await db.child(key).set({
      'key': key,
      'username': userName,
    });
  }

  static Future<List<Map>> selectData() async {
    Map data = await db.once().then(
          (value) => value.snapshot.value as Map? ?? {},
        );
    data.forEach(
      (key, value) {
        myUserList.add(value);
      },
    );
    return myUserList;
  }

  static Future<void> updateUserName(
      {required String key, required String userName}) async {
    await db.child(key).update({
      "key": key,
      'username': userName,
    });
  }

  static Future<void> deletUserData({required String key}) async {
    await db.child(key).remove();
  }
}
