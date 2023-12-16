import 'package:flutter/material.dart';

class StatusDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StatusDialogState();
  }
}

class StatusDialogState extends State<StatusDialog> {
  String _selectedText = "SSD";
  List<String> items = ["Car", "Bus", "Train", "Aeroplane"];
  String currentItem = "Select";
  @override
  void initState() {
    currentItem = items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DropdownButton(
            value: currentItem,
            items: items
                .map<DropdownMenuItem<String>>(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (String? value) => setState(
              () {
                if (value != null) currentItem = value;
              },
            ),
          ),
          Text(currentItem),
        ],
      ),
    ));
  }
}
