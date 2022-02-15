// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/providers/provider.dart';
import 'package:provider/provider.dart';

class AlertDialogWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isAdded;
  final String hintLabel;
  final Function() onPressSave;
  const AlertDialogWidget({
    Key? key,
    required this.formKey,
    required this.isAdded,
    required this.hintLabel,
    required this.onPressSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        isAdded ? "Əlavə et" : "Dəyiş",
      ),
      content: Form(
        key: formKey,
        child: TextFormField(
          autofocus: true,
          onChanged: (text) {
            Provider.of<InputTextProvider>(context, listen: false)
                .newInputText(text);
          },
          decoration: InputDecoration(
            hintText: hintLabel,
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressSave,
          child: const Text(''),
          // child: Text(
          //   // isAdded ? "Əlavə et" : "Dəyiş",
          //   style: TextStyle(
          //     color: Colors.lightGreen[600],
          //     fontSize: 20,
          //   ),
          // ),
        ),
      ],
    );
  }
}
