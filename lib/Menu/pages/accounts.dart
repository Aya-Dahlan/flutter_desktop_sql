import 'package:flutter/material.dart';
import 'package:flutter_desktop_sql/Components/button.dart';
import 'package:flutter_desktop_sql/Components/colors.dart';
import 'package:flutter_desktop_sql/Components/input_field.dart';
import 'package:flutter_desktop_sql/Json/accounts_json.dart';
import 'package:flutter_desktop_sql/SQLLite/database_helper.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  late DatabaseHelper handler;
  late Future<List<AccountsJson>> accounts;
  final db = DatabaseHelper();

  @override
  void initState() {
    handler = db;
    accounts = handler.getAccounts();
    handler.init().whenComplete(() {
      accounts = getAllRecords();
    });

    super.initState();
  }

  Future<List<AccountsJson>> getAllRecords() async {
    return await handler.getAccounts();
  }

  Future<void> _onRefresh() async {
    setState(() {
      accounts = getAllRecords();
    });
  }

  Future<List<AccountsJson>> filter() async {
    return await handler.filter(SearchController.text);
  }

  final accHolder = TextEditingController();
  final accName = TextEditingController();
  final SearchController = TextEditingController();
  bool isSearchOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addDialog();
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: isSearchOn
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: MediaQuery.of(context).size.width * .4,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.5),
                      blurRadius: 1,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      accounts = filter();
                    });
                  },
                  controller: SearchController,
                  decoration: InputDecoration(
                      suffixIcon: SearchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  SearchController.clear();
                                  _onRefresh();
                                });
                              },
                              icon: const Icon(
                                Icons.clear,
                                size: 17,
                              ))
                          : SizedBox(),
                      border: InputBorder.none,
                      hintText: "Search accounts here",
                      icon: Icon(Icons.search)),
                ),
              )
            : Text("Accounts"),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  isSearchOn = !isSearchOn;
                });
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: accounts,
          builder: (BuildContext context,
              AsyncSnapshot<List<AccountsJson>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Accounts Fount'),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              final items = snapshot.data ?? <AccountsJson>[];
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        child: Text(items[index].accHolder![0]),
                      ),
                      title: Text(items[index].accHolder!),
                      subtitle: Text(items[index].accName!),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            deleteAccount(items[index].accId);
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade900,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          updateDialog(items[index].accId);
                          accHolder.text = items[index].accHolder!;
                          accName.text = items[index].accName!;
                        });
                      },
                      tileColor: index % 2 == 1
                          ? primaryColor.withOpacity(0.03)
                          : Colors.transparent,
                    );
                  });
            }
          }),
    );
  }

  void addDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add New Account"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputField(
                    hint: "Account Hold",
                    controller: accHolder,
                    icon: Icons.person),
                InputField(
                    hint: "Account Name",
                    controller: accName,
                    icon: Icons.account_circle_rounded),
              ],
            ),
            actions: [
              Button(
                  label: "ADD ACCOUNT",
                  press: () {
                    addAccount();
                    Navigator.pop(context);
                    accHolder.clear();
                    accName.clear();
                  }),
            ],
          );
        });
  }

  void updateDialog(id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Account"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputField(
                    hint: "Account Hold",
                    controller: accHolder,
                    icon: Icons.person),
                InputField(
                    hint: "Account Name",
                    controller: accName,
                    icon: Icons.account_circle_rounded),
              ],
            ),
            actions: [
              Button(
                  label: "UPDATE ACCOUNT",
                  press: () {
                    Navigator.pop(context);
                    updateAccount(id);
                    accHolder.clear();
                    accName.clear();
                  }),
            ],
          );
        });
  }

////ADD Account /////
  void addAccount() async {
    var res = await handler.insertAccount(AccountsJson(
        accHolder: accHolder.text,
        accName: accName.text,
        accStatus: 1,
        createdAt: DateTime.now().toIso8601String()));

    if (res > 0) {
      setState(() {
        _onRefresh();
      });
    }
  }

  ///Delete Account/////
  void deleteAccount(id) async {
    var res = await handler.deleteAccount(id);
    if (res > 0) {
      setState(() {
        _onRefresh();
      });
    }
  }

  //Update Account
  void updateAccount(accId) async {
    var res = await handler.updateAccount(accHolder.text, accName.text, accId);
    if (res > 0) {
      setState(() {
        _onRefresh();
      });
    }
  }
}
