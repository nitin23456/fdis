import 'package:FdisTesting/models/audit_model.dart';
import 'package:FdisTesting/pages/toon_audit_page.dart';
import 'package:FdisTesting/providers/audit_provider.dart';
import 'package:FdisTesting/widgets/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuditListPage extends StatefulWidget {
  final String companyName;
  final String clientId;

  const AuditListPage(
      {Key? key, required this.companyName, required this.clientId})
      : super(key: key);

  @override
  State<AuditListPage> createState() => _AuditListPageState();
}

class _AuditListPageState extends State<AuditListPage> {
  late Future<List<Rows>> _future;
  String getId = "";
  bool isMatching = false;
  @override
  void initState() {
    super.initState();
    getId = widget.clientId;
    // print("Gid========${getId}");
    _future = Provider.of<AuditProvider>(context, listen: false)
        .fetchAuditList(widget.clientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leadingWidth: 150,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Color(0xFF3679C6),
                    size: 24,
                  ),
                  Text(
                    'Back',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: const Color(0xFF3679C6),
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            title: const Text(
              'Audit',
              style: TextStyle(
                color: Colors.black,
              ),
            )),
        body: Consumer<AuditProvider>(builder: (context, model, child) {
          return FutureBuilder<List<Rows>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data!);

                print("Radhe");

                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No data found"),
                  );
                }

                return Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          print("object $index");

                          final row = snapshot.data?[index];
                          isMatching = false;

                          if (row?.usersClient?.id == getId) {
                            isMatching =
                                true; // Set the flag to true if a matching item is found
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ToonAuditPage(
                                      auditId:
                                          snapshot.data?[index].id.toString() ??
                                              "",
                                      companyName: widget.companyName,
                                      clientId: widget.clientId,
                                      autidcode:
                                          snapshot.data?[index].auditCode ?? "",
                                      auditCode: '',
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffe6e8f6),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      row?.auditCode ?? "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        snapshot.data?[index].location?.name ??
                                            ""),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Color(0xff444546),
                                      size: 18,
                                    ),
                                    leading: row?.isActive == true
                                        ? Icon(
                                            Icons
                                                .star, // Use the star icon or any other icon you prefer
                                            color: Colors
                                                .yellow, // Set the color of the star icon
                                          )
                                        : null, // If not active, set leading to null to not display any icon
                                  ),
                                ),
                              ),
                            );
                          } // Add the following code after the loop

                          // If the client ID doesn't match, return an empty container
                          return Container();
                        }));

                // Display "No data found" if there are no matching items
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
        }));
  }
}
