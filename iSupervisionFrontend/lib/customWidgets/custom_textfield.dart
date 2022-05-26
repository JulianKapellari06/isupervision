import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Icon? icon;
  final double width;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final bool isPassword;
  final bool isEmail;
  final TextEditingController? controller;
  final bool? enabled;

  const CustomTextField(
      {Key? key,
      this.onTap,
      this.enabled,
      this.hintText,
      this.icon,
      required this.controller,
      required this.width,
      this.validator,
      this.onSaved,
      this.isEmail = false,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: width,
      child: TextFormField(
        style: const TextStyle(color: Color(0xFFee707d)),
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          errorStyle: const TextStyle(
            fontSize: 12,
          ),
          prefixIcon: icon != null
              ? InkWell(
                  onTap: onTap,
                  onHover: (value) {
                    //TODO
                  },
                  child: icon,
                )
              : null,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(
                color: Color(0xFFee707d),
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        validator: validator,
        onSaved: onSaved,
        obscureText: isPassword ? true : false,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
