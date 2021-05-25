import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:bonfire_newbonfire/widget/bf_subcateg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../my_flutter_app_icons.dart';
import '../../../home_screen.dart';

AuthProvider _auth;

class Nature extends StatefulWidget {
  final String bonfire;

  Nature({this.bonfire});

  @override
  _NatureState createState() => _NatureState(
        bonfire: this.bonfire,
      );
}

class _NatureState extends State<Nature> {
  final String bonfire;

  // ANIMALS
  bool isDog = false, isCat = false, isBird = false, isUnique = false;
  String dogs = "Dogs",
      cats = "Cats",
      birds = "Birds",
      unique = "Unique",
      preserved = "Preserved animals";

  // PLANTS
  bool isIndoor = false, isOutdoor = false, isGardening = false, isDIY = false;
  String indoor = "Indoor",
      outdoor = "Outdoor",
      gardening = "Gardening",
      diy = "DIY";

  bool isSea = false, isTravel = false;
  bool isClimate = false;
  bool isGeneral = false;

  //Upload Data
  bool isUploading = false;

  String plants = "Plants";
  String sea = "Sea";
  String travel = "Travel";
  String climate = "Climate Change";
  String general = "General";
  String usersBonfire = "usersNature";
  String bf_id = "bf_Id";
  List<String> bonfires = [];

  int totalBonfires = 0;


  _NatureState({this.bonfire});

