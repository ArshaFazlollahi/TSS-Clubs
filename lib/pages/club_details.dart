import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tss_clubs/pages/edit_details.dart';
import 'package:tss_clubs/widgets/big_text.dart';

import 'package:tss_clubs/widgets/details_page_text.dart';

import '../utils/appcolors.dart';
import '../utils/club.dart';
import '../utils/dimensions.dart';

class ClubDetails extends StatefulWidget {
  static late club touchedClub;
  const ClubDetails({super.key});

  @override
  State<ClubDetails> createState() => _club_detailsState();
}

class _club_detailsState extends State<ClubDetails> {
  final password = TextEditingController();
  final clubNewData = TextEditingController();
  bool notloaded = true;
  bool notloaded2 = true;
  bool? admin = false;
  bool statechanged = false;
  List<club> Clubs = [];
  List<club> dontouchClubs = [];
  List<club> mrClubs = [];

  @override
  void initState() {
    super.initState();
    fetchFromFirebase();
  }

  Future<bool> getboolfromsharedpref() async {
    final prefs = await SharedPreferences.getInstance();
    final adminc = prefs.getBool('admin');
    if (!statechanged) {
      setState(() {
        admin = adminc;
        statechanged = true;
        notloaded2 = false;
      });
    }
    if (adminc == null) {
      return false;
    }
    return adminc;
  }

