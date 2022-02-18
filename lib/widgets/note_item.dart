import 'package:flutter/material.dart';
import 'package:notes_app/providers/provider.dart';
import 'package:notes_app/screens/add_screen.dart';
import 'package:provider/provider.dart';

class NoteItem extends StatelessWidget {
  final List<String> listItems;
  final List<String> titleItems;
  final Color randomColor;
  final int index;
  const NoteItem({
    Key? key,
    required this.index,
    required this.listItems,
    required this.titleItems,
    required this.randomColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputTextVM = Provider.of<InputTextProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: InkWell(
        onTap: () {
          Route route = MaterialPageRoute(builder: (context) {
            inputTextVM.updateValues(
              index,
              titleItems.elementAt(index),
              listItems.elementAt(index),
              true,
            );

            return AddScreen(
              addScreenInputText: inputTextVM.inputValue,
              addScreenTitleText: inputTextVM.titleValue,
            );
          });
          Navigator.push(context, route);
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: randomColor,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black,
                blurRadius: 5.0,
                offset: Offset(0.0, 0.3),
              )
            ],
          ),
          child: ListTile(
            title: Text(
              listItems[index],
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
