import 'package:FdisTesting/models/client_model.dart';
import 'package:FdisTesting/utils/api.dart';
import 'package:flutter/widgets.dart';

class ClientProvider with ChangeNotifier {
  final api = Api();
  ClientModel? clientModel;

  fetchClientList() async {
    final response = await api.get(
        'http://18.159.111.224:4002/api/v1/dashboard/mob/clientlist/ABD8A1FD-637F-459A-ADBD-EBF3CBE8EA66');

    final item = response.data;
    if (response.statusCode == 200) {
      clientModel = ClientModel.fromJson(item);
    }
    notifyListeners();
  }

  getAreaData() async {
    final response =
        await api.get('http://18.159.111.224:4002/api/v1/dashboard/area');

    final item = response.data;
    if (response.statusCode == 200) {
      clientModel = ClientModel.fromJson(item);
    }
    notifyListeners();
  }

  getDatalist() async {
    final response = await api
        .get('http://18.159.111.224:4002/api/v1/dashboard/Mob/getdata');

    final item = response.data;
    if (response.statusCode == 200) {
      clientModel = ClientModel.fromJson(item);
    }
    notifyListeners();
  }

  void changeState() {
    clientModel = null;
    notifyListeners();
  }
}
