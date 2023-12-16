import 'package:FdisTesting/models/element_by_id_model.dart';
import 'package:FdisTesting/models/error_type_model.dart';
import 'package:FdisTesting/models/store_data_model.dart';
import 'package:FdisTesting/providers/create_error_provider.dart';
import 'package:FdisTesting/providers/erro_page_Provider.dart';
import 'package:FdisTesting/widgets/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../utils/shared_prefs.dart';

class CreateErrorPage extends StatefulWidget {
  final String categoryId;
  final String floorValueId;
  final String floorName;
  final String areaId;
  final String areaName;
  final String categoryName;
  final String areaNumber;
  final String telElement;
  final String auditId;
  final bool? isForUpdate;
  const CreateErrorPage(
      {Key? key,
      required this.categoryId,
      required this.floorValueId,
      required this.floorName,
      required this.areaId,
      required this.areaName,
      required this.categoryName,
      required this.areaNumber,
      required this.telElement,
      required this.auditId,
      this.isForUpdate})
      : super(key: key);

  @override
  State<CreateErrorPage> createState() => _CreateErrorPageState();
}

class _CreateErrorPageState extends State<CreateErrorPage> {
  late CreateErrorProvider createErrorProvider;
  late Future<List<Rows>> _future;
  late Future<List<ErrorData>> _errorFuture;
  final TextEditingController logboekController = TextEditingController();
  final TextEditingController technischeController = TextEditingController();
  String mainuserName = "";
  String userId = "";
  // String AreaId="";
  getUserName() async {
    mainuserName = await SharedPrefs.getUserName();
    userId = await SharedPrefs.getUserId();
    // AreaId=await SharedPrefs.get

    print("UserName =====================${mainuserName}");
    print("UserName =====================${userId}");
  }

  String mGetElement = "";
  var mGetListShootdata;

  var mGetisAnntal;
  var mGetIsLogBoek;
  var mGetSaveIsTechnische;
  List<EntryData> data = [];
  String _dropDownValue = 'Family History/Information Discovery';

  @override
  void initState() {
    getStringValuesSF();
    createErrorProvider = CreateErrorProvider();
    print("object====${createErrorProvider}");
    callAPI();
    super.initState();
  }

