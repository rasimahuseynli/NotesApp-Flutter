import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/providers/provider.dart';
import 'package:notes_app/widgets/icon_buttons.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  final String addScreenTitleText;
  final String addScreenInputText;

  const AddScreen({
    Key? key,
    required this.addScreenTitleText,
    required this.addScreenInputText,
  }) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: widget.addScreenInputText);
    _titleController = TextEditingController(text: widget.addScreenTitleText);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputVM = Provider.of<InputTextProvider>(context);
    return Scaffold(
      appBar: _buildAppBar(context, inputVM),
      body: _buildAddScreenBody(context, inputVM),
      backgroundColor: const Color(0xff252525),
    );
  }

  Widget _buildAddScreenBody(BuildContext context, InputTextProvider inputVM) {
    return Container(
      margin: const EdgeInsets.only(left: 24),
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              keyboardType: TextInputType.multiline,
              maxLength: 35,
              maxLines: 2,
              cursorHeight: 60,
              cursorColor: const Color(0xffc4c4c4),
              autofocus: true,
              onChanged: (value) {
                inputVM.titleValue = value;
              },
              style: GoogleFonts.nunito(
                fontSize: 48,
                fontWeight: FontWeight.w400,
                color: const Color(0xff9A9A9A),
              ),
              decoration: InputDecoration(
                hintText: 'Title...',
                suffixIcon: IconButton(
                  onPressed: () {
                    _titleController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
                hintStyle: GoogleFonts.nunito(
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff9A9A9A),
                ),
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              cursorHeight: 30,
              cursorColor: const Color(0xffc4c4c4),
              autofocus: true,
              onChanged: (value) => inputVM.inputValue = value,
              style: GoogleFonts.nunito(
                fontSize: 23,
                fontWeight: FontWeight.w400,
                color: const Color(0xff9A9A9A),
              ),
              decoration: InputDecoration(
                hintText: 'Type something...',
                suffixIcon: IconButton(
                  onPressed: () {
                    _inputController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
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
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, InputTextProvider inputVM) {
    return AppBar(
      centerTitle: false,
      backgroundColor: const Color(0xff252525),
      leading: IconButton(
        onPressed: () {
          inputVM.clear();
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.chevron_left,
          size: 30.0,
        ),
      ),
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: IconButtons(
            icon: Icons.save,
            onTap: () {
              inputVM.addNote();
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
