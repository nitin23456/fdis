import 'package:http/http.dart' as http;

Future<void> deleteRecord(String recordId) async {
  final String apiUrl = 'http://18.159.111.224:4002/api/v1/dashboard/Mob/delete/$recordId';

  try {
    final response = await http.delete(
      Uri.parse(apiUrl),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   // Add any additional headers as needed
      // },
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