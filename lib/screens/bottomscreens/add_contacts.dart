// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import '../../components/miscwidgets/primary_button.dart';
import 'contacts_page.dart';
import '../../db/db_services.dart';
import '../../models/contactsm.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({super.key});

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  DatabaseHelper databasehelper = DatabaseHelper();
  List<TContact>? contactList;
  int count = 0;

  void showList() {
    Future<Database> dbFuture = databasehelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TContact>> contactListFuture =
          databasehelper.getContactList();
      contactListFuture.then((value) {
        setState(() {
          this.contactList = value;
          this.count = value.length;
        });
      });
    });
  }

  void deleteContact(TContact contact) async {
    int result = await databasehelper.deleteContact(contact.id);
    if (result != 0) {
      Fluttertoast.showToast(msg: "contact removed succesfully");
      showList();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_conditional_assignment
    if (contactList == null) {
      contactList = [];
    }
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                PrimaryButton(
                    title: "Add Trusted Contacts",
                    onPressed: () async {
                      bool result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactsPage(),
                          ));
                      if (result == true) {
                        showList();
                      }
                    }),
                Expanded(
                  child: ListView.builder(
                    itemCount: count,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(contactList![index].name),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        await FlutterPhoneDirectCaller
                                            .callNumber(
                                                contactList![index].number);
                                      },
                                      icon: const Icon(
                                        Icons.call,
                                        color: Colors.red,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        deleteContact(contactList![index]);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
