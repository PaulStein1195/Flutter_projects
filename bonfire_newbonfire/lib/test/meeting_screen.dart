import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:agora_rtc_engine/rtc_engine.dart';


const appId = "1bb45c2ef7084d2082a812584918ce4d";
const tempToken =
    "0061bb45c2ef7084d2082a812584918ce4dIAARZs8Ca2mO38o7513+4+tBQ91rCDif+u3txZSWoNR26FWT+j0AAAAAEACRer0x//qfYAEAAQD++p9g";

class MeetingScreen extends StatefulWidget {
  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  bool muted = false;
  int _remoteUid;
  RtcEngine _engine;

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
  void initState()  {
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

          },
          userJoined: (int uid, int elapsed) {
            print("remote user $uid joined");
            setState(() {
              _remoteUid = uid;
            });
          },
          userOffline: (int uid, UserOfflineReason reason) {
            print("remote user $uid left channel");
            setState(() {
              _remoteUid = null;
            });
          }
      ),
    );

    await _engine.joinChannel(tempToken, "Agora", null, 0);
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Theme.of(context).accentColor,
              size: 30.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Theme.of(context).accentColor : Colors.white,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 30.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.deepOrange,
            padding: const EdgeInsets.all(15.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF333333),
      appBar: AppBar(title: Text("Bonfire"), centerTitle: true,),
      body:Center(
        child: Stack(
          children: <Widget>[
            _toolbar(),
          ],
        ),
      ),
    );
  }
}
