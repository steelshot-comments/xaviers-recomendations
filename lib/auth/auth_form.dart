part of 'auth_screen.dart';

bool authTypeSignUp = false;

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});
  static RegExp emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static String xavPattern = 'xaviers.edu.in';

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool emailValidator(String? value) {
      if (value == null || !value.endsWith(AuthForm.xavPattern)) {
        return false;
      }
      return true;
    }

    void onButtonPress() {
      formkey.currentState!.save();
      if (authTypeSignUp) {
        if (displayNameController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 1000),
              content: Text("Display name cannot be empty")));
        } else {
          FirebaseFunctions.signUpUser(emailController.text,
              passwordController.text, displayNameController.text, context);
        }
      } else {
        if (emailController.text.isEmpty ||
            !emailController.text.endsWith(AuthForm.xavPattern)) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 1000),
              content: Text("Email must be under the xaviers.edu.in domain")));
        } else {
          FirebaseFunctions.LoginUser(
              emailController.text, passwordController.text, context);
        }
      }
    }

    return Form(
      key: formkey,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: FadeInUp(
          duration: const Duration(milliseconds: 1200),
          child: Column(
            children: <Widget>[
              Container(
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: Color.fromARGB(255, 23, 8, 6)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(204, 91, 75, .2),
                        blurRadius: 20.0,
                        // offset: Offset(0, 10),
                      )
                    ]),
                child: Column(children: [
                  Visibility(
                    visible: authTypeSignUp,
                    child: Column(
                      children: [
                        AuthInput(
                            controller: displayNameController,
                            icon: const Icon(Icons.person_search_rounded),
                            obscureText: false,
                            hintText: 'Display name'),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Color.fromRGBO(204, 91, 75, 1),
                            height: 1,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AuthInput(
                    controller: emailController,
                    icon: Icon(Icons.mail_rounded),
                    obscureText: false,
                    hintText: 'example@xaviers.edu',
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(
                      color: Color.fromRGBO(204, 91, 75, 1),
                      height: 1,
                      thickness: 1,
                    ),
                  ),
                  AuthInput(
                    controller: passwordController,
                    icon: const Icon(Icons.lock_rounded),
                    obscureText: true,
                    hintText: 'Password',
                  ),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              SquircleButton(
                  textColor: Colors.white,
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(204, 91, 75, 1),
                    Color.fromRGBO(255, 106, 84, 1),
                  ]),
                  onTap: onButtonPress,
                  title: authTypeSignUp ? "Sign up" : "Sign in"),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      authTypeSignUp = !authTypeSignUp;
                    });
                  },
                  child: Text(
                    authTypeSignUp
                        ? "Already have an account? Sign in"
                        : "Don't have an account? Sign up",
                    style: const TextStyle(),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
