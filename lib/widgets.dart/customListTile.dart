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
        style: Theme.of(context).textTheme.titleLarge,
      ),
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}
