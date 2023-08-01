import 'package:firebase_database/firebase_database.dart';

class PracticeForm {
  static final db = FirebaseDatabase.instance.ref("UserData");
  static List<Map> userDataStorrer = [];

  static Future<void> addUserData({required String fname, mname, lname}) async {
    String key = db.push().key!;
    await db.child(key).set({
      "key": key,
      "firstName": fname,
      "middleName": mname,
      "lastName": lname,
    });
  }

  static Future<List<Map>> selectData() async {
    Map data = await db.once().then(
          (value) => value.snapshot.value as Map? ?? {},
        );
    data.forEach(
      (key, value) {
        userDataStorrer.add(value);
      },
    );
    return userDataStorrer;
  }
}
