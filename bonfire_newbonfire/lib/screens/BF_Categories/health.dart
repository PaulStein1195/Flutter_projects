import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:bonfire_newbonfire/widget/bf_subcateg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../my_flutter_app_icons.dart';
import '../../../home.dart';

AuthProvider _auth;

class Health extends StatefulWidget {
  final String bonfire;

  Health({this.bonfire});

  @override
  _HealthState createState() =>
      _HealthState(
        bonfire: this.bonfire,
      );
}

class _HealthState extends State<Health> {
  final String bonfire;

  //FOOD
  bool isVegan = false,
      isVeggie = false,
      isPrep = false,
      isHealthy = false;
  String vegan = "Vegan",
      veggie = "Veggie",
      prep = "Prep Food",
      healthy = "Healthy";

  //EXERCISE
  bool isGYM = false,
      isAtHome = false,
      isHike = false,
      isOutdoor = false,
      isApp = false,
      isTips = false;
  String gym = "GYM",
      atHome = "At Home",
      hike = "Hike",
      outdoors = "Outdoors",
      app = "Apps",
      tips = "Tips";

  //MIND
  bool isMind = false,
      isNeuro = false,
      isHuber = false,
      isMeditation = false,
      isTalks = false,
      isRelaxation = false;
  String mindfulness = "Mindfulness",
      neuro = "Neurobiology",
      huberman = "Huberman",
      meditation = "Meditation",
      talks = "Talks",
      relaxation = "Relaxation";

  //BODY
  bool isCardiovascular = false,
      isProteins = false,
      isHeart = false,
      isLungs = false,
      isBasics = false;
  String cardio = "Cardiovascular",
      proteins = "Proteins",
      heart = "Heart",
      lungs = "Lungs",
      basics = "Basics";

  //Upload Data
  bool isUploading = false;


  //DB Collections
  String subColl = "usersHealth";
  String bf_id = "bf_health";
  List<String> bonfires = [];

