import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinInputField extends StatelessWidget {
  const PinInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF00D09E), width: 2),
      ),
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) FocusScope.of(context).nextFocus();
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF003D33),
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: "",
        ),
      ),
    );
  }
}
