import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/providers/provider.dart';
import 'package:notes_app/widgets/icon_buttons.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildAddScreenBody(context),
      backgroundColor: const Color(0xff252525),
    );
  }

  Widget _buildAddScreenBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            cursorHeight: 60,
            cursorColor: const Color(0xffc4c4c4),
            autofocus: true,
            onChanged: (text) {
              Provider.of<InputTextProvider>(context, listen: false)
                  .newTitleText(text);
            },
            style: GoogleFonts.nunito(
              fontSize: 48,
              fontWeight: FontWeight.w400,
              color: const Color(0xff9A9A9A),
            ),
            decoration: InputDecoration(
              hintText: 'Title...',
              hintStyle: GoogleFonts.nunito(
                fontSize: 48,
                fontWeight: FontWeight.w400,
                color: const Color(0xff9A9A9A),
              ),
              border: InputBorder.none,
            ),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            cursorHeight: 30,
            cursorColor: const Color(0xffc4c4c4),
            autofocus: true,
            onChanged: (text) {
              Provider.of<InputTextProvider>(context, listen: false)
                  .newInputText(text);
            },
            style: GoogleFonts.nunito(
              fontSize: 23,
              fontWeight: FontWeight.w400,
              color: const Color(0xff9A9A9A),
            ),
            decoration: InputDecoration(
              hintText: 'Type something...',
              hintStyle: GoogleFonts.nunito(
                fontSize: 23,
                fontWeight: FontWeight.w400,
                color: const Color(0xff9A9A9A),
              ),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: const Color(0xff252525),
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: IconButtons(
            icon: Icons.save,
            onTap: () {
              setState(() {
                if (Provider.of<InputTextProvider>(context, listen: false)
                        .inputText ==
                    '') {
                  Provider.of<InputTextProvider>(context, listen: true)
                      .clearText();
                }
                if (Provider.of<InputTextProvider>(context, listen: false)
                        .titleText ==
                    '') {
                  Provider.of<InputTextProvider>(context, listen: true)
                      .clearTitleText();
                }
                Provider.of<InputTextProvider>(context, listen: false)
                    .addItem();
                Provider.of<InputTextProvider>(context, listen: false)
                    .addTitleItem();
                Navigator.pop(context);
              });
            },
          ),
        ),
      ],
    );
  }
}
