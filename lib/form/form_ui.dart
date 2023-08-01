// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:firebase_demo/form/form_api.dart';
import 'package:flutter/material.dart';

class Form_ui extends StatefulWidget {
  const Form_ui({super.key});

  @override
  State<Form_ui> createState() => _Form_uiState();
}

class _Form_uiState extends State<Form_ui> {
  TextEditingController formName = TextEditingController();

  late Future<List<Map>> futureUserData;

  bool isUpgarde = false;

  @override
  void initState() {
    futureUserData = FirbaseNameApi.selectData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              controller: formName,
            ),
            MaterialButton(
              onPressed: isUpgarde
                  ? () async {
                      await FirbaseNameApi.updateUserName(
                        key: FirbaseNameApi.selectedKey,
                        userName: formName.text,
                      );
                      futureUserData = FirbaseNameApi.selectData();
                      isUpgarde = false;
                      setState(() {});
                    }
                  : () async {
                      await FirbaseNameApi.addUserData(
                        userName: formName.text,
                      );
                      setState(() {});
                    },
              child: Text(isUpgarde ? 'Upgrade' : "Submite"),
            ),
            FutureBuilder(
              future: futureUserData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          FirbaseNameApi.deletUserData(
                              key: snapshot.data![index]['key']);
                          futureUserData = FirbaseNameApi.selectData();
                          setState(() {});
                        },
                        child: ListTile(
                          title: Text(snapshot.data![index]['username']),
                          onTap: () {
                            formName.text = snapshot.data![index]['username'];
                            log("${snapshot.data![index]['key']}");
                            FirbaseNameApi.selectedKey =
                                snapshot.data![index]['key'];
                            isUpgarde = true;
                            setState(() {});
                          },
                        ),
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
      ),
    );
  }
}
