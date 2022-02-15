import 'package:flutter/material.dart';
import 'package:notes_app/screens/add_screen.dart';

class NoteItem extends StatefulWidget {
  final List<String> listItems;
  final List<String> titleItems;
  final Color randomColor;
  final int index;
  final VoidCallback onTap;
  const NoteItem(
      {Key? key,
      required this.index,
      required this.onTap,
      required this.listItems,
      required this.titleItems,
      required this.randomColor})
      : super(key: key);

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: InkWell(
        onTap: () {
          Route route = MaterialPageRoute(builder: (context) {
            return const AddScreen();
          });
          Navigator.push(context, route);
        },
        onDoubleTap: () {
          // print('hey');
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: widget.randomColor,
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
            // leading: Text(
            //   widget.titleItems[widget.index].toString(),
            //   style: const TextStyle(color: Colors.black),
            // ),
            title: Text(
              widget.listItems[widget.index].toString(),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
