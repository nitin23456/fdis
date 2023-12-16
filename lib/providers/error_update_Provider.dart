import 'package:FdisTesting/models/error_Update_model.dart';
import 'package:FdisTesting/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UpadteDataProvider with ChangeNotifier {
  final api = Api();
  Future<void> updateData({
    required String id,
    String? message,
    String? technicalAspectsImages,
    String? logbookImages,
    Data? data,
    required String formId,
    required String errorTypeId,
    required String performerId,
    required String elementId,
    required String logbook,
    required String technicalAspects,
    required String logbookImage,
    required String technicalAspectsImage,
  }) async {
    final String apiUrl =
        'http://18.159.111.224:4002/api/v1/dashboard/Mob/update/$id';

    try {
      var body = {
        "FormId": "23E0F588-4427-4FC1-9DCC-0ACD2DBA4C26",
        "ErrorTypeId": "2A23F062-D37A-4F9B-B82F-30A5D35D951E",
        "ElementId": elementId,
        "Performer_Id": '',
        "Logbook": logbook,
        "TechnicalAspects": technicalAspects,
      };

      print("========================HTTP REQUEST++++++++++++++++++");
      print(apiUrl);
      print(body);

      var req = http.MultipartRequest('PATCH', Uri.parse(apiUrl));
      // req.headers.addAll(headersList);
      print(req.headers);
      req.files.add(await http.MultipartFile.fromPath('logbook', logbookImage,
          contentType: MediaType(
              'image', logbookImage.split('/').last.split('.').last)));

      req.files.add(await http.MultipartFile.fromPath(
          'technicalAspects', technicalAspects,
          contentType: MediaType(
              'image', technicalAspects.split('/').last.split('.').last)));
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

/////
      // final response = await http.patch(
      //   Uri.parse(apiUrl),
      //   body: ,
      // );

      // if (response.statusCode == 200) {
      //   print('Update successful');
      //   // Handle the updated data if needed
      // } else {
      //   print('Failed to update. Status code: ${response.statusCode}');
      //   // Handle the error
      // }
    } catch (error) {
      print('Error during update: $error');
      // Handle the error
    }
  }
}
