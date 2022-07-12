import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lesson1/utils/constants.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({Key? key}) : super(key: key);

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  bool _isHidden = true;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Text Field'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Full Name*",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                // prefixIcon: const Icon(Icons.person),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: Icon(Icons.close),
                hintText: 'Enter your name',
              ),
              keyboardType: TextInputType.text,
              autofocus: true,
              autocorrect: true,
              style:
                  kTextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              validator: (value) {
                final nameExp = RegExp(r'^[A-Za-z ]+$');
                if (value?.isEmpty == true) {
                  return 'Name is required.';
                } else if (!nameExp.hasMatch(value ?? '')) {
                  return 'Please enter character';
                }
                return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Phone Number*",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefix: Text('+998 '),
              ),
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,9}$'),
                    allow: true)
              ],
              validator: (value) {
                final phoneExp = RegExp(r'^\d\d\d-\d\d-\d\d');
                if (value?.isEmpty == true) {
                  return 'Phone number required';
                } else if (!phoneExp.hasMatch(value ?? '')) {
                  return 'Incorrect format';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Email Address",
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty == true) {
                  return 'Email address required';
                } else if (value?.contains('@') == false ||
                    value?.contains('.') == false) {
                  return 'Invalid emain address';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Description",
              ),
              minLines: 5,
              maxLines: 15,
            ),
            TextFormField(
              obscureText: _isHidden,
              decoration: InputDecoration(
                  labelText: "Password",
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          _isHidden = !_isHidden;
                        });
                      },
                      icon: Icon(
                        _isHidden
                            ? Icons.remove_red_eye
                            : Icons.panorama_fish_eye,
                        color: Colors.grey,
                      ))),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Confirm Password",
              ),
            ),
            MaterialButton(
              onPressed: () {
                formKey.currentState?.validate();
              },
              color: Colors.green,
              child: Text(
                'Submit',
                style: kTextStyle(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
