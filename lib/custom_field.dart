import 'package:flutter/material.dart';

import 'package:provider/provider.dart';



class CustomField extends StatelessWidget {
  final TextEditingController? controller;
  final String title, hint;

  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool? isTaskDescription;
  final bool? isDateOrTimeField;
  final double? fontSize;

  const CustomField({
    super.key,
    required this.title,
    required this.hint,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.onTap,
    this.isTaskDescription = false,
    this.isDateOrTimeField = false,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(left: 13, top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 20
          )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7),
            child: TextFormField(
              onTap: onTap,

              textInputAction: TextInputAction.next,
              minLines: isTaskDescription == true ? 2 : 1,
              maxLines: suffixIcon != null ? 1 : 150,
              validator: validator,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: isDateOrTimeField == true ? 11 : 13,
                    horizontal: suffixIcon != null ? 14 : 6),
                fillColor: Colors.black54,
                filled: true,
                hintText: hint,
                hintMaxLines: 1,
          ///      hintStyle: buildHintTextStyle(context),
                hintStyle:const TextStyle(
                  fontSize: 13 ,
                  letterSpacing:  1.5,
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,

                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: suffixIcon != null ? Colors.black : Colors.white,
                      width: 1.5),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 7.0),
                  child: suffixIcon,
                ),
              ),
              autofocus: false,
              readOnly: suffixIcon != null,
              controller: controller,
              style: const TextStyle(
                fontSize: 18,
                color:   Colors.white,
                fontWeight: FontWeight.w400,

              ),
            ),
          ),
        ],
      ),
    );
  }


}
