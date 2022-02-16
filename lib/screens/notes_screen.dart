import 'package:flutter/material.dart';
import 'package:notes_app/providers/provider.dart';
import 'package:notes_app/screens/add_screen.dart';
import 'package:notes_app/screens/notes_screen_map.dart';
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
          onTap: () {
            Route route = MaterialPageRoute(builder: (context) {
              return const NotesScreenMap();
            });
            Navigator.push(context, route);
          },
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

  Widget _buildBody() {
    colors.add(listColors[random()]);
    final inputTextVM = Provider.of<InputTextProvider>(context);

    if (inputTextVM.titleItems.isEmpty) return _buildNoNote();

    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: inputTextVM.titleItems.length,
      itemBuilder: (context, index) {
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

  Widget _buildFAB(BuildContext context) {
    final inputTextVM = Provider.of<InputTextProvider>(context, listen: false);
    return FloatingActionButton(
      onPressed: () {
        Route route = MaterialPageRoute(builder: (context) {
          return AddScreen(
            addScreenInputText: inputTextVM.inputValue,
            addScreenTitleText: inputTextVM.titleValue,
          );
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
