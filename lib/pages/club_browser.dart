import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tss_clubs/pages/addclub.dart';
import 'package:tss_clubs/pages/club_details.dart';
import 'package:tss_clubs/utils/appcolors.dart';
import 'package:tss_clubs/utils/club.dart';
import 'package:tss_clubs/utils/dimensions.dart';
import 'package:tss_clubs/utils/links.dart';
import 'package:tss_clubs/widgets/big_text.dart';
import 'package:tss_clubs/widgets/search_widget.dart';
import 'package:tss_clubs/widgets/small_text.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:firebase_database/firebase_database.dart';

class ClubBrowser extends StatefulWidget {
  static late String club;

  static int lastId = 0;

  //set setClub(String club) => this.club = club;

  //ClubBrowser(this.club);

  const ClubBrowser({super.key});

  @override
  State<ClubBrowser> createState() => _ClubBrowserState();
}

class _ClubBrowserState extends State<ClubBrowser> {
  FirebaseDatabase database = FirebaseDatabase.instance;

  bool notloaded = true;
  bool notloaded2 = true;
  List<club> Clubs = [];
  List<club> dontouchClubs = [];
  List<club> mrClubs = [];
  bool? admin = false;
  bool statechanged = false;
  PageController pageController = PageController(viewportFraction: 0.85);
  final _search = TextEditingController();
  var _currpagevalue = 0.0;
  double _scalefactor = 0.8;
  double _height = Dimensions.pageViewContainer;
  String query = "";

