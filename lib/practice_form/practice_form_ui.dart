import 'package:firebase_demo/practice_form/practice_form_api.dart';
import 'package:flutter/material.dart';

class PracticeFormUi extends StatefulWidget {
  const PracticeFormUi({super.key});

  @override
  State<PracticeFormUi> createState() => _PracticeFormUiState();
}

class _PracticeFormUiState extends State<PracticeFormUi> {
  TextEditingController fname = TextEditingController();
  TextEditingController mname = TextEditingController();
  TextEditingController lname = TextEditingController();

  late Future<List<Map>> futureUserData;

  @override
  void initState() {
    futureUserData = PracticeForm.selectData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: fname),
          TextField(controller: mname),
          TextField(controller: lname),
          MaterialButton(
            onPressed: () async {
              await PracticeForm.addUserData(
                fname: fname.text,
                mname: mname.text,
                lname: lname.text,
              );
              setState(() {});
            },
            child: const Text("Submite"),
          ),
          FutureBuilder(
            future: futureUserData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => Row(
                      children: [
                        Text(snapshot.data![index]['firstName']),
                        const SizedBox(width: 5),
                        Text(snapshot.data![index]['middleName']),
                        const SizedBox(width: 5),
                        Text(snapshot.data![index]['lastName']),
                      ],
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
