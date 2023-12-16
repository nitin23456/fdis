import 'dart:convert';
import 'dart:io';

import 'package:FdisTesting/pages/login_page.dart';
import 'package:FdisTesting/providers/setting_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/LogoutModel.dart';
import '../models/setting_model.dart';
import '../utils/api.dart';
import '../utils/shared_prefs.dart';
import '../widgets/flutter_flow_theme.dart';

//audit model se nahi karna he sea

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

//android studio par openkaro  h o gaya na ab thik? ?
class _SettingPageState extends State<SettingPage> {
  final api = Api();
  File? _image;
  String AuditsEx = "";
  String LastClient = "";
  String LastLocation = "";

  // Function to open the image picker
  Future _getImage() async {
    final image = await ImagePicker().getImage(
        source: ImageSource
            .gallery); // Change to ImageSource.camera to use the camera
    if (image != null) {
      setState(() {
        _image = File(image.path);
        File imageFile = File(image.path);

        _uploadImage(imageFile);
      });
    }
  }

  Future<void> _uploadImage(File image) async {
    // print(image);
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    });

    var dio = Dio();
    var response = await dio.request(
      'http://18.159.111.224:4002/api/v1/dashboard/Image/uplode',
      options: Options(
        method: 'POST',
      ),
      data: formData,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  var _imagedata;
  late String image;
  var imagePicker;
  LogoutModel userProfileModeldata = LogoutModel();
  late Future<List<Rows>> _future;

  var type;
  String mainuserName = "";
  String mainuserImage = "";
  @override
  void initState() {
    getUserName();
    imagePicker = new ImagePicker();
    // Provider.of<SettingProvider>(context, listen: false).fetchSettingData();
    // Provider.of<SettingProvider>(context, listen: false).getLogoutApi();
    _future =
        Provider.of<SettingProvider>(context, listen: false).fetchSettingData();
    /* _futurearea = Provider.of<SettingProvider>(context, listen: false).fetchAreaData();
    _futuredata = Provider.of<SettingProvider>(context, listen: false).fetchData();*/
    super.initState();
  }

  getUserName() async {
    mainuserName = await SharedPrefs.getUserId();
    mainuserImage = await SharedPrefs.getUserImage();
    // print(mainuserName);
    // print("userNameData== ${mainuserImage}");
    // print("userNameData");
  }

  Future<void> _handleRefresh() async {
    try {
      Provider.of<SettingProvider>(context, listen: false).getLogoutApi();
      // animationController.forward(from: 0.0);
      await Provider.of<SettingProvider>(context, listen: false).getLogoutApi();

      /*  Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage()));*/
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, data, child) {
      return Scaffold(
          backgroundColor: const Color(0xFFe2f0fc),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leadingWidth: 150,
            leading: Row(
              mainAxisSize: MainAxisSize.max,
              children: [],
            ),
            title: Text(
              'Settings',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  {
                    // logoutService();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            child: contentBox(context),
                          );
                        });
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SelectionArea(
                        child: InkWell(
                      onTap: () {
                        // logoutService();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                child: contentBox(context),
                              );
                            });
                      },
                      // Sir same issue  a rha ha
                      child: Text(
                        'LOGOUT',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: const Color(0xFF3679C6),
                              fontSize: 16,
                            ),
                      ),
                    )),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.logout,
                      color: Color(0xFFDB3636),
                      size: 30,
                    ),
                  ],
                ),
              )
            ],
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Stack(
                          children: [
                            /*_image == null
                                ? Text('No image selected.')
                                : Image.file(_image!),*/
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: _image == null
                                  ? CircleAvatar(
                                      maxRadius: 50,
                                      backgroundImage: NetworkImage(
                                        mainuserImage ?? "",
                                      ),
                                      //   backgroundColor: Colors.grey, // You can set the background color of the CircleAvatar
                                      /* child: Icon(
                                  Icons.camera_alt,
                                  size: 40,
                                  color: Colors.white,
                                )*/
                                    )
                                  : CircleAvatar(
                                      maxRadius: 50,
                                      backgroundImage: FileImage(
                                          _image!), // Use FileImage to load the image
                                    ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 145,
                              child: GestureDetector(
                                onTap: () async {
                                  _getImage();
                                },
                                child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.white,
                                    child:
                                        Center(child: Icon(Icons.edit_note))),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          data.userProfileModel.data?.first.userName ?? "",
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Poppins',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          // color: Colors.cyan,
                          height: MediaQuery.of(context).size.height * 0.52,
                          width: MediaQuery.of(context).size.width,
                          child: Consumer<SettingProvider>(
                              builder: (context, model, child) {
                            return FutureBuilder<List<Rows>>(
                              future: _future,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  //  widget.clientId
                                  //    "02F6BE53-0F4C-4807-A902-00463BFDE459"==
                                  if (snapshot.data!.isEmpty) {
                                    return const Center(
                                      child: Text("No data found"),
                                    );
                                  }
                                  return ListView.builder(
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, index) {
                                      final row = snapshot.data?[index];
                                      if (row?.userName ==
                                          mainuserName.toString()) {
                                        AuditsEx = row
                                                ?.newPerformerdata![0].phone
                                                .toString() ??
                                            "";
                                        LastClient = row?.newPerformerdata![0]
                                                .companyName
                                                .toString() ??
                                            "";
                                        LastLocation = row
                                                ?.newPerformerdata![0].city
                                                .toString() ??
                                            "";
                                        // print("====${AuditsEx}");
                                        // print("====${LastClient}");
                                        // print("====${LastLocation}");

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            children: [
                                              customContainer(
                                                  key: "AUDITS EXCECUTED",
                                                  value: AuditsEx),
                                              const SizedBox(height: 10),
                                              customContainer(
                                                  key: "LAST CLIENT :",
                                                  value: LastClient),
                                              const SizedBox(height: 10),
                                              customContainer(
                                                key: "LAST LOCATION VISITED",
                                                value: LastLocation,
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return const SizedBox
                                            .shrink(); // Hide other users' data
                                      }
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text("${snapshot.error}"),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ));
    });
  }

  Widget customContainer({required String key, required String value}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                '$key :',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Roboto',
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFB1D3E8),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  value,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.34,
          width: MediaQuery.of(context).size.width,
          //margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Text("ALERT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 3,
              ),
              Divider(
                color: Colors.black,
                thickness: 0.2,
                height: 1.0,
                indent: 50,
                endIndent: 50,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                  "Are You Sure\n"
                  "Do you want to log out?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    // fontFamily: StaticContants.poppinsRegular,
                    fontSize: 15,
                  )),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          getLogoutApidata(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: <Color>[Colors.red, Colors.red])),
                          child: Center(
                            child: Text(
                              "YES",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Poppins",
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
// Spacer(),

                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: <Color>[Colors.red, Colors.red])),
                          child: Center(
                            child: Text(
                              "NO",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Poppins",
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void getLogoutApidata(BuildContext context) async {
    String userId = await SharedPrefs.getUserId();
    String Tokenid = await SharedPrefs.getToken();
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    var headers = {
      "x-access-token": token,
      "Authorization": "Bearer $Tokenid",
    };

    print("client token === $token");
    print("client token === Tokenid $Tokenid");

    try {
      final response = await api.postData(
        endpoint:
            'http://18.159.111.224:4002/api/v1/dashboard/newPerformer/logout',
        // endpoint: 'http://52.29.56.96:4002/api/v1/dashboard/Mob/logout',
        headers: headers, // Set the headers here
        body: {'x-access-token': Tokenid},
      );
      final item = response.data;
      if (response.statusCode == 200) {
        Navigator.pop(context, true);
        userProfileModeldata = LogoutModel.fromJson(item);
        print("Logout successful ${userProfileModeldata.message}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${userProfileModeldata.message}"),
        ));

        await prefs.setString('token', "");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Logout failed"),
        ));

        print("Logout failed");
      }
    } catch (error) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Logout failed"),
      ));
      print("Error during logout: $error");
    }
  }
}
