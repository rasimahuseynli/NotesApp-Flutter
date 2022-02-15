import 'package:flutter/material.dart';
import 'package:notes_app/providers/provider.dart';
import 'package:notes_app/screens/add_screen.dart';
// import 'package:notes_app/widgets/alert_dialog_module.dart';
import 'package:notes_app/widgets/icon_buttons.dart';
import 'package:notes_app/widgets/note_item.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  // Future<String?> _changeNoteItems(BuildContext context, int index) {
  //   return showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialogWidget(
  //         formKey: _formKey,
  //         isAdded: false,
  //         hintLabel: Provider.of<InputTextProvider>(context, listen: false)
  //             .listItems[index],
  //         // onPressLeft: () {
  //         //   setState(() {
  //         //     listItems.remove(listItems[index]);
  //         //     Navigator.pop(context);
  //         //   });
  //         // },
  //         onPressSave: () {
  //           String inputText =
  //               Provider.of<InputTextProvider>(context).inputText;
  //           setState(
  //             () {
  //               if (_formKey.currentState!.validate()) {
  //                 Provider.of<InputTextProvider>(context, listen: false)
  //                     .listItems[index] = inputText;
  //                 Navigator.pop(context);
  //               }
  //             },
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // Future<String?> _addToDo(BuildContext context) {
  //   return showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialogWidget(
  //         formKey: _formKey,
  //         // isAdded: true,
  //         hintLabel: 'metn əlavə et',
  //         onPressSave: () {
  //           String inputText =
  //               Provider.of<InputTextProvider>(context, listen: false)
  //                   .inputText;
  //           setState(
  //             () {
  //               if (_formKey.currentState!.validate()) {
  //                 listItems.add(inputText);
  //                 Navigator.pop(context);
  //               }
  //             },
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  Future<String?> _infoButton(BuildContext context) {
    return showDialog<String>(
      context: context,
      barrierColor: const Color(0xffc4c4c4).withOpacity(0.2),
      builder: (BuildContext context) => AlertDialog(
        contentTextStyle: const TextStyle(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff252525),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        content: SizedBox(
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInfoText('Designed by -', TextAlign.left),
              _buildInfoText('Redesigned by -', TextAlign.left),
              _buildInfoText('Illustrations -', TextAlign.left),
              _buildInfoText('Icons -', TextAlign.left),
              _buildInfoText('Font -', TextAlign.left),
              _buildInfoText('Made by', TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText(String infoText, textAlign) {
    return Text(
      infoText,
      style: GoogleFonts.nunito(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: const Color(0xffc4c4c4),
        height: 1.4,
      ),
      textAlign: textAlign,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFAB(context),
      backgroundColor: const Color(0xff252525),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: const Color(0xff252525),
      toolbarHeight: kToolbarHeight,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Text(
          'Notes',
          style: GoogleFonts.nunito(
            fontSize: 43,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        IconButtons(
          icon: Icons.search,
          onTap: () {},
        ),
        const SizedBox(
          width: 21,
        ),
        IconButtons(
          icon: Icons.info_outline,
          onTap: () => _infoButton(context),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Provider.of<InputTextProvider>(context).listItems.isEmpty
        ? _buildNoNote()
        : _buildNoteList();
  }

  Widget _buildNoNote() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/rafiki.png'),
          Text(
            'Create your first note !',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteList() {
    colors.add(listColors[random()]);
    final inputTextVM = Provider.of<InputTextProvider>(context);
    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: inputTextVM.titleItems.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(index),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              inputTextVM.titleItems.removeAt(index);
            }
          },
          child: NoteItem(
              index: index,
              listItems: Provider.of<InputTextProvider>(context).listItems,
              titleItems: Provider.of<InputTextProvider>(context).titleItems,
              randomColor: colors[index],
              onTap: () {}
              // => _changeNoteItems(context, index),
              ),
        );
      },
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Route route = MaterialPageRoute(builder: (context) {
          return const AddScreen();
        });
        Navigator.push(context, route);
      },
      backgroundColor: const Color(0xff252525),
      child: const Icon(
        Icons.add,
        size: 28,
        color: Colors.white,
      ),
    );
  }
}
