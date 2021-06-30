import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/model/user.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:bonfire_newbonfire/widget/grid_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'id_token.dart';

AuthProvider _auth;

class CallPage_1 extends StatefulWidget {
  final String channelName;
  final ClientRole role;
  String title;

  CallPage_1({this.channelName, this.role, this.title});

  @override
  _CallPage_1State createState() => _CallPage_1State(this.title);
}

class _CallPage_1State extends State<CallPage_1> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  String title;
  bool muted = true;
  RtcEngine _engine;
  TextEditingController commentController = TextEditingController();

  _CallPage_1State(this.title);

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine.joinChannel(Token, widget.channelName, null, 0);
  }

  /// Create client instance
  Future<void> _initAgoraRtcEngine() async {
    RtcEngineConfig config = RtcEngineConfig(APP_ID);
    _engine = await RtcEngine.createWithConfig(config);
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role);
  }

  /// Define event handling
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }));
  }

  /// Toolbar layout
  Widget _toolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
        color: Colors.black54,
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 30.0,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: _onToggleMute,
                  child: Icon(
                    muted ? Icons.mic_off : Icons.mic,
                    color: muted ? Colors.orange : Colors.black87,
                    size: 25.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: muted ? kMainBoxColor : Colors.orange,
                  padding: const EdgeInsets.all(15.0),
                ),
                RawMaterialButton(
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.orange,
                    padding: const EdgeInsets.all(15.0),
                  onPressed: () => _onCallEnd(context),
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: kMainBoxColor,
                        size: 25.0,
                      ),
                      Text("EXIT")

                    ],
                  )
                ),
              ],
            ),
          ],
        ));
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF333333),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                kMainBoxColor,
                kMainBoxColor,
                Colors.black87,
                Colors.black87,
              ],
            ),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    kMainBoxColor,
                                    kMainBoxColor,
                                    Colors.black87,
                                    Colors.black87,
                                  ],
                                ),
                              ),
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                title: Column(
                                  children: [
                                    SizedBox(
                                      height: 50.0,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            widget.title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500, fontSize: 21.0),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                children: [
                                  ChangeNotifierProvider<AuthProvider>.value(
                                    value: AuthProvider.instance,
                                    child: Builder(
                                      builder: (BuildContext context) {
                                        _auth = Provider.of<AuthProvider>(context);
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: Text(
                                                    "HOSTS",
                                                    style: TextStyle(
                                                      color: Colors.grey[100],
                                                      fontSize: 17.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 300.0),
                                              child: Divider(
                                                color: Colors.orange,
                                                thickness: 1.5,
                                              ),
                                            ),
                                            Container(
                                              child: StreamBuilder<List<User>>(
                                                stream: DBService.instance.getUsersInDB(),
                                                builder: (_context, _snapshot) {
                                                  var _usersData = _snapshot.data;

                                                  /*if (_usersData != null) {
                                        _usersData.removeWhere((_contact) =>
                                            _contact.uid == _auth.user.uid);
                                      }*/
                                                  return _snapshot.hasData
                                                      ? SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 200,
                                                          child: ListView.builder(
                                                            itemCount: _usersData.length,
                                                            itemBuilder:
                                                                (BuildContext _context,
                                                                int _index) {
                                                              print(_usersData[_index]
                                                                  .name);
                                                              print(
                                                                  _usersData[_index].uid);
                                                              var _userData =
                                                              _usersData[_index];
                                                              return Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 12.0),
                                                                child: ListTile(
                                                                  onTap: () {
//Go to profile
                                                                  },
                                                                  title: Text(
                                                                    _userData.name,
                                                                    style: TextStyle(
                                                                        color:
                                                                        Colors.white),
                                                                  ),
                                                                  leading: Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          15),
                                                                      image:
                                                                      DecorationImage(
                                                                        fit: BoxFit.cover,
                                                                        image: _userData
                                                                            .profileImage ==
                                                                            null
                                                                            ? AssetImage(
                                                                            "")
                                                                            : NetworkImage(
                                                                            _userData
                                                                                .profileImage),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                      : Center(
                                                    child: CircularProgressIndicator(
                                                      color: kAmberColor,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: Text(
                                                    "ATTENDING",
                                                    style: TextStyle(
                                                      color: Colors.grey[100],
                                                      fontSize: 17.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 280.0),
                                              child: Divider(
                                                color: Colors.orange,
                                                thickness: 1.5,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Container(
                                              height: 400,
                                              child: GridUsers(),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Text("Image"),
                            ),
                            ExpansionTile(
                              collapsedBackgroundColor: Colors.black54,
                              backgroundColor: Colors.black54,
                              expandedAlignment: Alignment.centerLeft,
                              title: Container(
                                  alignment: Alignment.bottomRight,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          RawMaterialButton(
                                            onPressed: _onToggleMute,
                                            child: Icon(
                                              muted ? Icons.mic_off : Icons.mic,
                                              color: muted ? Colors.orange : Colors.black87,
                                              size: 25.0,
                                            ),
                                            shape: CircleBorder(),
                                            elevation: 2.0,
                                            fillColor:
                                            muted ? kMainBoxColor : Colors.orange,
                                            padding: const EdgeInsets.all(15.0),
                                          ),
                                          RawMaterialButton(
                                            onPressed: () => _onCallEnd(context),
                                            child: Icon(
                                              Icons.exit_to_app,
                                              color: kMainBoxColor,
                                              size: 25.0,
                                            ),
                                            shape: CircleBorder(),
                                            elevation: 2.0,
                                            fillColor: Colors.orange,
                                            padding: const EdgeInsets.all(15.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white70),
                                    controller: commentController,
                                    decoration: InputDecoration(
                                      border: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(30.0),
                                        ),
                                      ),
                                      //labelText: "Write your comment...",
                                      labelStyle: TextStyle(color: Colors.white70),
                                    ), //Theme.of(context).accentColor)),
                                  ),
                                ),
                              ],
                            ),
                          ]
                      ),
                    )
                )
            );
          })
        ),
      ),
    );
  }
}
