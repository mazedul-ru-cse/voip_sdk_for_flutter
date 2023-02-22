import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:voip24h_sdk_mobile/voip24h_sdk_mobile.dart';
import 'package:voip24h_sdk_mobile/callkit/utils/sip_event.dart';
import 'package:voip24h_sdk_mobile/callkit/utils/transport_type.dart';
import 'package:voip24h_sdk_mobile/callkit/model/sip_configuration.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _platformVersion = 'Unknown';

  TextEditingController phoneNumController = TextEditingController();

  void testCallKit() {
    var sipConfiguration = SipConfigurationBuilder(extension: "09643207254", domain: "59.152.98.66:5060", password: "I9qgj1L4OFyjHtgW")
        .setKeepAlive(true)
        .setPort(5060)
        .setTransport(TransportType.Udp)
        .build();
    Voip24hSdkMobile.callModule.initSipModule(sipConfiguration);
    Voip24hSdkMobile.callModule.eventStreamController.stream.listen((event) {
      switch (event['event']) {
        case SipEvent.AccountRegistrationStateChanged: {
          var body = event['body'];
          print("AccountRegistrationStateChanged");
          print(body);
        }
        break;
        case SipEvent.Ring: {
          var body = event['body'];
          print("Ring");
          print(body);
        }
        break;
        case SipEvent.Up: {
          var body = event['body'];
          print("Up");
          print(body);
        }
        break;
        case SipEvent.Hangup: {
          var body = event['body'];
          print("Hangup");
          print(body);
        }
        break;
        case SipEvent.Paused: {
          print("Paused");
        }
        break;
        case SipEvent.Resuming: {
          print("Resuming");
        }
        break;
        case SipEvent.Missed: {
          var body = event['body'];
          print("Missed");
          print(body);
        }
        break;
        case SipEvent.Error: {
          var body = event['body'];
          print("Error");
          print(body);
        }
        break;
      }
    });
  }

  @override
  void initState(){
    super.initState();
    requestPermission();
    initPlatformState();
   // testGraph();
    testCallKit();
  }

  Future<void> requestPermission() async {
    await Permission.microphone.request();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await Voip24hSdkMobile.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void call(String phoneNumber) {
    Voip24hSdkMobile.callModule.call(phoneNumber).then((value) => {
      print(value)
    }, onError: (error) => {
      print(error)
    });
  }

  void hangup() {
    Voip24hSdkMobile.callModule.hangup().then((value) => {
      print(value)
    }, onError: (error) => {
      print(error)
    });
  }

  void answer() {
    Voip24hSdkMobile.callModule.answer().then((value) => {
      print(value.toString())
    }, onError: (error) => {
      print(error)
    });
  }

  void reject() {
    Voip24hSdkMobile.callModule.reject().then((value) => {
      print(value)
    }, onError: (error) => {
      print(error)
    });
  }

  void pause() {
    Voip24hSdkMobile.callModule.pause().then((value) => {
      print(value)
    }, onError: (error) => {
      print(error)
    });
  }

  void resume() {
    Voip24hSdkMobile.callModule.resume().then((value) => {
      print(value.toString())
    }, onError: (error) => {
      print(error)
    });
  }

  void transfer(String extension) {
    Voip24hSdkMobile.callModule.transfer(extension).then((value) => {
      print(value.toString())
    }, onError: (error) => {
      print(error)
    });
  }

  void toggleMic() {
    Voip24hSdkMobile.callModule.toggleMic().then((value) => {
      print(value)
    }, onError: (error) => {
      print(error)
    });
  }

  void toggleSpeaker() {
    Voip24hSdkMobile.callModule.toggleSpeaker().then((value) => {
      print(value)
    }, onError: (error) => {
      print(error)
    });
  }

  void getMissedCalls() {
    Voip24hSdkMobile.callModule.getMissedCalls().then((value) => {
      print(value)
    }, onError: (error) => {
      print(error)
    });
  }

  void getRegistrationState() {
    Voip24hSdkMobile.callModule.getSipRegistrationState().then((value) => {
      print(value)
    }, onError: (error) {
      print(error);
    });
  }

  void isMicEnabled() {
    Voip24hSdkMobile.callModule.isMicEnabled().then((value) => print(value));
  }

  void isSpeakerEnabled() {
    Voip24hSdkMobile.callModule.isSpeakerEnabled().then((value) => print(value));
  }

  void getCallId() {
    Voip24hSdkMobile.callModule.getCallId().then((value) => {
      print(value)
    }, onError: (error) => {
      print(error)
    });
  }

  void sendDTMF(String dtmf) {
    Voip24hSdkMobile.callModule.sendDTMF(dtmf).then((value) => {
      print(value)
    }, onError: (error) => {
      print(error)
    });
  }

  void refreshSipAccount() {
    Voip24hSdkMobile.callModule.refreshSipAccount().then((value) => {
      print(value)
    }, onError: (error) => {
      print(error)
    });
  }

  void unregisterSipAccount() {
    Voip24hSdkMobile.callModule.unregisterSipAccount().then((value) => {
      print(value)
    }, onError: (error) => {
      print(error)
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.all(12.0), child: Text('Running on: $_platformVersion\n')),

                TextField(
                 textAlign: TextAlign.center,
                  controller: phoneNumController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Phone number",
                    hintMaxLines: 1
                  ),
                ),

                OutlinedButton(
                  child: const Text('Call'),
                  onPressed: () {
                    call(phoneNumController.text.toString());
                  },
                ),

                OutlinedButton(
                  child: const Text('Hangup'),
                  onPressed: () {
                    hangup();
                  },
                ),
                OutlinedButton(
                  child: const Text('Answer'),
                  onPressed: () {
                    answer();
                  },
                ),

                // OutlinedButton(
                //   child: const Text('Reject'),
                //   onPressed: () {
                //     reject();
                //   },
                // ),
                // OutlinedButton(
                //   child: const Text('Pause'),
                //   onPressed: () {
                //     pause();
                //   },
                // ),
                // OutlinedButton(
                //   child: const Text('Resume'),
                //   onPressed: () {
                //     resume();
                //   },
                // ),
                // OutlinedButton(
                //   child: const Text('Transfer'),
                //   onPressed: () {
                //     transfer("extension");
                //   },
                // ),
                // OutlinedButton(
                //   child: const Text('Toggle mic'),
                //   onPressed: () {
                //     toggleMic();
                //   },
                // ),
                // OutlinedButton(
                //   child: const Text('Toggle speaker'),
                //   onPressed: () {
                //     toggleSpeaker();
                //   },
                // ),
                // OutlinedButton(
                //   child: const Text('Send DTMF'),
                //   onPressed: () {
                //     sendDTMF("2#");
                //   },
                // ),
                // OutlinedButton(
                //   child: const Text('Get call id'),
                //   onPressed: () {
                //     getCallId();
                //   },
                // ),
                // OutlinedButton(
                //   child: const Text('Get missed calls'),
                //   onPressed: () {
                //     getMissedCalls();
                //   },
                // ),
                // OutlinedButton(
                //   child: const Text('Is mic enabled'),
                //   onPressed: () {
                //     isMicEnabled();
                //   },
                // ),
                // OutlinedButton(
                //   child: const Text('Is speaker enabled'),
                //   onPressed: () {
                //     isSpeakerEnabled();
                //   },
                // ),
                // OutlinedButton(
                //   child: const Text('Get registration state'),
                //   onPressed: () {
                //     getRegistrationState();
                //   },
                // ),
                // OutlinedButton(
                //   child: const Text('Refresh sip account'),
                //   onPressed: () {
                //     refreshSipAccount();
                //   },
                // ),
                // OutlinedButton(
                //   child: const Text('Unregister sip account'),
                //   onPressed: () {
                //     unregisterSipAccount();
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Voip24hSdkMobile.callModule.eventStreamController.close();
    super.dispose();
  }
}