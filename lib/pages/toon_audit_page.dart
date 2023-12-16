import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:FdisTesting/models/toon_audit_model.dart';
import 'package:FdisTesting/pages/category_floor_page.dart';
import 'package:FdisTesting/widgets/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as imageCompresser;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../models/GetFeedbackModel.dart';
import '../providers/toon_audit_provider.dart';
import '../utils/api.dart';

class ToonAuditPage extends StatefulWidget {
  final String companyName;
  final String clientId;
  final String auditId;
  final String autidcode;

  const ToonAuditPage(
      {Key? key,
      required this.companyName,
      required this.clientId,
      required this.auditId,
      required this.autidcode,
      required String auditCode})
      : super(key: key);

  @override
  State<ToonAuditPage> createState() => _ToonAuditPageState();
}

class _ToonAuditPageState extends State<ToonAuditPage> {
  late Future<List<CategoryList>> _future;
  late Future<List<GetFeed>> _futurefeedback;
  SignatureController? controller;
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  Uint8List? signature;
  final api = Api();
  final Color background = Colors.grey;
  final Color fill = Colors.redAccent;
  final List<Color> gradient = [];

  final double fillPercent = 56.23; // fills 56.23% for container from bottom

  @override
  void initState() {
    // print("Audit Id ====${widget.auditId}");
    // print("clientId Id ====${widget.clientId}");
    _future = Provider.of<ToonAuditProvider>(context, listen: false)
        .fetchToonAuditList(widget.auditId, widget.clientId);
    _requestPermission();
    super.initState();
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    final info = statuses[Permission.storage].toString();
    //  print(info);
    _toastInfo(info);
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState?.clear();
  }

//  image with signature in the pad and submit function
  String auditId = "";
  Future<String?> createFileFromUint8List(Uint8List uint8List) async {
    try {
      // Get the local application directory
      Directory appDocDir = await getApplicationDocumentsDirectory();

      // Specify the file path where you want to create the file
      var fileName = "signature_$auditId${DateTime.now().microsecond}";
      String filePath = '${appDocDir.path}/$fileName.png';

      // Create a File instance
      File file = File(filePath);

      // Open the file in write mode and write the Uint8List to the file
      await file.writeAsBytes(uint8List);

      print('File created successfully at $filePath');
      print('file size ${await file.length()}');
      var compresPath = "${appDocDir.path}/${fileName}_compressed.jpg";
      await compressImage(file.path, compresPath);

      return compresPath;
    } catch (e) {
      print('Error creating file: $e');
    }
  }

  Future<void> compressImage(String inputPath, String outputPath) async {
    try {
      // Read the image from file
      File inputFile = File(inputPath);
      var inputBytes = inputFile.readAsBytesSync();
      var image = imageCompresser.decodeImage(inputBytes);

      // Set the compression level (0 to 100, 100 being the best quality)
      int compressionLevel = 80;

      // Compress the image
      List<int> compressedBytes =
          imageCompresser.encodeJpg(image!, quality: 50);

      // Write the compressed image to a new file
      var file = File(outputPath);
      file.writeAsBytesSync(compressedBytes);
      print('Compressed file size ${await file.length()}');
      return print('Image compressed successfully. Output path: $outputPath');
    } catch (e) {
      print('Error compressing image: $e');
    }
  }

  Future<void> uploadImage(String localFilePath, String auditId) async {
    var headersList = {
      'Content-Type': 'multipart/form-data',
      //   'Content-Type': 'application/octet-stream',
    };
    var url = Uri.parse(
        'http://18.159.111.224:4002/api/v1/dashboard/Image/SignatureUpload');

    var body = {'AuditId': auditId};

    print("========================HTTP REQUEST++++++++++++++++++");
    print(url);
    print(body);
    print(localFilePath);

    var req = http.MultipartRequest('POST', url);
    req.headers.addAll(headersList);
    print(req.headers);
    req.files.add(await http.MultipartFile.fromPath('image', localFilePath,
        contentType: MediaType('image', 'jpg')));
    req.fields.addAll(body);
    print(req.files.first.field);
    print(req.files.first.contentType);
    print(req.files.first.filename);
    print(req.files.first.length.toString() + "Kb");
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    print(res);

    print(res.request);
    print(res.stream);
    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }
//////////////////////////////

