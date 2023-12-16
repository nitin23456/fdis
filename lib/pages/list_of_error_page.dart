import 'dart:convert';

import 'package:FdisTesting/models/get_error.dart';
import 'package:FdisTesting/models/list_of_error_provider.dart';
import 'package:FdisTesting/models/store_data_model.dart';
import 'package:FdisTesting/pages/create_error_page.dart';
import 'package:FdisTesting/widgets/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_prefs.dart';

class ListOfErrorPage extends StatefulWidget {
  final String categoryId;
  final String floorValueId;
  final String floorName;
  final String areaId;
  final String areaName;
  final String categoryName;
  final String areaNumber;
  final String telElement;
  final String auditId;
  final List<EntryData> dataList;

  const ListOfErrorPage(
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
      required this.dataList})
      : super(key: key);

  @override
  State<ListOfErrorPage> createState() => _ListOfErrorPageState();
}

class _ListOfErrorPageState extends State<ListOfErrorPage> {
  late ListOfErrorProvider listOfErrorProvider;
  List<Rows> errorElementsList = List<Rows>.empty(growable: true);
  @override
  void initState() {
    super.initState();
    listOfErrorProvider = ListOfErrorProvider();
    listOfErrorProvider.list = widget.dataList;
    setState(() {});
  }

  //////////////////////////delete//////////////////////
  Future<void> deleteRecord(String recordId) async {
    final String apiUrl =
        'http://18.159.111.224:4002/api/v1/dashboard/Mob/delete/$recordId';

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        print('Record deleted successfully');
      } else {
        print('Failed to delete record. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error during DELETE request: $e');
    }
  }

  Future<void> getRecord() async {
    final String apiUrl =
        'http://18.159.111.224:4002/api/v1/dashboard/Mob/getdata';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        print('Record get successfully');
        var data = GetErrorModel.fromJson(jsonDecode(response.body));
        if (data.success == true) {
          errorElementsList = data.data?.rows ?? [];
          setState(() {});
        }
      } else {
        print('Failed to get record. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error during get request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListOfErrorProvider>(
      create: (context) => listOfErrorProvider,
      child: Consumer<ListOfErrorProvider>(builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            centerTitle: true,
            actions: [
              InkWell(
                onTap: () {
                  SharedPrefs.saveElement("" ?? "");
                  SharedPrefs.saveListShoort("" "");
                  SharedPrefs.saveIsAnntal("" ?? "");
                  SharedPrefs.saveIsLogBoek("" ?? "");
                  SharedPrefs.saveIsTechnische("" ?? "");
                  debugPrint("check category id ----- ${widget.categoryId}");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateErrorPage(
                                auditId: widget.auditId,
                                categoryId: widget.categoryId,
                                areaId: widget.areaId,
                                floorValueId: widget.floorValueId,
                                floorName: widget.floorName,
                                areaName: widget.areaName,
                                categoryName: widget.categoryName,
                                areaNumber: widget.areaNumber,
                                telElement: widget.telElement,
                                isForUpdate: false,
                              ))).then((value)async {
                    if (value != null) {
                     await getRecord();

                      ///get list app data
                      // model.addData(value);

                      // for (EntryData entryData in value) {
                      //   print("id: ${entryData.id}");
                      //   print("auditId: ${entryData.auditId}");
                      //   print("categoryId: ${entryData.categoryId}");
                      //   print("category: ${entryData.category}");
                      //   print("floor: ${entryData.floor}");
                      //   print("floorId: ${entryData.floorId}");
                      //   print("area: ${entryData.area}");
                      //   print("areaId: ${entryData.areaId}");
                      //   print("areaNumber: ${entryData.areaNumber}");
                      //   print("telElement: ${entryData.telElement}");
                      //   print("element: ${entryData.element}");
                      //   print("elementId: ${entryData.elementId}");
                      //   print("foutSoort: ${entryData.foutSoort}");
                      //   print("foutSoortId: ${entryData.foutSoortId}");
                      //   print("aantal: ${entryData.aantal}");
                      //   print("logboekImage: ${entryData.logboekImage}");
                      //   print("logboekText: ${entryData.logboekText}");
                      //   print("technischeImage: ${entryData.technischeImage}");
                      //   print("technischeText: ${entryData.technischeText}");
                      //   print("errorCount: ${entryData.errorCount}");
                      // }
                    }
                  });
                },
                child: const Icon(
                  Icons.add_box_outlined,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 10),
            ],
            title: Text(
              'Lijst fout',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Nunito',
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            leadingWidth: 150,
            leading: InkWell(
              onTap: () async {
                if (model.list.isNotEmpty) {
                  Navigator.pop(context, model.list);
                } else {
                  Navigator.pop(context);
                }
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  child: model.list.isEmpty
                      ? Center(child: Text("No data found"))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount:errorElementsList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                print("======================${errorElementsList[index].errorElementId}");
                             
                                SharedPrefs.saveElement(
                                    model.list[index].element ?? "");
                                SharedPrefs.saveListShoort(
                                    model.list[index].foutSoort ?? "");
                                SharedPrefs.saveIsAnntal(
                                    model.list[index].aantal ?? "");
                                SharedPrefs.saveIsLogBoek(
                                    model.list[index].logboekText ?? "");
                                SharedPrefs.saveIsTechnische(
                                    model.list[index].technischeText ?? "");

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateErrorPage(
                                              auditId: widget.auditId,
                                              categoryId: widget.categoryId,
                                              areaId: widget.areaId,
                                              floorValueId: widget.floorValueId,
                                              floorName: widget.floorName,
                                              areaName: widget.areaName,
                                              categoryName: widget.categoryName,
                                              areaNumber: widget.areaNumber,
                                              telElement: widget.telElement,
                                              isForUpdate: true,
                                            ))).then((value) {
                                  if (value != null) {
                                    model.addData(value);
                                  }
                                });
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffddedfc)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(errorElementsList[index].element.toString()),
                                            // Text(model.list[index].element ??
                                            //     ""),
                                            SizedBox(height: 10),
                                            Text(model.list[index].foutSoort ??
                                                ""),
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                //  SharedPrefs.saveElement(model.list[index].element ?? "");
                                                // SharedPrefs.saveListShoort(model.list[index].foutSoort ?? "");
                                                deleteRecord(model
                                                    .list[index].id as String);
                                                model.removeItem(index);
                                                // deleteRecord();
                                              },
                                              child: CircleAvatar(
                                                  radius: 13,
                                                  child: Icon(Icons.close)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
