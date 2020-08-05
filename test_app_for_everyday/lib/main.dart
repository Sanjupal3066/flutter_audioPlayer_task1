import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

main() {
  runApp(myApp());
}

class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  AudioPlayer myPlayer = AudioPlayer();
  bool statee = false;
  double values = 0;
  bool stateLoop = false;
  Duration _start = Duration(), _end = Duration();
  String position = "", duration = "", songName = "";
  void initState() {
    super.initState();
    myPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _end = d;
        duration = d.toString().split(".")[0];
      });
    });

    myPlayer.onAudioPositionChanged.listen((Duration d) {
      setState(() {
        _start = d;
        position = d.toString().split(".")[0];
      });
    });

    myPlayer.onPlayerCompletion.listen((event) {
      myPlayer.onSeekComplete;
      setState(() {
        position = duration;
      });
    });
  }

  void myLoop() {
    if (stateLoop == false) {
      stateLoop = true;
      Fluttertoast.showToast(
          msg: "Loop Enabled",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.brown,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      stateLoop = false;
      Fluttertoast.showToast(
          msg: "Loop Disabled",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.brown,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void seekToSecond(int second) {
    Duration duration = Duration(seconds: second);
    myPlayer.seek(duration);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.brown.shade100,
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.audiotrack),
              onPressed: () async {
                String path = await FilePicker.getFilePath();
                songName = path.toString().split('/')[7];
                // print("Song Name: " + path.toString().split('/')[7]);
                int status = await myPlayer.play(path, isLocal: true);
                if (status == 1) {
                  setState(() {
                    stateLoop = false;
                    Fluttertoast.showToast(
                        msg: songName,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.brown,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    statee = true;
                  });
                }
              }),
          appBar: AppBar(
            title: Text("Audio Player"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.mail),
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "Sanjupal3066@gmail.com",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.brown,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        color: Colors.brown.shade300,
                      ),
                    ],
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (statee
                            ? AssetImage('images/tenor.gif')
                            : AssetImage('images/tenor2.gif'))),
                    borderRadius: BorderRadius.circular(180),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.stop),
                        iconSize: 35,
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Music Stopped",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.brown,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          myPlayer.stop();
                          setState(() {
                            statee = false;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.fast_rewind),
                        iconSize: 35,
                        onPressed: () {
                          if (_start.inMilliseconds > 10000) {
                            Fluttertoast.showToast(
                                msg: "Rewind 10Sec",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.brown,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            myPlayer.seek(Duration(
                                milliseconds: _start.inMilliseconds - 10000));
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(statee ? Icons.pause : Icons.play_arrow),
                        iconSize: 35,
                        onPressed: () {
                          if (statee == true) {
                            myPlayer.pause();
                            Fluttertoast.showToast(
                                msg: "Music Pause",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.brown,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            setState(() {
                              statee = false;
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "Music Play",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.brown,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            myPlayer.resume();
                            setState(() {
                              statee = true;
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.fast_forward),
                        iconSize: 35,
                        onPressed: () {
                          if (_start.inMilliseconds + 10000 <
                              _end.inMilliseconds) {
                            Fluttertoast.showToast(
                                msg: "Forward 10Sec",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.brown,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            myPlayer.seek(Duration(
                                milliseconds: _start.inMilliseconds + 10000));
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.loop),
                        iconSize: 35,
                        onPressed: myLoop,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(songName),
                ),
                Slider(
                  value: _start.inSeconds.toDouble(),
                  min: 0,
                  max: _end.inSeconds.toDouble(),
                  onChanged: (double value) {
                    if (value < _end.inMilliseconds) {
                      setState(() {
                        seekToSecond(value.toInt());
                        value = value;
                      });
                    }
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Row(
                    children: <Widget>[
                      Text(
                        position,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(" / "),
                      Text(
                        duration,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