  @override
  void initState() {
    super.initState();
    //fetchSliderItems();
    //fetchItems();
    fetchFromFirebase();
    pageController.addListener(() {
      setState(() {
        _currpagevalue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    _search.dispose();
    super.dispose();
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
    //loading
    while (notloaded || notloaded2) {
      debugPrint(admin.toString());

      //admin check
      if (!statechanged) {
        getboolfromsharedpref();
      }
      return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: AppColor.yellow,
          centerTitle: true,
          title: Text(
            "${ClubBrowser.club} clubs",
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: AppColor.yellow,
          centerTitle: true,
          title: Text(
            "${ClubBrowser.club} clubs",
          ),
          actions: [
            const Icon(Icons.admin_panel_settings),
            SizedBox(
              width: Dimensions.pwsize(3),
            ),
          ],
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Dimensions.phsize(3)),
                //most relevant
                // Center(
                //   child: Container(
                //     height: Dimensions.phsize(6),
                //     width: Dimensions.screenwidth - 30,
                //     decoration: BoxDecoration(
                //       borderRadius:
                //           BorderRadius.circular(Dimensions.phsize(20)),
                //       color: AppColor.purple,
                //     ),
                //     child: Center(
                //         child: Text(
                //       "Most Relevant",
                //       style: TextStyle(fontSize: Dimensions.hsize(30)),
                //     )),
                //   ),
                // ),
                //SizedBox(height: Dimensions.phsize(2)),
                // slider
                SizedBox(
                  height: Dimensions.phsize(27),
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: mrClubs.length,
                      itemBuilder: (context, position) {
                        final Club = mrClubs[position];

                        return _buildPageItem(position, Club);
                      }),
                ),
                SizedBox(height: Dimensions.phsize(2.5)),
                buildSearch(),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Clubs.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final Club = Clubs[index];

                    return clubsBrowser(Club);
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: Dimensions.pwsize(2),
                bottom: Dimensions.phsize(2),
              ),
              child: FloatingActionButton(
                backgroundColor: AppColor.blue,
                onPressed: () {
                  //add new club
                  AddClub.lastid = ClubBrowser.lastId;
                  AddClub.category = ClubBrowser.club;
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AddClub()));
                },
                child: Icon(
                  Icons.add,
                  size: Dimensions.font30,
                ),
              ),
            ),
          ),
        ]),
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
            "${ClubBrowser.club} clubs",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Dimensions.phsize(3)),
              //most relevant
              Center(
                child: Container(
                  height: Dimensions.phsize(4),
                  width: Dimensions.screenwidth - 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.phsize(20)),
                    color: AppColor.purple,
                  ),
                  child: Center(
                      child: Text(
                    "most relevant",
                    style: TextStyle(fontSize: Dimensions.font20),
                  )),
                ),
              ),
              SizedBox(height: Dimensions.phsize(2)),
              // slider
              SizedBox(
                height: Dimensions.phsize(27),
                child: PageView.builder(
                    controller: pageController,
                    itemCount: mrClubs.length,
                    itemBuilder: (context, position) {
                      final Club = mrClubs[position];
                      //print("8");

                      return _buildPageItem(position, Club);
                    }),
              ),
              SizedBox(height: Dimensions.phsize(2.5)),
              buildSearch(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Clubs.length,
                itemBuilder: (
                  context,
                  index,
                ) {
                  final Club = Clubs[index];

                  return clubsBrowser(Club);
                },
              )
            ],
          ),
        ),
      );
    }
  }

  /////////////////////////////  top slider maker /////////////////////////////
  Widget _buildPageItem(int index, club Club) {
    //print("Club issssssslider : ${Club}");

    //size change efect
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currpagevalue.floor() /*floor is used to round the number*/) {
      var currscale = 1 - (_currpagevalue - index) * (1 - _scalefactor);
      var currtrans = _height * (1 - currscale) / 2;
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currpagevalue.floor() + 1) {
      var currscale =
          _scalefactor + (_currpagevalue - index + 1) * (1 - _scalefactor);
      var currtrans = _height * (1 - currscale) / 2;
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currpagevalue.floor() - 1) {
      var currscale =
          _scalefactor + (_currpagevalue - index - 1) * (1 - _scalefactor);
      var currtrans = _height * (1 - currscale) / 2;
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else {
      var currscale = 0.8;
      var currtrans = _height * (1 - currscale) / 2;
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    }
    // cards builder
    return InkWell(
      borderRadius: BorderRadius.circular(Dimensions.height30),
      onTap: () {
        debugPrint(Club.club_name);
        ClubDetails.touchedClub = Club;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ClubDetails()));
      },
      onLongPress: () {
        print(Club.club_name);
        if (admin == true)
          changeismr(Club);
        else
          print("you dont have access");
      },
      child: Transform(
        transform: matrix,
        child: Container(
          height: Dimensions.phsize(27),
          width: Dimensions.pwsize(27),
          margin: EdgeInsets.only(
              left: Dimensions.pwsize(3), right: Dimensions.pwsize(3)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.height30),
            color: index.isEven ? AppColor.blue : AppColor.green,
          ),
          child: Column(
            children: [
              Container(
                height: Dimensions.phsize(22),
                width: Dimensions.screenwidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.height30),
                    topRight: Radius.circular(Dimensions.height30),
                    // bottomLeft: Radius.circular(Dimensions.height30),
                    // bottomRight: Radius.circular(Dimensions.height30),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(Club.image_url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.phsize(1)),
              bigText(text: Club.club_name),
            ],
          ),
        ),
      ),
    );
  }

  //////////////////////////////////////////
  void fetchFromFirebase() async {
    var ref = FirebaseDatabase.instance.ref();
    ref.reactive();
    var snapshot = await ref.get();
    debugPrint(snapshot.value.toString());
    var snapshotList = [];

    for (var item in snapshot.value as List) {
      snapshotList.addNonNull(item);
    }

    if (snapshot.exists) {
      Clubs.clear();
      dontouchClubs.clear();

      setState(() {
        for (var item in snapshotList) {
          var club_item = club(
            item['club_name'],
            item['id'],
            item['meeting_room'],
            item['image_url'],
            item['meeting_days'],
            item['techear'],
            item['description'],
            item['category'],
            item['ismr'],
            item['admin_code'],
            item['gallery_image'],
          );
          Clubs.add(club_item);
          dontouchClubs.add(club_item);
          if (item["ismr"]) {
            print(item["club_name"]);
            mrClubs.add(club_item);
          }
          ClubBrowser.lastId = item["id"];
        }
        Clubs = Clubs.where((clubb) {
          final title = clubb.category;
          final category = ClubBrowser.club;

          return title.contains(category);
        }).toList();
        dontouchClubs = dontouchClubs.where((clubb) {
          final title = clubb.category;
          final category = ClubBrowser.club;

          return title.contains(category);
        }).toList();
        // mrClubs = dontouchClubs;
        mrClubs = mrClubs.where((clubb) {
          final title = clubb.category;
          final category = ClubBrowser.club;
          final data = title.contains(category);
          return data;
        }).toList();
        notloaded = false;
      });
    } else {
      debugPrint('No data available.');
    }
  }

  ///////////////////////////// search widget setting /////////////////////////////
  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: "club name",
        onChanged: searchClub,
      );
  ///////////////////////////// list view /////////////////////////////
  Widget clubsBrowser(club clubs) => InkWell(
        onTap: () {
          debugPrint("details of " + clubs.club_name);
          ClubDetails.touchedClub = clubs;
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ClubDetails()));
        },
        onLongPress: () {
          if (admin == true) {
            changeismr(clubs);
            debugPrint("edit " + clubs.club_name);
          } else {
            print("you dont have access");
          }
        },
        child: Container(
          margin: EdgeInsets.only(
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: Dimensions.height10,
              top: Dimensions.height10),
          child: Row(
            children: [
              // image section
              Container(
                height: Dimensions.height120,
                width: Dimensions.width120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white38,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(clubs.image_url),
                  ),
                ),
              ),
              // text section
              Expanded(
                child: Container(
                  height: Dimensions.height100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        bottomRight: Radius.circular(Dimensions.radius20)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimensions.width10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        bigText(text: clubs.club_name),
                        SizedBox(height: Dimensions.height5),
                        smallText(text: clubs.description),
                        SizedBox(height: Dimensions.height5),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
  ///////////////////////////// search function and filtering /////////////////////////////
  void searchClub(String query) async {
    Clubs = dontouchClubs;
    final clubs = Clubs.where((clubb) {
      final title = clubb.club_name.toLowerCase();
      final search = query.toLowerCase();

      return title.contains(search);
    }).toList();

    setState(() {
      //print("Clubs : ${Clubs.length} & clubs : ${clubs.length}");
      this.query = query;
      this.Clubs = clubs;
    });
  }

  void changeismr(club touchedClub) async {
    String dialogtext =
        "are you sure you want to remove this club from most relevants?";
    debugPrint("club id is : " + touchedClub.id.toString());
    DatabaseReference ref = FirebaseDatabase.instance.ref("${touchedClub.id}");
    bool newismr = !touchedClub.ismr;
    debugPrint(newismr.toString());

    if (newismr) {
      dialogtext = "are you sure you want to add this club to most relevants?";
    }

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Alert"),
        content: Text(dialogtext),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              color: AppColor.yellow,
              padding: const EdgeInsets.all(14),
              child: const Text(
                "No",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await ref.update({
                "ismr": newismr,
              });
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ClubBrowser()));
              // showDialog(
              //   context: context,
              //   builder: (ctx) => AlertDialog(
              //     title: const Text("Alert"),
              //     content:
              //         const Text("data will change when you reload this page"),
              //     actions: <Widget>[
              //       TextButton(
              //         onPressed: () {
              //           Navigator.of(ctx).pop();
              //         },
              //         child: Container(
              //           color: AppColor.yellow,
              //           padding: const EdgeInsets.all(14),
              //           child: const Text(
              //             "ok",
              //             style: TextStyle(color: Colors.black),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            },
            child: Container(
              color: AppColor.yellow,
              padding: const EdgeInsets.all(14),
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
