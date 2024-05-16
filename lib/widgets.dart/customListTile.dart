import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String text;
  final Widget destination;

  const CustomListTile(
      {required this.text, required this.destination, super.key});

  _navigateToDestination(BuildContext context, Widget destination) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}
