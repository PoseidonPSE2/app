import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const CustomListTile({required this.text, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 21, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}
