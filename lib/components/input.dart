part of 'auth_components.dart';

class AuthInput extends StatelessWidget {
  AuthInput(
      {super.key,
      required this.controller,
      this.icon,
      this.obscureText,
      this.onChanged,
      this.hintText,
      this.validator});

  TextEditingController controller;
  Icon? icon;
  bool? obscureText = false;
  String? hintText;
  String? Function(String?)? validator;

  void onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        cursorColor: Color.fromRGBO(204, 91, 75, 1),
        autovalidateMode: AutovalidateMode.always,
        validator: validator,
        controller: controller,
        obscureText: obscureText!,
        obscuringCharacter: '*',
        decoration: InputDecoration(
            prefixIcon: icon,
            prefixIconColor: Colors.grey[800],
            prefixIconConstraints: const BoxConstraints(minWidth: 35),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[700])),
      ),
    );
  }
}
