import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;

  //final String? text;
  final String? hint;
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final FormFieldValidator? validate;

  //final String? labelText;
  final Widget? prefixIcon;
  final Function()? onTap;
  final IconData? suffixIcon;
  final bool isPassword;
  final Function? suffixPressed;
  final Function(String?)? onSaved;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? maxLength;
  final double? paddingValue;
  final double? fontSizeHint;
  final Color? colorHint;
  final Color? colorBorder;

  const CustomTextFormField(
      {Key? key,
      this.controller,
      required this.type,
      //required this.text,
      required this.hint,
      this.onSubmit,
      this.onChange,
      required this.validate,
      //this.labelText,
      this.paddingValue,
      this.prefixIcon,
      this.maxLength,
      this.fontSizeHint,
      this.colorHint,
      this.colorBorder,
      this.onTap,
      this.suffixIcon,
      this.isPassword = false,
      this.suffixPressed,
      this.onSaved,
      this.focusNode,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomText(
          //   text: text,
          //   textStyle: thirdTextStyle().copyWith(color: Colors.grey.shade900),
          // ),
          TextFormField(
            focusNode: focusNode,
            cursorColor: AppColors.myBlack,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.start,
            controller: controller,
            keyboardType: type,
            onFieldSubmitted: onSubmit,
            onChanged: onChange,
            maxLines: maxLines,
            onTap: onTap,
            onSaved: onSaved,
            maxLength: maxLength,
            validator: validate,
            obscureText: isPassword,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              counterText: "",
              prefixIcon: prefixIcon,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 15.w, vertical: paddingValue ?? 4.h),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: colorBorder ?? AppColors.myGery.withOpacity(.5)),
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
              ),
              border: const OutlineInputBorder(),
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
              hintTextDirection: TextDirection.ltr,
              //labelText: labelText,
              hintText: hint,
              hintStyle: TextStyle(
                color: colorHint ?? AppColors.myGery,
                fontSize: fontSizeHint ?? 14.sp,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  suffixIcon,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {
                  if (suffixIcon != null) {
                    suffixPressed!();
                  }
                },
                // color: Colors.white,
              ),
            ),
          ),

          // disabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //       width: 2, color: borderColor ?? const Color(0xffE8E7E7)),
          //   borderRadius: BorderRadius.all(Radius.circular(radius ?? 25.r)),
          // ),

          // errorBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(width: 2, color: Colors.red),
          //   borderRadius: BorderRadius.all(Radius.circular(radius ?? 25.r)),
          // ),
        ],
      ),
    );
  }
}
