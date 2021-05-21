import 'package:flutter/material.dart';

class ButtonLoadingWidget extends StatelessWidget {
  final bool loading;
  final VoidCallback? onPressed;
  final String label;

  const ButtonLoadingWidget({
    Key? key,
    required this.label,
    this.loading = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      child: loading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          : Text(label),
    );
  }
}
