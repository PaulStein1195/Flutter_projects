import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:agora_rtc_engine/rtc_engine.dart';

const appId = "8abbd33aa1b64ea787900b1f3317a8b9";
const tempToken =
    "0068abbd33aa1b64ea787900b1f3317a8b9IAAkwRmFJf/DkAlolS0fxBglkeBjB7Qr52bH34S0DECdUtJjSIgAAAAAEACX33iMoxHNYAEAAQCiEc1g";

class RTCRoomScreen extends StatefulWidget {
  String title;

  RTCRoomScreen({this.title});

  @override
  _RTCRoomScreenState createState() => _RTCRoomScreenState(this.title);
}

class _RTCRoomScreenState extends State<RTCRoomScreen> {
  String title;
  bool muted = false;
  int _remoteUid;
  RtcEngine _engine;

  _RTCRoomScreenState(this.title);

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
  void dispose() {
    // clear users
    //_users.clear();
    // destroy sdk
    //_engine.complain("Agora", "Something went wrong");
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    //retrieve permissions
    await [Permission.microphone].request();

    //create the engine
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(appId));

    _engine.setEventHandler(
      RtcEngineEventHandler(
          joinChannelSuccess: (String channel, int uid, int elapsed) {
        print("Local user $uid joined");
        _engine.getCallId();
      }, userJoined: (int uid, int elapsed) {
        print("remote user $uid joined");
        setState(() {
          _remoteUid = uid;
        });
      }, userOffline: (int uid, UserOfflineReason reason) {
        print("remote user $uid left channel");
        setState(() {
          _remoteUid = null;
        });
      }),
    );

    await _engine.joinChannel(tempToken, "Agora", null, 0);
  }

  Widget _toolbar() {
    return Container(
        color: Colors.black54,
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_drop_down, size: 30.0,)),
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
        ));
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
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 25.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //TODO: Timer
                        Text(
                          "Participants name",
                          style: TextStyle(color: Colors.white70),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //TODO: Timer
                      Text(
                        "Content",
                        style: TextStyle(color: Colors.white70, fontSize: 50.0),
                      )
                    ],
                  ),
                ),
                _toolbar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
