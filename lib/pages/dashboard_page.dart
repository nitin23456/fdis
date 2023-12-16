import 'package:FdisTesting/pages/audit_list_page.dart';
import 'package:FdisTesting/providers/client_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/client_model.dart';
import '../utils/shared_prefs.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotationAnimation;
  String mainuserName = "";
  String mainuserImage = "";
  getUserName() async {
    mainuserName = await SharedPrefs.getUserId();
    mainuserImage = await SharedPrefs.getUserImage();
    // print(mainuserName);
    // print("userNameData== ${mainuserImage}");
    // print("userNameData");
    setState(() {
      mainuserImage;
    });
  }

  @override
  void initState() {
    Provider.of<ClientProvider>(context, listen: false).fetchClientList();
    super.initState();
    getUserName();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);
  }
  //late Future<NewListModel?> mainlist;

  List<String> filterUniqueCompanyNames(List<Data>? dataList) {
    final uniqueCompanyNames = <String>{};

    for (final data in dataList ?? []) {
      uniqueCompanyNames.add(data.companyName ?? '');
      //   uniqueCompanyNames.add(data.clieniid ?? '');
    }

    return uniqueCompanyNames.toList();
  }

  List<String> filterUniqueClientid(List<Data>? dataList) {
    final uniqueclientid = <String>{};

    for (final data in dataList ?? []) {
      // uniqueCompanyNames.add(data.companyName ?? '');
      uniqueclientid.add(data.clientId ?? '');
    }

    return uniqueclientid.toList();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    try {
      Provider.of<ClientProvider>(context, listen: false).changeState();
      animationController.forward(from: 0.0);
      await Provider.of<ClientProvider>(context, listen: false)
          .fetchClientList();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey,
            leading: Padding(
              padding: EdgeInsets.only(left: 10),
              child: CircleAvatar(
                backgroundColor: Colors.white70,
                backgroundImage: NetworkImage(mainuserImage),
              ),
            ),
            actions: [
              IconButton(
                onPressed: _handleRefresh,
                icon: RotationTransition(
                  turns: rotationAnimation,
                  child: const Icon(Icons.refresh),
                ),
              ),
              const SizedBox(width: 8)
            ],
            leadingWidth: 55,
            centerTitle: true,
            title: const Text(
              'Opdrachtgever',
              style: TextStyle(
                color: Colors.black,
              ),
            )),
        body: FutureBuilder(
          future: Future.value(true),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Consumer<ClientProvider>(
                builder: (context, data, child) {
                  final dataList = data.clientModel?.data;

                  // final dataList = data.clientModel!.data!;
                  final uniqueCompanyNames = filterUniqueCompanyNames(dataList);
                  final uniqueCompanyid = filterUniqueClientid(dataList);

                  return uniqueCompanyNames.isEmpty || data.clientModel == null
                      ? const Center(child: CircularProgressIndicator())
                      : data.clientModel!.data!.isEmpty
                          ? const Center(
                              child: Text("No data found"),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              // itemCount: data.clientModel?.data?.length,
                              itemCount: uniqueCompanyNames.length,
                              // itemCountname: uniqueCompanyid.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    // print(
                                    //     "client id bana ===${uniqueCompanyNames[index]}");
                                    // print(
                                    //     "client id bana =tt==${uniqueCompanyid[index]}");

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AuditListPage(
                                                companyName:
                                                    uniqueCompanyNames[index],
                                                clientId:
                                                    uniqueCompanyid[index] ??
                                                        "")));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffe6e8f6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListTile(
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Color(0xff444546),
                                        size: 18,
                                      ),
                                      title: Text(uniqueCompanyNames[index] ??
                                          "") /*Text(data.clientModel!.data?[index]
                                              .companyName ??
                                          "")*/
                                      ,
                                    ),
                                  ),
                                );
                              },
                            );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
