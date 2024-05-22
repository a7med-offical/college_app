import 'dart:convert';
import 'package:college_app/views/admin_home_view.dart';
import 'package:http/http.dart' as http;
import 'package:college_app/components/button_componet.dart';
import 'package:college_app/components/textfield_and_header.dart';
import 'package:college_app/constants/style_font.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController gmail = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  String gender = 'male';
  String role = 'user';
  String? token;
  DateTime? date;

  Future<void> UserRegister() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse(
            'http://localhost:============='), //=======>>>====>>>>Link Local Host هنا
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name.text,
          'email': email.text,
          'password': pass.text,
          'grail': gmail.text,
          'address': address.text,
          'phone': phone.text,
          'dateOfBirth': dateOfBirth.text,
          'gender': gender,
          'role': role,
        }),
      );

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          token = responseBody['token'];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User registered successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to register')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('Assets/images/register.png'),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Register Now !',
                  style: Style.font24,
                ),
                const Text(
                  'Register Now To descover more Services',
                  style: Style.font16,
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFieldWithHeader(
                  hint: 'type tour name',
                  controller: name,
                  header: 'name',
                  icon: Icons.person,
                ),
                TextFieldWithHeader(
                  hint: 'type your email',
                  controller: email,
                  header: 'email',
                  icon: Icons.email,
                ),
                TextFieldWithHeader(
                  hint: 'create strong passsword',
                  controller: pass,
                  header: 'password',
                  icon: Icons.lock,
                ),
                TextFieldWithHeader(
                  hint: 'type tour gmail',
                  controller: gmail,
                  header: 'gmail',
                  icon: Icons.mark_email_read_rounded,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: DropdownButtonFormField<String>(
                    value: role,
                    items: ['user', 'admin'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        role = newValue!;
                      });
                    },
                  ),
                ),
                TextFieldWithHeader(
                  hint: 'type tour address',
                  controller: address,
                  header: 'address',
                  icon: Icons.location_on,
                ),
                TextFieldWithHeader(
                  hint: 'type tour phone',
                  controller: phone,
                  header: 'phone',
                  icon: Icons.phone,
                ),
                TextFieldWithHeader(
                  hint: 'type your date of birth',
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      String formattedDate = pickedDate
                          .toString()
                          .substring(0, 10); // Remove milliseconds
                      dateOfBirth.text = formattedDate;
                    }
                  },
                  controller: dateOfBirth,
                  header: 'date of birth',
                  icon: Icons.calendar_month,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: DropdownButtonFormField<String>(
                    value: gender,
                    items: ['male', 'female'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        gender = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  onPressed: () {
                    UserRegister();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => adminHomeView(),));
                  },
                  textButton: 'Register',
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
