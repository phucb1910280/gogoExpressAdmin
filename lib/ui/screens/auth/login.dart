import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';
import 'package:gogo_admin/ui/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailCtr = TextEditingController();
  var pwCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showPW = false;

  @override
  void dispose() {
    emailCtr.dispose();
    pwCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: MColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/gogoship.png",
                      height: 100,
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        Text(
                          "Xin chào!",
                          style: GoogleFonts.playfairDisplay(
                            textStyle: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: MColors.darkBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Hãy điền email và mật khẩu để đăng nhập",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    loginForm(),
                    const SizedBox(height: 15),
                    const Row(
                      children: [
                        Text(
                          "Quên mật khẩu?",
                          style: TextStyle(
                            fontSize: 17,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailCtr,
            obscureText: false,
            style: const TextStyle(fontSize: 18, color: MColors.darkBlue),
            decoration: InputDecoration(
              hoverColor: Colors.teal.withOpacity(.1),
              hintText: "Email",
              hintStyle: const TextStyle(fontSize: 17, color: MColors.darkBlue),
              prefixIcon: const Icon(
                Icons.email,
                color: MColors.darkBlue,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    emailCtr.text = "";
                  });
                },
                child: const Icon(
                  Icons.clear,
                  color: MColors.lightBlue,
                ),
              ),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MColors.darkBlue),
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: MColors.background),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: MColors.error),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: MColors.error),
              ),
              filled: true,
              fillColor: MColors.white,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Vui lòng nhập email";
              }
              if (!value.contains(".") && !emailCtr.text.contains("@admin")) {
                return "Email không hợp lệ / không đúng";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: pwCtr,
            obscureText: !showPW,
            style: const TextStyle(fontSize: 18, color: MColors.darkBlue),
            decoration: InputDecoration(
                hoverColor: Colors.teal.withOpacity(.1),
                hintText: "Mật khẩu",
                hintStyle:
                    const TextStyle(fontSize: 17, color: MColors.darkBlue),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: MColors.darkBlue,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      showPW = !showPW;
                    });
                  },
                  child: Icon(
                    !showPW ? Icons.visibility : Icons.visibility_off,
                    color: MColors.lightBlue,
                  ),
                ),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: MColors.darkBlue),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: MColors.background),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: MColors.error),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: MColors.error),
                ),
                filled: true,
                fillColor: MColors.white),
            validator: (value) {
              if (value!.isEmpty) {
                return "Vui lòng nhập mật khẩu";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailCtr.text.trim(), password: pwCtr.text.trim());
                  if (FirebaseAuth.instance.currentUser != null) {
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false);
                    }
                  }
                } catch (e) {
                  debugPrint(e.toString());
                  var snackBar = const SnackBar(
                    content: Text('Sai email hoặc mật khẩu!'),
                    backgroundColor: MColors.error,
                    duration: Duration(seconds: 1),
                  );
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MColors.darkBlue,
              foregroundColor: MColors.white,
              minimumSize: const Size.fromHeight(55),
            ),
            child: const Text(
              "Đăng nhập",
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
