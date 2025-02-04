import 'package:attendance/utils/app_colors.dart';
import 'package:flutter/material.dart';

loadingDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        );
      },
    );

loading([String? message]) => Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          message != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Color(int.parse(AppColors.primary)),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