  @override
  Widget build(BuildContext context) {
    while (notloaded || notloaded2) {
      debugPrint(admin.toString());

      if (!statechanged) {
        getboolfromsharedpref();
      }
      return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: AppColor.yellow,
          centerTitle: true,
          title: Text(
            "${ClubDetails.touchedClub.club_name}",
          ),
        ),
        body: Center(
          child: LoadingAnimationWidget.inkDrop(
            color: AppColor.yellow,
            size: Dimensions.phsize(20),
          ),
        ),
      );
    }

    ///////////////////////////////////////////// admin //////////////////////////////////////////
    if (admin == true) {
      //debugPrint("admin is : true");

      return Scaffold(
        backgroundColor: Color.fromARGB(255, 249, 246, 237),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: AppColor.yellow,
          centerTitle: true,
          title: Text(
            "${ClubDetails.touchedClub.club_name}",
          ),
          actions: [
            const Icon(Icons.admin_panel_settings),
            SizedBox(
              width: Dimensions.pwsize(3),
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: Dimensions.phsize(2)),
                  //top image
                  Container(
                    height: Dimensions.phsize(30),
                    width: Dimensions.pwsize(90),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: NetworkImage(
                          ClubDetails.touchedClub.image_url,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.phsize(4)),
                  // description divider
                  Center(
                    child: Container(
                      height: Dimensions.phsize(4),
                      width: Dimensions.pwsize(95),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.phsize(20)),
                        color: AppColor.blue,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Dimensions.wsize(20)),
                          bigText(
                            text: "Description :",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.phsize(1)),
                  // description data
                  SizedBox(
                    width: Dimensions.pwsize(83),
                    child: detailsPageText(
                      text: ClubDetails.touchedClub.description,
                      editable: true,
                    ),
                  ),
                  SizedBox(height: Dimensions.phsize(2)),
                  // meeting days divider
                  Center(
                    child: Container(
                      height: Dimensions.phsize(4),
                      width: Dimensions.pwsize(95),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.phsize(20)),
                        color: AppColor.blue,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Dimensions.wsize(20)),
                          Text(
                            "Meeting days :",
                            style: TextStyle(fontSize: Dimensions.font20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.phsize(1)),
                  // meeting days data
                  SizedBox(
                    width: Dimensions.pwsize(83),
                    child: detailsPageText(
                      text: ClubDetails.touchedClub.meeting_days,
                      size: Dimensions.hsize(25),
                      editable: true,
                    ),
                  ),
                  SizedBox(height: Dimensions.phsize(1)),
                  // meeting room divider
                  Center(
                    child: Container(
                      height: Dimensions.phsize(4),
                      width: Dimensions.pwsize(95),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.phsize(20)),
                        color: AppColor.blue,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Dimensions.wsize(20)),
                          Text(
                            "Meeting room :",
                            style: TextStyle(fontSize: Dimensions.font20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.phsize(1)),
                  // meetiing room data
                  SizedBox(
                    width: Dimensions.pwsize(83),
                    child: detailsPageText(
                      text: ClubDetails.touchedClub.meeting_room,
                      size: Dimensions.hsize(25),
                      editable: true,
                    ),
                  ),
                  SizedBox(height: Dimensions.phsize(1)),
                  // teacher divider
                  Center(
                    child: Container(
                      height: Dimensions.phsize(4),
                      width: Dimensions.pwsize(95),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.phsize(20)),
                        color: AppColor.blue,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Dimensions.wsize(20)),
                          Text(
                            "Teacher :",
                            style: TextStyle(fontSize: Dimensions.font20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.phsize(1)),
                  // teacher data
                  SizedBox(
                    width: Dimensions.pwsize(83),
                    child: detailsPageText(
                      text: ClubDetails.touchedClub.techear,
                      size: Dimensions.hsize(25),
                      editable: true,
                    ),
                  ),
                  SizedBox(height: Dimensions.phsize(1)),
                  // gallery divider
                  Center(
                    child: Container(
                      height: Dimensions.phsize(4),
                      width: Dimensions.pwsize(95),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.phsize(20)),
                        color: AppColor.blue,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Dimensions.wsize(20)),
                          Text(
                            "Gallery :",
                            style: TextStyle(fontSize: Dimensions.font20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.phsize(3)),
                  ImageSlideshow(
                      indicatorColor: AppColor.green,
                      indicatorBackgroundColor: Colors.pink,
                      autoPlayInterval: 8000,
                      initialPage: 0,
                      isLoop: true,
                      width: Dimensions.pwsize(80),
                      height: Dimensions.phsize(30),
                      children: List.generate(
                          ClubDetails.touchedClub.gallery_image.length,
                          (index) {
                        return Image.network(
                            ClubDetails.touchedClub.gallery_image[index]);
                      })),
                  SizedBox(height: Dimensions.phsize(1)),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: Dimensions.pwsize(1.5),
                  bottom: Dimensions.pwsize(1.5),
                ),
                child: FloatingActionButton(
                  child: const Icon(Icons.edit),
                  onPressed: () {
                    EditDetails.touchedClub = ClubDetails.touchedClub;
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditDetails(),
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
    ///////////////////////////////////////////// normal user //////////////////////////////////////////
    else {
      //debugPrint("admin is : ${admin.toString()}");
      return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: AppColor.yellow,
          centerTitle: true,
          title: Text(
            "${ClubDetails.touchedClub.club_name} ",
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.admin_panel_settings_outlined),
              onPressed: () async {
                await _displayTextInputDialog(context);
              },
            ),
            SizedBox(
              width: Dimensions.pwsize(3),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Dimensions.phsize(2)),
              Container(
                height: Dimensions.phsize(30),
                width: Dimensions.pwsize(90),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: NetworkImage(
                      ClubDetails.touchedClub.image_url,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.phsize(4)),
              Center(
                child: Container(
                  height: Dimensions.phsize(4),
                  width: Dimensions.pwsize(95),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.phsize(20)),
                    color: AppColor.blue,
                  ),
                  child: Center(
                    child: bigText(
                      text: "Description",
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.phsize(1)),
              SizedBox(
                width: Dimensions.pwsize(83),
                child: detailsPageText(
                  text: ClubDetails.touchedClub.description,
                  editable: false,
                ),
              ),
              SizedBox(height: Dimensions.phsize(2)),
              Center(
                child: Container(
                  height: Dimensions.phsize(4),
                  width: Dimensions.pwsize(95),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.phsize(20)),
                    color: AppColor.blue,
                  ),
                  child: Center(
                    child: Text(
                      "meeting days",
                      style: TextStyle(fontSize: Dimensions.font20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.phsize(1)),
              Center(
                child: detailsPageText(
                  text: ClubDetails.touchedClub.meeting_days,
                  size: Dimensions.hsize(25),
                  editable: false,
                ),
              ),
              SizedBox(height: Dimensions.phsize(1)),
              Center(
                child: Container(
                  height: Dimensions.phsize(4),
                  width: Dimensions.pwsize(95),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.phsize(20)),
                    color: AppColor.blue,
                  ),
                  child: Center(
                    child: Text(
                      "meeting room",
                      style: TextStyle(fontSize: Dimensions.font20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.phsize(1)),
              Center(
                child: detailsPageText(
                  text: ClubDetails.touchedClub.meeting_room,
                  size: Dimensions.hsize(25),
                  editable: false,
                ),
              ),
              SizedBox(height: Dimensions.phsize(1)),
              Center(
                child: Container(
                  height: Dimensions.phsize(4),
                  width: Dimensions.pwsize(95),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.phsize(20)),
                    color: AppColor.blue,
                  ),
                  child: Center(
                      child: Text(
                    "teacher",
                    style: TextStyle(fontSize: Dimensions.font20),
                  )),
                ),
              ),
              SizedBox(height: Dimensions.phsize(1)),
              Center(
                child: detailsPageText(
                  text: ClubDetails.touchedClub.techear,
                  size: Dimensions.hsize(25),
                  editable: false,
                ),
              ),
              SizedBox(height: Dimensions.phsize(1)),
              Center(
                child: Container(
                  height: Dimensions.phsize(4),
                  width: Dimensions.pwsize(95),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.phsize(20)),
                    color: AppColor.blue,
                  ),
                  child: Center(
                      child: Text(
                    "gallery",
                    style: TextStyle(fontSize: Dimensions.font20),
                  )),
                ),
              ),
              SizedBox(height: Dimensions.phsize(3)),
              ImageSlideshow(
                  indicatorColor: AppColor.green,
                  indicatorBackgroundColor: Colors.pink,
                  autoPlayInterval: 8000,
                  initialPage: 0,
                  isLoop: true,
                  width: Dimensions.pwsize(80),
                  height: Dimensions.phsize(30),
                  children: List.generate(
                      ClubDetails.touchedClub.gallery_image.length, (index) {
                    return Image.network(
                        ClubDetails.touchedClub.gallery_image[index]);
                  })),
              SizedBox(height: Dimensions.phsize(1)),
            ],
          ),
        ),
      );
    }
  }

  void fetchFromFirebase() async {
    var ref =
        FirebaseDatabase.instance.ref(ClubDetails.touchedClub.id.toString());
    var snapshot = await ref.get();
    debugPrint(snapshot.value.toString());
    var snapshotdata = snapshot.value as Map;
    if (snapshot.exists) {
      Clubs.clear();
      dontouchClubs.clear();
      setState(() {
        //debugPrint("item is : ${item}");
        var clubitem = club(
          snapshotdata['club_name'],
          snapshotdata['id'],
          snapshotdata['meeting_room'],
          snapshotdata['image_url'],
          snapshotdata['meeting_days'],
          snapshotdata['techear'],
          snapshotdata['description'],
          snapshotdata['category'],
          snapshotdata['ismr'],
          snapshotdata['admin_code'],
          snapshotdata['gallery_image'],
        );
        Clubs.add(clubitem);
        dontouchClubs.add(clubitem);
        if (snapshotdata["ismr"]) {
          debugPrint(snapshotdata["club_name"]);
          mrClubs.add(clubitem);
        }

        notloaded = false;
      });
    } else {
      debugPrint('No data available.');
    }

    debugPrint(ClubDetails.touchedClub.gallery_image.toString());
  }

  Future<void> _displayTextInputDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter admin code'),
            content: TextField(
              autofocus: true,
              obscureText: true,
              obscuringCharacter: '*',
              onChanged: (value) {},
              controller: password,
              decoration: const InputDecoration(hintText: "Password"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  debugPrint(password.text);
                  if (password.text == ClubDetails.touchedClub.admincode) {
                    debugPrint("password is correct");

                    Navigator.of(context).pop();
                    setState(() {
                      admin = true;
                    });

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

  Future<void> _adminChangeDialog(BuildContext context, String selection) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter new data'),
            content: TextField(
              autofocus: true,
              onChanged: (value) {},
              controller: clubNewData,
              decoration: InputDecoration(hintText: selection),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  //TO DO
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
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.hsize(14)),
                  color: AppColor.yellow,
                  child: const Text(
                    "cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
