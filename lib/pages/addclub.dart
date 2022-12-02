import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:tss_clubs/pages/Club_Browser.dart';
import 'package:tss_clubs/utils/appcolors.dart';
import 'package:tss_clubs/utils/dimensions.dart';
import 'package:tss_clubs/utils/links.dart';
import 'package:tss_clubs/widgets/big_text.dart';
import 'package:tss_clubs/widgets/small_text.dart';

class AddClub extends StatefulWidget {
  static late String category;
  static late int lastid;

  const AddClub({super.key});

  @override
  State<AddClub> createState() => _AddClubState();
}

class _AddClubState extends State<AddClub> {
  PlatformFile? pickedFile;
  int currimage = 0;
  List<PlatformFile> galleryImages = [];
  UploadTask? uploadTask;
  String category = AddClub.category;
  int count = 1;

  Future submit() async {
    if (_clubname.value.text != "" &&
        _description.value.text != "" &&
        _mday.value.text != "" &&
        _mroom.value.text != "" &&
        _teacher.value.text != "" &&
        pickedFile != null &&
        galleryImages.isNotEmpty) {
      final path = "images/${_clubname.value.text}/${pickedFile!.name}";
      final file = File(pickedFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });

      final snapshot = await uploadTask!.whenComplete(() => null);

      final urlDownload = await snapshot.ref.getDownloadURL();
      print(urlDownload);

      setState(() {
        uploadTask = null;
      });

      List urls = [];
      for (var img in galleryImages) {
        setState(() {
          count++;
        });
        final path = "images/${_clubname.value.text}/gallery/${img.name}";
        final file = File(img.path!);

        print(img.name);

        final ref = FirebaseStorage.instance.ref().child(path);
        setState(() {
          uploadTask = ref.putFile(file);
        });

        final snapshot = await uploadTask!.whenComplete(() => null);

        final url = await snapshot.ref.getDownloadURL();
        print(url);
        urls.add(url);

        setState(() {
          uploadTask = null;
        });
      }
      print(
          "/////////////////////////////////////////////////////////////////////////////////");
      print(urls);

      DatabaseReference reff =
          FirebaseDatabase.instance.ref("${AddClub.lastid + 1}");

      await reff.update({
        "club_name": _clubname.value.text,
        "id": AddClub.lastid + 1,
        "meeting_room": _mroom.value.text,
        "image_url": urlDownload,
        "gallery_image": urls,
        "meeting_days": _mday.value.text,
        "techear": _teacher.value.text,
        "description": _description.value.text,
        "ismr": false,
        "category": category,
        "admin_code": _adminCode.value.text,
      });
      ClubBrowser.lastId++;
      Navigator.of(context).pop();
      ClubBrowser.club = category;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ClubBrowser()));
    } else {
      debugPrint("fill all");
    }
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

  Future addpic() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }
    setState(() {
      galleryImages.add(result.files.first);
    });
  }

  bool ismr = false;
  final _clubname = TextEditingController();
  final _description = TextEditingController();
  final _mday = TextEditingController();
  final _mroom = TextEditingController();
  final _teacher = TextEditingController();
  final _adminCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: AppColor.yellow,
        centerTitle: true,
        title: Text(
          "add club",
        ),
        actions: [
          const Icon(Icons.admin_panel_settings),
          SizedBox(
            width: Dimensions.pwsize(3),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RadioListTile(
              title: Text("Science & Math"),
              value: "Science & Math",
              groupValue: category,
              onChanged: (value) {
                setState(() {
                  category = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Technology"),
              value: "Technology",
              groupValue: category,
              onChanged: (value) {
                setState(() {
                  category = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Sports"),
              value: "Sports",
              groupValue: category,
              onChanged: (value) {
                setState(() {
                  category = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Other"),
              value: "Other",
              groupValue: category,
              onChanged: (value) {
                setState(() {
                  category = value.toString();
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.pwsize(3), right: Dimensions.pwsize(3)),
              child: TextField(
                controller: _clubname,
                decoration: InputDecoration(
                    hintText: "club name",
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15))),
              ),
            ),
            SizedBox(height: Dimensions.phsize(1)),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.pwsize(3), right: Dimensions.pwsize(3)),
              child: TextField(
                textInputAction: TextInputAction.newline,
                maxLines: null,
                controller: _description,
                decoration: InputDecoration(
                    hintText: "description",
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15))),
              ),
            ),
            SizedBox(height: Dimensions.phsize(1)),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.pwsize(3), right: Dimensions.pwsize(3)),
              child: TextField(
                controller: _mday,
                decoration: InputDecoration(
                    hintText: "meeting days",
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15))),
              ),
            ),
            SizedBox(height: Dimensions.phsize(1)),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.pwsize(3), right: Dimensions.pwsize(3)),
              child: TextField(
                controller: _mroom,
                decoration: InputDecoration(
                    hintText: "meeting room",
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15))),
              ),
            ),
            SizedBox(height: Dimensions.phsize(1)),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.pwsize(3), right: Dimensions.pwsize(3)),
              child: TextField(
                controller: _teacher,
                decoration: InputDecoration(
                    hintText: "teacher name",
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15))),
              ),
            ),
            SizedBox(height: Dimensions.phsize(1)),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.pwsize(3), right: Dimensions.pwsize(3)),
              child: TextField(
                controller: _adminCode,
                decoration: InputDecoration(
                    hintText: "admin code",
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15))),
              ),
            ),
            ElevatedButton(
                onPressed: selectfile,
                child: const Text("select main picture")),
            if (pickedFile != null)
              Container(
                height: Dimensions.phsize(30),
                child: Image.file(
                  File(pickedFile!.path!),
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            SizedBox(height: Dimensions.phsize(2)),
            ElevatedButton(
              child: const Text("select gallery pictures"),
              onPressed: addpic,
            ),
            SizedBox(height: Dimensions.phsize(2)),
            if (galleryImages.isNotEmpty)
              Column(
                children: [
                  InkWell(
                    onLongPress: () {
                      setState(() {
                        galleryImages.removeAt(currimage);
                        currimage = 0;
                      });
                    },
                    child: ImageSlideshow(
                        onPageChanged: (value) {
                          currimage = value;
                          print(currimage);
                        },
                        height: Dimensions.phsize(30),
                        initialPage: 0,
                        children: List.generate(
                            galleryImages.length,
                            (index) =>
                                Image.file(File(galleryImages[index].path!)))),
                  ),
                  Center(child: bigText(text: "long press to remove")),
                ],
              ),
            SizedBox(height: Dimensions.phsize(2)),
            ElevatedButton(onPressed: submit, child: const Text("submit")),
            SizedBox(height: Dimensions.phsize(2)),
            buildProgress(),
          ],
        ),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;

          return SizedBox(
            height: Dimensions.height45,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text(
                    "picture number ${count}   ${(100 * progress).roundToDouble()}%",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(height: Dimensions.height45);
        }
      });
}
