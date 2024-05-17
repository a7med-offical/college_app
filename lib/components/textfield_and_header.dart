import 'package:college_app/constants/style_font.dart';
import 'package:flutter/material.dart';

class TextFieldWithHeader extends StatelessWidget {
  TextFieldWithHeader(
      {super.key,
      required this.header,
      required this.icon,
      required this.controller,
      this.onTap, required this.hint});
  final String header;
  final IconData icon;
  final TextEditingController controller;
  void Function()? onTap;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: Style.font16,
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            onTap: onTap,
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'this field is required';
              }
            },
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(icon),
                fillColor: const Color.fromARGB(255, 77, 75, 75),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