  Future<void> callAPI() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _future = createErrorProvider.getElementById(widget.areaId);
      _errorFuture = createErrorProvider.getErrorsList();
      createErrorProvider.cameraPermission();
      print("object===_future=${_future}");
      print("object==_errorFuture==${_errorFuture}");
      print("object=createErrorProvider===${createErrorProvider}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final errorPageProvider = Provider.of<ErrorPageProvider>(context);

    return ChangeNotifierProvider<CreateErrorProvider>(
      create: (context) => createErrorProvider,
      child: Consumer2<CreateErrorProvider, ErrorPageProvider>(
          builder: (BuildContext context, model, errorPageProvider,
                  Widget? child) =>
              Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                    centerTitle: true,
                    actions: [
                      InkWell(
                        onTap: () {
                          if (model.selectedElementValue == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select element'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else if (model.selectedErrorValue ==
                              null /*mGetListShootdata =="Select a floor"*/) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select foutsoort'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else if (model.count <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please give aantal fout'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            print(
                                "sgggg ${model.selectedErrorValue!.errorTypeValue.toString()}");
                            print(
                                "sgggg ggg ==${model.selectedElementValue!.elementTypeValue}");

                            data.add(EntryData(
                              categoryId: widget.categoryId,
                              category: widget.categoryName,
                              floor: widget.floorName,
                              floorId: widget.floorValueId,
                              area: widget.areaName,
                              areaId: widget.areaId,
                              areaNumber: widget.areaNumber,
                              telElement: widget.telElement,
                              elementId: model
                                  .selectedElementValue!.elementTypeId
                                  .toString(),
                              element: model
                                  .selectedElementValue!.elementTypeValue
                                  .toString(),
                              foutSoort:
                                  model.selectedErrorValue!.errorTypeValue ??
                                      "",
                              foutSoortId:
                                  model.selectedErrorValue!.errorTypeId ?? "",
                              aantal: model.count.toString(),
                              logboekText: logboekController.text,
                              technischeText: technischeController.text,
                              logboekImage: model.logBoekImage != null
                                  ? model.logBoekImage!.path
                                  : "",
                              technischeImage: model.technischeImage != null
                                  ? model.technischeImage!.path
                                  : "",
                              auditId: widget.auditId,
                              id: 1,
                              errorCount: model.count.toString(),
                            ));
                            if (widget.isForUpdate == true) {
                              Provider.of<ErrorPageProvider>(context,
                                      listen: false)
                                  .updateRecodeApi(
                                formId: '',
                                errorTypeId:
                                    model.selectedErrorValue!.errorTypeId ?? "",
                                performerId: 'performerId',
                                elementId: model
                                    .selectedElementValue!.elementTypeId
                                    .toString(),
                                logbook: logboekController.text,
                                technicalAspects: technischeController.text,
                                logbookImage: model.logBoekImage != null
                                    ? model.logBoekImage!.path
                                    : "",
                                technicalAspectsImage:
                                    model.technischeImage != null
                                        ? model.technischeImage!.path
                                        : "",
                                Count: model.count.toString(),
                              )
                                  .then((value) {
                                if (value == true) {
                                  Navigator.pop(context, data);
                                }
                              });

                              /////updateRecorde
                            } else {
                              Provider.of<ErrorPageProvider>(context,
                                      listen: false)
                                  .pagelastapiProvider(
                                formId: "",
                                errorTypeId:
                                    model.selectedErrorValue!.errorTypeId ?? "",
                                performerId: '',
                                elementId: model
                                    .selectedElementValue!.elementTypeId
                                    .toString(),
                                logbook: logboekController.text,
                                technicalAspects: technischeController.text,
                                logbookImage: model.logBoekImage != null
                                    ? model.logBoekImage!.path
                                    : "",
                                technicalAspectsImage:
                                    model.technischeImage != null
                                        ? model.technischeImage!.path
                                        : "",
                                Count: model.count.toString(),
                                // date: '',
                                onLoginStateChanged: (LoginState state) {
                                  if (state == LoginState.error) {
                                    showTopSnackBar(
                                      Overlay.of(context)!,
                                      CustomSnackBar.error(
                                        message: errorPageProvider.errorMessage,
                                      ),
                                    );
                                  }
                                },
                              )
                                  .then((value) {
                                if (value == true) {
                                  Navigator.pop(context, data);
                                }
                              });
                            }
                          }
                        },
                        child: const Icon(
                          Icons.save,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                    title: Text(
                      'Opmerking',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Nunito',
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    leadingWidth: 150,
                    leading: InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            Icons.keyboard_arrow_left,
                            color: Color(0xFF162A7B),
                            size: 30,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Back',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
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
                  body: errorPageProvider.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: const Color(0x33000000),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  FutureBuilder<List<Rows>>(
                                    future: _future,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        for (int i = 0;
                                            i < snapshot.data!.length;
                                            i++) {
                                          if (snapshot.data!
                                                  .elementAt(i)
                                                  .elementTypeValue ==
                                              mGetElement) {
                                            print(
                                                "mKeywordsID==get.${snapshot.data!.elementAt(i).elementTypeValue}");
                                            print(
                                                "mKeywordsID==get =set=== ${model.selectedElementValue}");
                                            break;
                                          }
                                        }

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Element',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBtnText,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0, 2),
                                                  )
                                                ],
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                                  child: DropdownButton<Rows>(
                                                    value: model
                                                        .selectedElementValue,
                                                    //value: mGetElement.toString(),
                                                    hint: Text(
                                                        "Select a element"), //${mGetElement}
                                                    items: snapshot.data?.map<
                                                            DropdownMenuItem<
                                                                Rows>>(
                                                        (Rows value) {
                                                      return DropdownMenuItem<
                                                          Rows>(
                                                        value: value,
                                                        child: Text(value
                                                                .elementTypeValue ??
                                                            ""),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (Rows? newValue) {
                                                      setState(() {
                                                        print(
                                                            "======Model===== ${model.selectedElementValue}");
                                                        //mGetElement = newValue;
                                                        model.selectedElementValue =
                                                            newValue!;
                                                        print(
                                                            "======Model22===== ${model.selectedElementValue}");
                                                        print(
                                                            "======Model22=newValue==== ${newValue}");
                                                      });
                                                    },
                                                    isDense: true,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else if (snapshot.hasError) {
                                        return const SizedBox.shrink();
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  FutureBuilder<List<ErrorData>>(
                                    future: _errorFuture,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        for (int i = 0;
                                            i < snapshot.data!.length;
                                            i++) {
                                          if (snapshot.data!
                                                  .elementAt(i)
                                                  .errorTypeValue ==
                                              mGetListShootdata) {
                                            break;
                                          }
                                        }
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'FOUTSOORT',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                            ),
                                            const SizedBox(height: 5),
                                            Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBtnText,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 4,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0, 2),
                                                  )
                                                ],
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child:
                                                      DropdownButton<ErrorData>(
                                                    value: model
                                                        .selectedErrorValue,
                                                    hint: Text(
                                                        "select a foutsoort"), //${mGetListShootdata}
                                                    items: snapshot.data?.map<
                                                            DropdownMenuItem<
                                                                ErrorData>>(
                                                        (ErrorData value) {
                                                      return DropdownMenuItem<
                                                          ErrorData>(
                                                        value: value,
                                                        child: Text(value
                                                                .errorTypeValue ??
                                                            ""),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (ErrorData? newValue) {
                                                      setState(() {
                                                        model.selectedErrorValue =
                                                            newValue!;
                                                      });
                                                    },
                                                    isDense: true,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else if (snapshot.hasError) {
                                        return const SizedBox.shrink();
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'AANTAL FOUT(EN)',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Roboto',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    height: 45,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            model.decrement();
                                          },
                                        ),
                                        //  model.count = mGetisAnntal;
                                        Text(model.count.toString()),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            model.increment();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'LOGBOEK',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                            ),
                                            IconButton(
                                              icon:
                                                  const Icon(Icons.camera_alt),
                                              onPressed: () {
                                                model.logBoekCaptureImage(
                                                    context);
                                              },
                                            ),
                                          ],
                                        ),
                                        model.logBoekImage == null
                                            ? const SizedBox.shrink()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Stack(children: [
                                                  AspectRatio(
                                                      aspectRatio: 16 / 9,
                                                      child: LayoutBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              BoxConstraints
                                                                  constraints) {
                                                        final width =
                                                            constraints
                                                                .maxWidth;
                                                        final height =
                                                            width * 9 / 16;
                                                        return Image.file(
                                                          model.logBoekImage!,
                                                          width: width,
                                                          height: height,
                                                          fit: BoxFit.cover,
                                                        );
                                                      })),
                                                  Positioned(
                                                    right: 10,
                                                    top: 10,
                                                    child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.blue,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            model
                                                                .clearLogBoekImage();
                                                          },
                                                          icon: const Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  )
                                                ]),
                                              ),
                                        TextFormField(
                                          controller: logboekController,
                                          maxLines: 4,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBtnText,
                                            filled: true,
                                            hintText: 'Enter telelementen',
                                            hintStyle:
                                                const TextStyle(fontSize: 12),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            errorBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4F5254),
                                              ),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'TECHNISCHE ASPECTEN',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                            ),
                                            IconButton(
                                              icon:
                                                  const Icon(Icons.camera_alt),
                                              onPressed: () async {
                                                try {
                                                  await model
                                                      .technischeCaptureImage(
                                                          context);
                                                } catch (e) {
                                                  debugPrint(
                                                      'Error occurred while capturing image: $e');
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        model.technischeImage == null
                                            ? const SizedBox.shrink()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Stack(
                                                  children: [
                                                    AspectRatio(
                                                        aspectRatio: 16 / 9,
                                                        child: LayoutBuilder(
                                                            builder: (BuildContext
                                                                    context,
                                                                BoxConstraints
                                                                    constraints) {
                                                          final width =
                                                              constraints
                                                                  .maxWidth;
                                                          final height =
                                                              width * 9 / 16;
                                                          return Image.file(
                                                            model
                                                                .technischeImage!,
                                                            width: width,
                                                            height: height,
                                                            fit: BoxFit.cover,
                                                          );
                                                        })),
                                                    Positioned(
                                                      right: 10,
                                                      top: 10,
                                                      child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.blue,
                                                          child: IconButton(
                                                            onPressed: () {
                                                              model
                                                                  .clearTechnischeImage();
                                                            },
                                                            icon: const Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                        TextFormField(
                                          controller: technischeController,
                                          maxLines: 4,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBtnText,
                                            filled: true,
                                            hintText: 'Enter logboek',
                                            hintStyle:
                                                const TextStyle(fontSize: 12),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            errorBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4F5254),
                                              ),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))),
    );
  }

  getStringValuesSF() async {
    String getElement = await SharedPrefs.getElement();
    String getListShootdata = await SharedPrefs.getListShoort();

    String getisAnntal = await SharedPrefs.getIsAnntal();
    String getIsLogBoek = await SharedPrefs.getIsLogBoek();
    String getSaveIsTechnische = await SharedPrefs.getIsTechnische();

    mGetElement = getElement.toString();
    mGetListShootdata = getListShootdata.toString();
    mGetisAnntal = getisAnntal.toString();

    mGetIsLogBoek = getIsLogBoek.toString();
    mGetSaveIsTechnische = getSaveIsTechnische.toString();

    setState(() {
      mGetElement;
      mGetListShootdata;

      mGetisAnntal;
      mGetIsLogBoek;
      mGetSaveIsTechnische;

      if (mGetElement == "" || mGetElement == null) {
        mGetElement = "Select a element";
      } else {
        mGetElement;
      }

      if (mGetListShootdata == "" || mGetListShootdata == null) {
        mGetListShootdata = "Select a floor";
      } else {
        mGetListShootdata;
      }

      if (mGetisAnntal == "" || mGetisAnntal == null) {
        mGetisAnntal = "0";
      } else {
        mGetisAnntal;
      }

      if (mGetIsLogBoek == "" || mGetIsLogBoek == null) {
        logboekController.text;
      } else {
        logboekController.text = mGetIsLogBoek;
      }

      if (mGetSaveIsTechnische == "" || mGetSaveIsTechnische == null) {
        technischeController.text;
      } else {
        technischeController.text = mGetSaveIsTechnische;
      }
    });
  }
}
