import 'package:flutter/material.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/services/image.dart';
import 'package:provider/provider.dart';

// Future<void> _takePicture() async {
//   final imageFile = await ImagePicker.pickImage(
//     source: ImageSource.camera
//     );
// }

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  //DatabaseService _ds; 
  ImageService _is = ImageService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    print(user);
    //_ds = DatabaseService(uid: user.uid);
    //User complete_user = _ds.user;

    return new Scaffold(
        appBar: AppBar(
            title: Text('Chat'),
        leading: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
             
        ),
        body: new Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 250.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // new Icon(
                        // Icons.arrow_back_ios,
                        //    color: Colors.black,
                          //  size: 22.0,
                        // ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 25.0),
                          //   child: new Text('Back',
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 20.0,
                          //           fontFamily: 'sans-serif-light',
                          //           color: Colors.black)),
                          // )

                        ],
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: _is.getImageForDisplay().image,
                                    // new ExactAssetImage(
                                    //     'assets/images/as.png'),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 90.0, right: 100.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                shape: CircleBorder(),
                                onPressed: () async { 
                                  _is.getImage(fromGallery: false);
                                  setState(() {});
                                },
                                child: new CircleAvatar(
                                  backgroundColor: Colors.lightGreen,
                                  radius: 25.0,
                                  child: new Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 90.0, left: 100.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                shape: CircleBorder(),
                                onPressed: () async {
                                  _is.getImage(fromGallery: true);
                                  setState(() {});
                                },
                                child: new CircleAvatar(
                                  backgroundColor: Colors.lightGreen,
                                  radius: 25.0,
                                  child: new Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                      ]),
                    )
                  ],
                ),
              ),
              new Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'PROFILE',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _status ? _getEditIcon() : new Container(),
                                ],
                              )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'First Name',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  decoration: InputDecoration(
                                    hintText: user == null ? '' : user.firstName ?? '', // 'First Name'
                                    //complete_user.firstName,

                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,

                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Last Name',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  decoration: InputDecoration(
                                    hintText: user == null ? '' : user.lastName ?? '', // 'Last Name'
                                    //complete_user.firstName,

                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,

                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Address',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  decoration: InputDecoration(
                                      hintText: user == null ? '' : user.address ?? '',
                                   ), // "Enter Email Adress"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Phone Number',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  decoration: InputDecoration(
                                    hintText: user == null ? '' : user.phone ?? '',
                                  ), // "Enter Mobile Number"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      // Padding(
                      //     padding: EdgeInsets.only(
                      //         left: 25.0, right: 25.0, top: 25.0),
                          // child: new Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: <Widget>[
                          //     Expanded(
                          //       child: Container(
                          //         child: new Text(
                          //           'NJNJEOSFN',
                          //           style: TextStyle(
                          //               fontSize: 16.0,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       flex: 2,
                          //     ),
                          //     Expanded(
                          //       child: Container(
                          //         child: new Text(
                          //           'Confirm Password',
                          //           style: TextStyle(
                          //               fontSize: 16.0,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       flex: 2,
                          //     ),
                          //   ],
                          // )),
                      // Padding(
                      //     padding: EdgeInsets.only(
                      //         left: 25.0, right: 25.0, top: 2.0),
                      //     child: new Row(
                      //       mainAxisSize: MainAxisSize.max,
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: <Widget>[
                      //         Flexible(
                      //           child: Padding(
                      //             padding: EdgeInsets.only(right: 10.0),
                      //             child: new TextField(
                      //               decoration: const InputDecoration(
                      //                   hintText: "Enter Password"),
                      //               enabled: !_status,
                      //             ),
                      //           ),
                      //           flex: 2,
                      //         ),
                      //         Flexible(
                      //           child: new TextField(
                      //             decoration: const InputDecoration(
                      //                 hintText: "Confirm Password"),
                      //             enabled: !_status,
                      //           ),
                      //           flex: 2,
                      //         ),
                      //       ],
                      //     )),
                      !_status ? _getActionButtons() : new Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.black,
                color: Colors.lightGreen,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red[500],
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.lightGreen,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}