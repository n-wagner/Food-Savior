import 'package:flutter/material.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/services/image.dart';
import 'package:provider/provider.dart';
import 'package:food_savior/services/size_config.dart';
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
    //SizeConfigService.init(context);
    User user = Provider.of<User>(context);
    SizeConfigService.init(context);
    print(user);
    //_ds = DatabaseService(uid: user.uid);
    //User complete_user = _ds.user;

    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Profile', 
            style: TextStyle( fontSize: 20), 
            textAlign: TextAlign.center),
          leading: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
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
                height: SizeConfigService.blockSizeVertical * 27,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfigService.blockSizeHorizontal * 20, 
                        top: SizeConfigService.blockSizeVertical * 2
                        ),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                width: SizeConfigService.blockSizeHorizontal * 40,
                                height: SizeConfigService.blockSizeVertical * 20,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: _is.getImageForDisplay().image,
                                    fit: BoxFit.cover,
                                  ),
                                )
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: SizeConfigService.blockSizeVertical * 14,    // old value: 90
                            right: SizeConfigService.blockSizeHorizontal * 20 // old value: 100.0
                          ),
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
                          padding: EdgeInsets.only(
                            top: SizeConfigService.blockSizeVertical * 14,    // old value: 90
                            left: SizeConfigService.blockSizeHorizontal * 20 // old value: 100
                            ),
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
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfigService.blockSizeHorizontal * 5, // old value 25
                              right: SizeConfigService.blockSizeHorizontal * 5,// old value 25 
                              top: SizeConfigService.blockSizeHorizontal * 1 // 
                            ),
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
                                        fontSize: 25.0,
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
                          )
                        ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfigService.blockSizeHorizontal * 5, // old value 25
                              right: SizeConfigService.blockSizeHorizontal * 5,// old value 25 
                              top: SizeConfigService.blockSizeHorizontal * 5// 
                            ),
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
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfigService.blockSizeHorizontal * 5, // old value 25
                              right: SizeConfigService.blockSizeHorizontal * 5,// old value 25 
                              top: SizeConfigService.blockSizeHorizontal * 1// 
                            ),
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
                            left: SizeConfigService.blockSizeHorizontal * 5, // old value 25
                            right: SizeConfigService.blockSizeHorizontal * 5,// old value 25 
                            top: SizeConfigService.blockSizeHorizontal * 1// 
                          ),
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
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfigService.blockSizeHorizontal * 5, // old value 25
                            right: SizeConfigService.blockSizeHorizontal * 5,// old value 25 
                            top: SizeConfigService.blockSizeHorizontal * 1// 
                          ),
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
                            left: SizeConfigService.blockSizeHorizontal * 5, // old value 25
                            right: SizeConfigService.blockSizeHorizontal * 5,// old value 25 
                            top: SizeConfigService.blockSizeHorizontal * 1// 
                          ),
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
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfigService.blockSizeHorizontal * 5, // old value 25
                            right: SizeConfigService.blockSizeHorizontal * 5,// old value 25 
                            top: SizeConfigService.blockSizeHorizontal * 1// 
                          ),
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
                            left: SizeConfigService.blockSizeHorizontal * 5, // old value 25
                            right: SizeConfigService.blockSizeHorizontal * 5,// old value 25 
                            top: SizeConfigService.blockSizeHorizontal * 1// 
                          ),
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
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfigService.blockSizeHorizontal * 5, // old value 25
                            right: SizeConfigService.blockSizeHorizontal * 5,// old value 25 
                            top: SizeConfigService.blockSizeHorizontal * 1// 
                          ),
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
      padding: EdgeInsets.only(left: SizeConfigService.blockSizeHorizontal * 5, // old value 25
                              right: SizeConfigService.blockSizeHorizontal * 5,// old value 25 
                              top: SizeConfigService.blockSizeHorizontal * 1// 
                          ),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text(
                  " Save ", 
                  style: TextStyle( 
                    fontSize: 17, 
                    fontWeight: FontWeight.bold
                  )
                ),
                textColor: Colors.white,
                color: Colors.lightGreen[700],
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
                child: new Text(
                  "Cancel", 
                  style: TextStyle( 
                    fontSize: 17, 
                    fontWeight: FontWeight.bold
                    )
                  ),
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
          size: 20.0,
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