import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tss_clubs/pages/club_browser.dart';
import 'package:tss_clubs/utils/admin_check.dart';
import 'package:tss_clubs/utils/appcolors.dart';
import 'package:tss_clubs/utils/dimensions.dart';
import 'package:vibration/vibration.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final password = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: AppColor.yellow,
        centerTitle: true,
        title: Text(
          "TSS Clubs",
          style: TextStyle(
              fontSize: Dimensions.hsize(23), fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.hsize(25)),
            child: Column(
              children: [
                SizedBox(height: Dimensions.hsize(75)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 10,
                      //shadowColor: Color.fromARGB(0, 207, 165, 165),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.hsize(15))),
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(Dimensions.hsize(15)),
                        onTap: () {
                          ClubBrowser.club = "Science & Math";
                          //final prefs = await SharedPreferences.getInstance();
                          //final bool? admin = prefs.getBool('admin');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ClubBrowser()));
                          debugPrint("sm tapped");
                        },
                        child: Container(
                          height: Dimensions.hsize(200),
                          decoration: BoxDecoration(
                            color: AppColor.categpry,
                            borderRadius:
                                BorderRadius.circular(Dimensions.hsize(15)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: Dimensions.hsize(5)),
                              Container(
                                height: Dimensions.hsize(140),
                                width: Dimensions.wsize(170),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/Science & Math.png"),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(height: Dimensions.hsize(15)),
                              Text(
                                "Science & Math",
                                style:
                                    TextStyle(fontSize: Dimensions.hsize(18)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.hsize(15))),
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(Dimensions.hsize(15)),
                        onTap: () async {
                          ClubBrowser.club = "Technology";
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ClubBrowser()));
                          debugPrint("technology tapped");
                        },
                        child: Container(
                          height: Dimensions.hsize(200),
                          decoration: BoxDecoration(
                            color: AppColor.categpry,
                            borderRadius:
                                BorderRadius.circular(Dimensions.hsize(15)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: Dimensions.hsize(5)),
                              Container(
                                height: Dimensions.hsize(140),
                                width: Dimensions.wsize(170),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/Technology.png"),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(height: Dimensions.hsize(15)),
                              Text(
                                "Technology",
                                style:
                                    TextStyle(fontSize: Dimensions.hsize(18)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.hsize(15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.hsize(15))),
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(Dimensions.hsize(15)),
                        onTap: () async {
                          ClubBrowser.club = "Sports";
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ClubBrowser()));
                          debugPrint("sport tapped");
                        },
                        child: Container(
                          height: Dimensions.hsize(200),
                          decoration: BoxDecoration(
                            color: AppColor.categpry,
                            borderRadius:
                                BorderRadius.circular(Dimensions.hsize(15)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: Dimensions.hsize(5)),
                              Container(
                                height: Dimensions.hsize(140),
                                width: Dimensions.wsize(170),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/Sports.png"),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(height: Dimensions.hsize(15)),
                              Text(
                                "Sports",
                                style:
                                    TextStyle(fontSize: Dimensions.hsize(18)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.hsize(15))),
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(Dimensions.hsize(15)),
                        onTap: () async {
                          ClubBrowser.club = "Other";
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ClubBrowser()));
                          debugPrint("other tapped");
                        },
                        child: Container(
                          height: Dimensions.hsize(200),
                          decoration: BoxDecoration(
                            color: AppColor.categpry,
                            borderRadius:
                                BorderRadius.circular(Dimensions.hsize(5)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: Dimensions.hsize(5)),
                              Container(
                                height: Dimensions.hsize(140),
                                width: Dimensions.wsize(170),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/Other.png"),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(height: Dimensions.hsize(15)),
                              Text(
                                "Other",
                                style:
                                    TextStyle(fontSize: Dimensions.hsize(18)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () async {
                              await _displayTextInputDialog(context);
                              debugPrint("tapped");

                              final prefs =
                                  await SharedPreferences.getInstance();
                              // prefs.setBool('admin', true);
                              debugPrint(
                                  "admin is ${prefs.getBool('admin').toString()}");

                              /**/
                            },
                            child: const Text("Admin Login"),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.hsize(20)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter password'),
            content: TextField(
              autofocus: true,
              obscureText: true,
              obscuringCharacter: '*',
              onChanged: (value) {},
              controller: password,
              decoration: InputDecoration(hintText: "Password"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  debugPrint(password.text);
                  if (password.text == "1234") {
                    debugPrint("password is correct");
                    adminset();
                    adminget();
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Alert"),
                        content: const Text(
                            "please restart the app to login as admin"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              color: AppColor.yellow,
                              padding: const EdgeInsets.all(14),
                              child: const Text(
                                "okay",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                    //dispose();
                  } else {
                    password.clear();
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.hsize(14)),
                  color: AppColor.yellow,
                  child: const Text(
                    "submit",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
