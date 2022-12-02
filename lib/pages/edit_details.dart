import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tss_clubs/pages/club_browser.dart';
import 'package:tss_clubs/pages/club_details.dart';
import 'package:tss_clubs/utils/links.dart';
import 'package:tss_clubs/widgets/big_text.dart';

import 'package:tss_clubs/widgets/details_page_text.dart';

import '../utils/appcolors.dart';
import '../utils/club.dart';
import '../utils/dimensions.dart';

class EditDetails extends StatefulWidget {
  static late club touchedClub;
  const EditDetails({super.key});

  @override
  State<EditDetails> createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  PlatformFile? pickedFile;
  final _clubname = TextEditingController();
  final _description = TextEditingController();
  final _mday = TextEditingController();
  final _mroom = TextEditingController();
  final _teacher = TextEditingController();

  @override
  void initState() {
    super.initState();
    _description.text = EditDetails.touchedClub.description;
    _clubname.text = EditDetails.touchedClub.club_name;
    _mday.text = EditDetails.touchedClub.meeting_days;
    _mroom.text = EditDetails.touchedClub.meeting_room;
    _teacher.text = EditDetails.touchedClub.techear;
  }

  Future selectfile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future remove() async {
    // final path = "images/${_clubname.value.text}/${pickedFile!.name}";

    // final ref = FirebaseStorage.instance.ref().child(path);

    // ref.delete();

    DatabaseReference reff =
        FirebaseDatabase.instance.ref("${EditDetails.touchedClub.id}");

    await reff.remove();

    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ClubBrowser()));
  }

  Future submit() async {
    //final path = "images/${_clubname.value.text}/${}";

    final ref =
        FirebaseStorage.instance.ref().child("images/${_clubname.value.text}");
    //.child("ah/gallery/IMG-20221123-WA0002.jpeg");

    //ref.child("ah/gallery/IMG-20221123-WA0002.jpeg").delete();
    final listrslt = await ref.listAll();
    for (var item in listrslt.items) {
      debugPrint(
          "//////////////////////////////////////////////////////////////////////");
      debugPrint(item.toString());
    }

    DatabaseReference reff =
        FirebaseDatabase.instance.ref("${EditDetails.touchedClub.id}");

    reff.remove();

    await reff.update({
      "club_name": _clubname.value.text,
      "id": EditDetails.touchedClub.id,
      "meeting_room": _mroom.value.text,
      "image_url": EditDetails.touchedClub.image_url, //urlDownload,
      "gallery_image": [
        "https://firebasestorage.googleapis.com/v0/b/tss-club.appspot.com/o/images%2Fifc8t%2Fgallery%2FIMG-20221123-WA0000.jpeg?alt=media&token=d703e61f-2ce2-438a-95c1-e7661fe0b076",
        "https://firebasestorage.googleapis.com/v0/b/tss-club.appspot.com/o/images%2Fifc8t%2Fgallery%2FIMG-20221123-WA0002.jpeg?alt=media&token=282e6747-9d03-40e6-9bb7-4315ebf5cd71",
        "https://firebasestorage.googleapis.com/v0/b/tss-club.appspot.com/o/images%2Fifc8t%2Fgallery%2FScreenshot_20221121-025321.jpg?alt=media&token=3996f5d3-af23-4c44-9a0b-e83ff53ea228"
      ],
      "meeting_days": _mday.value.text,
      "techear": _teacher.value.text,
      "description": _description.value.text,
      "ismr": EditDetails.touchedClub.ismr,
      "category": EditDetails.touchedClub.category,
      "admin_code": EditDetails.touchedClub.admincode,
    });

    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    EditDetails.touchedClub.club_name = _clubname.value.text;
    EditDetails.touchedClub.meeting_days = _mday.value.text;
    EditDetails.touchedClub.meeting_room = _mroom.value.text;
    EditDetails.touchedClub.techear = _teacher.value.text;
    EditDetails.touchedClub.description = _description.value.text;
    ClubDetails.touchedClub = EditDetails.touchedClub;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ClubBrowser()));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ClubDetails()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 246, 237),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: AppColor.yellow,
        centerTitle: true,
        title: TextField(
          textAlign: TextAlign.center,
          controller: _clubname,
          maxLines: 1,
        ),
        actions: [
          const Icon(Icons.admin_panel_settings),
          SizedBox(
            width: Dimensions.pwsize(3),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Dimensions.phsize(2)),
            //top image
            InkWell(
              onTap: () {
                selectfile();
              },
              child: Column(
                children: [
                  if (pickedFile == null)
                    Container(
                      height: Dimensions.phsize(30),
                      width: Dimensions.pwsize(90),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: NetworkImage(
                            EditDetails.touchedClub.image_url,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (pickedFile != null)
                    Container(
                      height: Dimensions.phsize(30),
                      width: Dimensions.pwsize(90),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Image.file(
                        File(pickedFile!.path!),
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  Text(
                    "tap to edit",
                    style: TextStyle(fontSize: Dimensions.font20),
                  )
                ],
              ),
            ),
            SizedBox(height: Dimensions.phsize(4)),
            // description divider
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
            // description data
            SizedBox(
              width: Dimensions.pwsize(83),
              child: TextField(
                textAlign: TextAlign.start,
                controller: _description,
                textInputAction: TextInputAction.newline,
                maxLines: null,
              ),
            ),
            SizedBox(height: Dimensions.phsize(2)),
            // meeting days divider
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
            // meeting days data
            SizedBox(
              width: Dimensions.pwsize(83),
              child: Center(
                child: TextField(
                  textAlign: TextAlign.start,
                  controller: _mday,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                ),
              ),
            ),
            SizedBox(height: Dimensions.phsize(1)),
            // meeting room divider
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
            // meetiing room data
            SizedBox(
              width: Dimensions.pwsize(83),
              child: Center(
                child: TextField(
                  textAlign: TextAlign.start,
                  controller: _mroom,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                ),
              ),
            ),
            SizedBox(height: Dimensions.phsize(1)),
            // teacher divider
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
            // teacher data
            SizedBox(
              width: Dimensions.pwsize(83),
              child: Center(
                child: TextField(
                  textAlign: TextAlign.start,
                  controller: _teacher,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                ),
              ),
            ),
            SizedBox(height: Dimensions.phsize(1)),
            // gallery divider
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
                    EditDetails.touchedClub.gallery_image.length, (index) {
                  return Image.network(
                      EditDetails.touchedClub.gallery_image[index]);
                })),
            SizedBox(height: Dimensions.phsize(5)),
            ElevatedButton(
              onPressed: () {
                submit();
              },
              child: const Text("Submit"),
            ),
            SizedBox(height: Dimensions.phsize(2)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                remove();
              },
              child: const Text("Delete"),
            ),
            SizedBox(height: Dimensions.phsize(2)),
          ],
        ),
      ),
    );
  }
}