  @override
  Widget build(BuildContext context) {
    AuthProvider _auth = Provider.of<AuthProvider>(context, listen: false);
    final String currentUser = _auth.user?.uid;

    return Scaffold(
      backgroundColor: Color(0XFF232020),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0XFF232020),
        elevation: 0.0,
        title: Text(
          bonfire,
          style: TextStyle(color: Colors.white70, fontSize: 25.0),
        ),
        actions: [
          isUploading
              ? Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: SpinKitCircle(
                    color: Colors.orangeAccent,
                    size: 30.0,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Material(
                    color:
                        Colors.orange.shade600, //Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    elevation: 3.0,
                    child: MaterialButton(
                      onPressed: isUploading
                          ? null
                          : () async {
                              setState(() {
                                isUploading = true;
                              });
                              //TODO: Create function that iterates over a loop of for(category of List then add user in that bonfire)
                              for (var abonfire in bonfires) {
                                print(abonfire);
                                await DBService.instance.createBonfire(
                                  "Bonfire",
                                    bf_id,
                                    abonfire,
                                    "id_$abonfire",
                                    usersBonfire,
                                    _auth.user.uid);
                                /*await Firestore.instance.collection(abonfire)
                                    .document("bf_Id")
                                    .collection("usersNature")
                                    .document(currentUser)
                                    .setData({});*/
                              }
                              //Update activity Feed and add it
                              await Firestore.instance.collection("FeedItems")
                                  .document(_auth.user.uid)
                                  .collection("feedItems")
                                  .document(bf_id)
                                  .setData({
                                "type": "follow",
                                "ownerId": _auth.user.uid,
                                "username": currentUser,
                                "userId": currentUser,
                                "number": bonfires.length,
                                "isRead": false,
                                "timestamp":  Timestamp.now(),
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomeScreen(),
                                ),
                              );
                            },
                      minWidth: 50.0,
                      height: 30.0,
                      child: Text(
                        "DONE",
                        style: TextStyle(
                            letterSpacing: 0.3,
                            fontSize: 16.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text("Animals",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w800)),
              ),
              SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isDog = !isDog;
                    if (isDog == true) {
                      bonfires.add(dogs);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.guidedog,
                    data: dogs,
                    color1: isDog == false
                        ? Colors.brown.shade400.withBlue(35)
                        : Colors.grey,
                    color2: isDog == false
                        ? Colors.brown.shade200.withBlue(120)
                        : Colors.blueGrey,
                    isSelected: isDog),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isCat = !isCat;
                    if (isCat == true) {
                      bonfires.add(cats);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.cat,
                    data: "Cats",
                    color1: isCat == false
                        ? Colors.brown.shade400.withBlue(35)
                        : Colors.grey,
                    color2: isCat == false
                        ? Colors.brown.shade200.withBlue(120)
                        : Colors.blueGrey,
                    isSelected: isCat),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isBird = !isBird;
                    if (isDog == true) {
                      bonfires.add(birds);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.twitter_bird,
                    data: "Birds",
                    color1: isBird == false
                        ? Colors.brown.shade400.withBlue(35)
                        : Colors.grey,
                    color2: isBird == false
                        ? Colors.brown.shade200.withBlue(120)
                        : Colors.blueGrey,
                    isSelected: isBird),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isUnique = !isUnique;
                    if (isUnique == true) {
                      bonfires.add(unique);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.paw,
                    data: "Unique",
                    color1: isUnique == false
                        ? Colors.brown.shade400.withBlue(35)
                        : Colors.grey,
                    color2: isUnique == false
                        ? Colors.brown.shade200.withBlue(120)
                        : Colors.blueGrey,
                    isSelected: isUnique),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text("Plants",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w800)),
              ),
              SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isIndoor = !isIndoor;
                    if (isIndoor == true) {
                      bonfires.add(indoor);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.leaf,
                    data: indoor,
                    color1: isIndoor == false ? Colors.green : Colors.grey,
                    color2: isIndoor == false
                        ? Colors.greenAccent
                        : Colors.blueGrey,
                    isSelected: isIndoor),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isOutdoor = !isOutdoor;
                    if (isOutdoor == true) {
                      bonfires.add(outdoor);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.tree_2,
                    data: outdoor,
                    color1: isOutdoor == false ? Colors.green : Colors.grey,
                    color2: isOutdoor == false
                        ? Colors.greenAccent
                        : Colors.blueGrey,
                    isSelected: isOutdoor),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isGardening = !isGardening;
                    if (isGardening == true) {
                      bonfires.add(gardening);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.garden,
                    data: gardening,
                    color1: isGardening == false ? Colors.green : Colors.grey,
                    color2: isGardening == false
                        ? Colors.greenAccent
                        : Colors.blueGrey,
                    isSelected: isGardening),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isDIY = !isDIY;
                    if (isDIY == true) {
                      bonfires.add(plants);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.seedling,
                    data: diy,
                    color1: isDIY == false ? Colors.green : Colors.grey,
                    color2:
                        isDIY == false ? Colors.greenAccent : Colors.blueGrey,
                    isSelected: isDIY),
              ),
              /*SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text("Travel", style: TextStyle(color: Colors.white70, fontSize: 30.0, fontWeight: FontWeight.w800)),
              ),
              SizedBox(height: 15.0,),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTravel = !isTravel;
                    if (isTravel == true) {
                      bonfires.add(travel);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.earth,
                    data: "Countries",
                    color1: isTravel == false ? Colors.purple : Colors.grey,
                    color2: isTravel == false
                        ? Colors.deepPurple.shade300
                        : Colors.blueGrey),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTravel = !isTravel;
                    if (isTravel == true) {
                      bonfires.add(travel);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.paper_plane,
                    data: "States",
                    color1: isTravel == false ? Colors.purple : Colors.grey,
                    color2: isTravel == false
                        ? Colors.deepPurple.shade300
                        : Colors.blueGrey),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTravel = !isTravel;
                    if (isTravel == true) {
                      bonfires.add(travel);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.waves_outline,
                    data: "Beach",
                    color1: isTravel == false ? Colors.purple : Colors.grey,
                    color2: isTravel == false
                        ? Colors.deepPurple.shade300
                        : Colors.blueGrey),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTravel = !isTravel;
                    if (isTravel == true) {
                      bonfires.add(travel);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.paper_plane,
                    data: "Spiritual",
                    color1: isTravel == false ? Colors.purple : Colors.grey,
                    color2: isTravel == false
                        ? Colors.deepPurple.shade300
                        : Colors.blueGrey),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTravel = !isTravel;
                    if (isTravel == true) {
                      bonfires.add(travel);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.paper_plane,
                    data: "General",
                    color1: isTravel == false ? Colors.purple : Colors.grey,
                    color2: isTravel == false
                        ? Colors.deepPurple.shade300
                        : Colors.blueGrey),
              ),*/
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text("Environment",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w800)),
              ),
              SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isClimate = !isClimate;
                    if (isClimate == true) {
                      bonfires.add(climate);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.earth,
                    data: "Climate Change",
                    color1: isClimate == false
                        ? Colors.lightBlueAccent.shade700
                        : Colors.grey,
                    color2: isClimate == false
                        ? Colors.lightBlueAccent
                        : Colors.blueGrey),
              ),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orangeAccent),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 60.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/Yellow-Flame.png")),
                                    borderRadius: BorderRadius.circular(100.0),
                                    /*image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/flame_icon1.png")),*/
                                    //Theme.of(context).accentColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "+ Add New Bonfire",
                          style: TextStyle(
                              color: Colors.orangeAccent, fontSize: 25.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