  void _handleSaveButtonPressedData() async {
    RenderSignaturePad boundary = signatureGlobalKey.currentContext
        ?.findRenderObject() as RenderSignaturePad;

    ui.Image image = await boundary.toImage();

    print("Rahulrajimage" + image.toString());
    ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png)
        as FutureOr<ByteData?>);
    print(boundary);
    print(byteData);
    print(byteData.toString());
    print("Rahulraj");
    //uploadImage(image as Uint8List);
    if (byteData != null) {
      var filePath =
          await createFileFromUint8List(byteData.buffer.asUint8List());
      if (filePath != null) {
        await uploadImage(filePath, widget.auditId);
        // print("Signature ");
      } else {
        print("error file not created");
      }
    }
  }
//////////////////////////////////////////

  Future storeSignature(BuildContext context) async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final time = DateTime.now().toIso8601String().replaceAll('.', ':');
    final name = 'signature_$time.png';

    final result = await ImageGallerySaver.saveImage(signature!, name: name);
    final isSuccess = result['isSuccess'];
    print(result);

    if (isSuccess) {
      Navigator.pop(context);
      print("Save");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Saved to signature folder!"),
      ));
    } else {
      print("Fail");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to to save!!"),
      ));
    }
  }

  _toastInfo(String info) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(info),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        centerTitle: true,
        actions: const [
          Center(
            child: Icon(Icons.upload),
          ),
          SizedBox(width: 10)
        ],
        title: Text(
          widget.companyName,
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Nunito',
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
        ),
        leadingWidth: 150,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              const Icon(
                Icons.keyboard_arrow_left,
                color: Color(0xFF162A7B),
                size: 30,
              ),
              const SizedBox(width: 5),
              Text(
                'Audits',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      color: const Color(0xFF162A7B),
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ],
          ),
        ),
      ),
      body: Consumer<ToonAuditProvider>(builder: (context, model, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFBCC5E6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                      child: Text(
                        'KLANT',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                            ),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                      size: 24,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                  child: Text(
                    widget.companyName,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Nunito',
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFFE9EFF6),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Align(
                  alignment: const AlignmentDirectional(-0.05, 0),
                  child: SelectionArea(
                      child: Text(
                    'INFORMATIE',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Roboto',
                          color: const Color(0xFF222628),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  )),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 65,
                decoration: const BoxDecoration(
                  color: Color(0xFFC6CADB),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Code ',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Nunito',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          Text(
                            'Audit Soort',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Nunito',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          Text(
                            'Locatie',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Nunito',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.toonAuditModel.data?.first.auditCode ?? "",
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: const Color(0xFF22492F),
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                          Text(
                            model.toonAuditModel.data?.first.type ?? "",
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: const Color(0xFF22492F),
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                          Text(
                            model.toonAuditModel.data?.first.locationName ?? "",
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: const Color(0xFF22492F),
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBtnText,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "CATEGORIEEN",
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                    const SizedBox(height: 15),
                    FutureBuilder<List<CategoryList>>(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text("No data found"),
                            );
                          }
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length - 1,
                              itemBuilder: (context, index) {
                                final categoryData = snapshot.data![index + 1];

                                print(
                                    "0/${categoryData.maximunSizeRange ?? 0}");
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: ListTile(
                                      trailing: Text(
                                        "${categoryData.minimunSizeRange ?? 0}/${categoryData.maximunSizeRange ?? 0}",
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                      ),
                                      minLeadingWidth:
                                          MediaQuery.of(context).size.width *
                                              0.43,
                                      leading: Container(
                                        height: 45,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        padding: EdgeInsets.only(left: 5),
                                        margin: EdgeInsets.only(top: 5),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x33000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            stops: [
                                              (categoryData.maximunSizeRange ??
                                                      0) /
                                                  (categoryData
                                                          .maximunSizeRange ??
                                                      1),
                                              (categoryData.minimunSizeRange ??
                                                      0) /
                                                  (categoryData
                                                          .maximunSizeRange ??
                                                      1),
                                              // (100 - categoryData.minimunSizeRange! ?? 0) / 100,
                                              // (100 - categoryData.minimunSizeRange! ?? 0) / 100,
                                            ],
                                            colors: [
                                              Colors.green,
                                              Color(0xffdb3636),
                                            ],
                                          ),
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            snapshot.data?[index + 1]
                                                    .categoryName ??
                                                "",
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
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
                    )
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: FlutterFlowTheme.of(context).primaryBtnText,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment
                                  .centerLeft, // Move left by 20 pixels
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<CustomDropdown>(
                                  items: model.dropdown
                                      .map((CustomDropdown person) {
                                    return DropdownMenuItem<CustomDropdown>(
                                      value: person,
                                      child: Text(person.name),
                                    );
                                  }).toList(),
                                  onChanged: (CustomDropdown? value) {
                                    setState(() {
                                      model.selectedDropdownValue = value!;
                                    });
                                    if (value?.name == "O") {
                                      final TextEditingController
                                          feedbackController =
                                          TextEditingController();
                                      final _formKey = GlobalKey<FormState>();
                                      String _text;
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Feedback'),
                                            content: Form(
                                              key: _formKey,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBtnText,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 4,
                                                      color: Color(0x33000000),
                                                      offset: Offset(0, 2),
                                                    )
                                                  ],
                                                ),
                                                child: TextFormField(
                                                  controller:
                                                      feedbackController,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder
                                                        .none, // add this line
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    _text = value!;
                                                  },
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              model.isLoading
                                                  ? const CircularProgressIndicator()
                                                  : TextButton(
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          _formKey.currentState!
                                                              .save();
                                                          model
                                                              .feedbackAPI(
                                                                  feedback:
                                                                      feedbackController
                                                                          .text,
                                                                  auditId: widget
                                                                      .auditId)
                                                              .then((value) {
                                                            if (value
                                                                    .serverCode ==
                                                                200) {
                                                              showTopSnackBar(
                                                                Overlay.of(
                                                                    context)!,
                                                                const CustomSnackBar
                                                                    .success(
                                                                  message:
                                                                      'Feedback sent',
                                                                ),
                                                              );
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          });
                                                        }
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  value: model.selectedDropdownValue,
                                  hint: const Text(
                                      'KPI Element you can choose the value'),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _futurefeedback = Provider.of<ToonAuditProvider>(
                                context,
                                listen: false)
                            .getFeebackModel();
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            ///////////////////
                            return AlertDialog(
                              title: Text('Comments'),
                              content: Container(
                                height: 300,
                                width: 300,
                                child: FutureBuilder<List<GetFeed>>(
                                  future: _futurefeedback,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text("Error: ${snapshot.error}"),
                                      );
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return Center(
                                        child: Text("No data found"),
                                      );
                                    } else {
                                      final lastItem = snapshot.data!.last;
                                      return Text(
                                        lastItem.elementAuditComment ??
                                            'No comment',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                      );
                                    }
                                  },
                                ),
                              ),
                            );

                            //////
                          },
                        );
                      },
                      icon: Icon(Icons.comment), // You can use any other icon
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryFloorPage(
                                  auditId: widget.auditId,
                                  companyName: widget.companyName,
                                  clientId: widget.clientId,
                                  autidcode: widget.autidcode,
                                )));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xFF936CC8),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "START/RESUME",
                        style: FlutterFlowTheme.of(context).subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                              child: SfSignaturePad(
                                  key: signatureGlobalKey,
                                  backgroundColor: Colors.white,
                                  strokeColor: Colors.black,
                                  minimumStrokeWidth: 3.0,
                                  maximumStrokeWidth: 6.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)))),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0, right: 8),
                        child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: IconButton(
                              onPressed: _handleClearButtonPressed,
                              icon: const Icon(Icons.cleaning_services_rounded),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  color: Colors.green,
                  onPressed: () async {
                    _handleSaveButtonPressedData();
                    // _handleClearButtonPressed();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Signature Successfully Uploaded"),
                      ),
                    );
                    // getAuditId();
                  },
                  child: Text('UPLOADEN'.toUpperCase(),
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
