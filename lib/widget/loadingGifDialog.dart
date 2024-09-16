import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingGifDialog extends StatelessWidget {
  const LoadingGifDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(height: 50.h, width: 100.w, child: const Center(child: CircularProgressIndicator())),
    );
  }
}