  _HealthState({this.bonfire});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: Builder(
          builder: (BuildContext context) {
            _auth = Provider.of<AuthProvider>(context);
            final String currentUserId = _auth.user?.uid;
            return Scaffold(
              backgroundColor: Color(0XFF333333),
              appBar: AppBar(
                centerTitle: true,
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
                                "Health", bf_id, subColl, _auth.user.uid);
                            //Update activity Feed and add it
                          }
                          await Firestore.instance
                              .collection("FeedItems")
                              .document(_auth.user.uid)
                              .collection("feedItems")
                              .document(bf_id)
                              .setData({
                            "type": "follow",
                            "ownerId": _auth.user.uid,
                            "username": currentUserId,
                            "userId": currentUserId,
                            "number": bonfires.length,
                            "category": widget.bonfire,
                            "isRead": false,
                            "timestamp": Timestamp.now(),
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
                        child: Text("Food",
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
                            isVegan = !isVegan;
                            if (isVegan == true) {
                              bonfires.add(vegan);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.seedling,
                            data: vegan,
                            color1: isVegan == false
                                ? Colors.pinkAccent
                                : Colors.grey,
                            color2: isVegan == false
                                ? Color(0XFFC65F77)
                                : Colors.blueGrey,
                            isSelected: isVegan),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isVeggie = !isVeggie;
                            if (isVeggie == true) {
                              bonfires.add(veggie);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.garden,
                            data: veggie,
                            color1: isVeggie == false
                                ? Colors.pinkAccent
                                : Colors.grey,
                            color2: isVeggie == false
                                ? Color(0XFFC65F77)
                                : Colors.blueGrey,
                            isSelected: isVeggie),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPrep = !isPrep;
                            if (isPrep == true) {
                              bonfires.add(prep);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.dinner,
                            data: prep,
                            color1: isPrep == false
                                ? Colors.pinkAccent
                                : Colors.grey,
                            color2: isPrep == false
                                ? Color(0XFFC65F77)
                                : Colors.blueGrey,
                            isSelected: isPrep),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isHealthy = !isHealthy;
                            if (isHealthy == true) {
                              bonfires.add(healthy);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.food,
                            data: healthy,
                            color1: isHealthy == false
                                ? Colors.pinkAccent
                                : Colors.grey,
                            color2: isHealthy == false
                                ? Color(0XFFC65F77)
                                : Colors.blueGrey,
                            isSelected: isHealthy),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text("Exercise",
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
                            isGYM = !isGYM;
                            if (isGYM == true) {
                              bonfires.add(gym);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.store,
                            data: gym,
                            color1: isGYM == false ? Colors.deepOrangeAccent.shade400 : Colors.grey,
                            color2: isGYM == false
                                ? Colors.deepOrangeAccent.shade200
                                : Colors.blueGrey,
                            isSelected: isGYM),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isAtHome = !isAtHome;
                            if (isAtHome == true) {
                              bonfires.add(atHome);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.home,
                            data: atHome,
                            color1: isAtHome == false ? Colors.deepOrangeAccent.shade400 : Colors.grey,
                            color2: isAtHome == false
                                ? Colors.deepOrangeAccent.shade200
                                : Colors.blueGrey,
                            isSelected: isAtHome),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isHike = !isHike;
                            if (isHike == true) {
                              bonfires.add(hike);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.leaf,
                            data: hike,
                            color1: isHike == false ? Colors.deepOrangeAccent.shade400 : Colors.grey,
                            color2: isHike == false
                                ? Colors.deepOrangeAccent.shade200
                                : Colors.blueGrey,
                            isSelected: isHike),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isOutdoor = !isOutdoor;
                            if (isOutdoor == true) {
                              bonfires.add(outdoors);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.directions_bike,
                            data: outdoors,
                            color1: isOutdoor == false ? Colors.deepOrangeAccent.shade400 : Colors.grey,
                            color2:
                            isOutdoor == false ? Colors.deepOrangeAccent.shade200 : Colors.blueGrey,
                            isSelected: isOutdoor),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isApp = !isApp;
                            if (isApp == true) {
                              bonfires.add(app);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.mobile,
                            data: app,
                            color1: isApp == false ? Colors.deepOrangeAccent.shade400  : Colors.grey,
                            color2: isApp == false
                                ? Colors.deepOrangeAccent.shade200
                                : Colors.blueGrey,
                            isSelected: isApp),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isTips = !isTips;
                            if (isTips == true) {
                              bonfires.add(tips);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.lightbulb,
                            data: tips,
                            color1: isTips == false ? Colors.deepOrangeAccent.shade400  : Colors.grey,
                            color2: isTips == false
                                ? Colors.deepOrangeAccent.shade200
                                : Colors.blueGrey,
                            isSelected: isTips),
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
                        child: Text("Mind",
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
                            isMind = !isMind;
                            if (isMind == true) {
                              bonfires.add(mindfulness);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.eye,
                            data: mindfulness,
                            color1: isMind == false
                                ? Colors.amberAccent.shade700
                                : Colors.grey,
                            color2: isMind == false
                                ? Colors.amber.shade200
                                : Colors.blueGrey, isSelected: isMind),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isNeuro = !isNeuro;
                            if (isNeuro == true) {
                              bonfires.add(neuro);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.brain,
                            data: neuro,
                            color1: isNeuro == false
                                ? Colors.amberAccent.shade700
                                : Colors.grey,
                            color2: isNeuro == false
                                ? Colors.amber.shade200
                                : Colors.blueGrey,
                            isSelected: isNeuro),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isHuber = !isHuber;
                            if (isHuber == true) {
                              bonfires.add(huberman);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.user,
                            data: huberman,
                            color1: isHuber == false
                                ? Colors.amberAccent.shade700
                                : Colors.grey,
                            color2: isHuber == false
                                ? Colors.amber.shade200
                                : Colors.blueGrey,
                            isSelected: isHuber),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMeditation = !isMeditation;
                            if (isMeditation == true) {
                              bonfires.add(meditation);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.waves,
                            data: meditation,
                            color1: isMeditation == false
                                ? Colors.amberAccent.shade700
                                : Colors.grey,
                            color2: isMeditation == false
                                ? Colors.amber.shade200
                                : Colors.blueGrey,
                            isSelected: isMeditation),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      /* GestureDetector(
                onTap: () {
                  setState(() {
                    isRelaxation = !isRelaxation;
                    if (isRelaxation == true) {
                      bonfires.add(relaxation);
                    }
                  });
                },
                child: BF_SubCateg_Widget(
                    icon: MyFlutterApp.cat,
                    data: relaxation,
                    color1: isRelaxation == false
                        ? Colors.amberAccent.shade700
                        : Colors.grey,
                    color2: isRelaxation == false
                        ? Colors.amber.shade200
                        : Colors.blueGrey,
                    isSelected: isRelaxation),
              ),
              SizedBox(
                height: 10.0,
              ),*/
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isTalks = !isTalks;
                            if (isTalks == true) {
                              bonfires.add(talks);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.comment,
                            data: talks,
                            color1: isTalks == false
                                ? Colors.amberAccent.shade700
                                : Colors.grey,
                            color2: isTalks == false
                                ? Colors.amber.shade200
                                : Colors.blueGrey,
                            isSelected: isTalks),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text("Body",
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
                            isCardiovascular = !isCardiovascular;
                            if (isCardiovascular == true) {
                              bonfires.add(cardio);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.heart_pulse,
                            data: cardio,
                            color1: isCardiovascular == false
                                ? Colors.lightGreen.shade600
                                : Colors.grey,
                            color2: isCardiovascular == false
                                ? Colors.lightGreen.shade300
                                : Colors.blueGrey, isSelected: isCardiovascular),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isProteins = !isProteins;
                            if (isProteins == true) {
                              bonfires.add(proteins);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.star_1,
                            data: proteins,
                            color1: isProteins == false
                                ? Colors.lightGreen.shade600
                                : Colors.grey,
                            color2: isProteins == false
                                ? Colors.lightGreen.shade300
                                : Colors.blueGrey,
                            isSelected: isProteins),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isHeart = !isHeart;
                            if (isHeart == true) {
                              bonfires.add(heart);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.heart,
                            data: heart,
                            color1: isHeart == false
                                ? Colors.lightGreen.shade600
                                : Colors.grey,
                            color2: isHeart == false
                                ? Colors.lightGreen.shade300
                                : Colors.blueGrey,
                            isSelected: isHeart),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLungs = !isLungs;
                            if (isLungs == true) {
                              bonfires.add(lungs);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.air,
                            data: lungs,
                            color1: isLungs == false
                                ? Colors.lightGreen.shade600
                                : Colors.grey,
                            color2: isLungs == false
                                ? Colors.lightGreen.shade300
                                : Colors.blueGrey,
                            isSelected: isLungs),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isBasics = !isBasics;
                            if (isBasics == true) {
                              bonfires.add(basics);
                            }
                          });
                        },
                        child: BF_SubCateg_Widget(
                            icon: MyFlutterApp.book,
                            data: basics,
                            color1: isBasics == false
                                ? Colors.lightGreen.shade600
                                : Colors.grey,
                            color2: isBasics == false
                                ? Colors.lightGreen.shade300
                                : Colors.blueGrey,
                            isSelected: isBasics),
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
          },
        ),
    );
  }
}
