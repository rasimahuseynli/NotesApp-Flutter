import 'package:flutter/material.dart';
import 'package:notes_app/providers/provider.dart';
// import 'package:notes_app/screens/add_screen.dart';
// import 'package:notes_app/widgets/icon_buttons.dart';
import 'package:notes_app/widgets/note_item.dart';
import 'package:provider/provider.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class NotesScreenMap extends StatefulWidget {
  const NotesScreenMap({Key? key}) : super(key: key);

  @override
  State<NotesScreenMap> createState() => _NotesScreenMapState();
}

class _NotesScreenMapState extends State<NotesScreenMap> {
  List<Color> listColors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.orange,
    Colors.blueGrey,
    Colors.grey
  ];
  List<Color> colors = [];
  int random() => Random().nextInt(listColors.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      backgroundColor: const Color(0xff252525),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    // final inputTextVM = Provider.of<InputTextProvider>(context, listen: false);

    return AppBar(
      centerTitle: false,
      backgroundColor: const Color(0xff252525),
      toolbarHeight: kToolbarHeight,
      elevation: 0,
      // actions: [
      //   IconButtons(
      //     icon: Icons.search,
      //     onTap: () {
      //       Route route = MaterialPageRoute(builder: (context) {
      //         return AddScreen(
      //           addScreenInputText: inputTextVM.inputValue,
      //           addScreenTitleText: inputTextVM.titleValue,
      //         );
      //       });
      //       Navigator.push(context, route);
      //     },
      //   ),
      //   const SizedBox(
      //     width: 21,
      //   ),
      // ],
    );
  }

  Widget _buildBody() {
    colors.add(listColors[random()]);
    final inputTextVM = Provider.of<InputTextProvider>(context);

    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: inputTextVM.titleMap.keys.length,
      itemBuilder: (context, index) {
        // final title = inputTextVM.titleMap.values.elementAt(index);

        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              inputTextVM.deleteItem(index);
            }
          },
          child: NoteItem(
            index: index,
            listItems: inputTextVM.listItems,
            titleItems: inputTextVM.titleItems,
            randomColor: colors[index],
          ),
        );
      },
    );
  }
}
