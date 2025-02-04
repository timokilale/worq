import 'package:attendance/models/login.dart';
import 'package:attendance/ui/login_progress.dart';
import 'package:attendance/ui/widgets/common/custom_icon.dart';
import 'package:attendance/ui/widgets/login_slider_img.dart';
import 'package:attendance/ui/widgets/logo.dart';
import 'package:attendance/utils/app_colors.dart';
import 'package:attendance/utils/actions/common_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const LoginSliderImg(img: 'login_capture_fingerprint.png'),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: const Logo(),
                      ),
                      const Row(
                        children: [
                          Text(
                            'Welcome to',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CustomIcon(
                            icon: 'waving_hand.png',
                            size: 20.0,
                          ),
                        ],
                      ),
                      Text(
                        'ShuleSoft Attendance',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(int.parse(AppColors.primary)),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Hello there, login to continue',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: FormBuilderTextField(
                          name: 'code',
                          decoration: InputDecoration(
                            labelText: "School's login code",
                            labelStyle: TextStyle(
                              fontSize: 12.0,
                              color: Color(
                                int.parse(AppColors.primary),
                              ),
                            ),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Color(int.parse(AppColors.primary)),
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Color(int.parse(AppColors.primary)),
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Color(int.parse(AppColors.primary)),
                                width: 1.0,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(8.0),
                          ),
                          obscureText: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: MaterialButton(
                          color: Color(int.parse(AppColors.primary)),
                          minWidth: double.infinity,
                          height: 36.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () {
                            if (_formKey.currentState?.saveAndValidate() ?? false) {
                              try {
                                String code = _formKey.currentState?.fields['code']?.value;
                                int parsedCode = int.parse(code); // Parse the code
                                Login login = Login(
                                  method: 'AttendanceLogin',
                                  code: parsedCode,
                                  imei: '4489939438653',
                                  latitude: '229383447',
                                  longitude: '23836253',
                                  agent: 'Samsung',
                                );
                                navigate(context, LoginProgress(login: login)); // Custom navigation
                              } catch (e) {
                                debugPrint('Invalid code: $e');
                              }
                            } else {
                              debugPrint('Form is invalid');
                            }
                          },

                          child: _loginTxt(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loginTxt() => const Text(
        'Login',
        style: TextStyle(color: Colors.white),
      );
}
