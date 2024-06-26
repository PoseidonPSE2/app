import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hello_worl2/model/bottle.dart';
import 'package:hello_worl2/pages/drawer/bottle/bottle_edit.dart';
import 'package:hello_worl2/provider/bottle_provider.dart';
import 'package:hello_worl2/widgets/loading.dart';
import 'package:provider/provider.dart';

class BottleTile extends StatefulWidget {
  final Bottle bottle;
  const BottleTile({required this.bottle, super.key});

  @override
  State<BottleTile> createState() => _BottleTileState();
}

class _BottleTileState extends State<BottleTile> {
  bool _isLoading = false;

  ImageProvider<Object> _getImageProvider() {
    if (widget.bottle.pathImage == null || widget.bottle.pathImage!.isEmpty) {
      return const AssetImage("assets/image/wasserspender.jpg");
    } else {
      final base64Data = widget.bottle.pathImage!;
      return MemoryImage(base64Decode(base64Data));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditBottle(
                                bottle: widget.bottle,
                              )));
                    },
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image(
                          image: _getImageProvider(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      widget.bottle.title,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.bottle.fillVolume.round()} ml",
                          ),
                          Text(
                            widget.bottle.waterType == "tap"
                                ? "Still"
                                : "Sprudel",
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: _isLoading
                            ? LoadingScreen()
                            : IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                                onPressed: _isLoading ? null : _onRemoveBottle,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _onRemoveBottle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Provider.of<BottleProvider>(context, listen: false)
          .removeBottle(widget.bottle.id!);
    } catch (e) {
      print('Error removing bottle: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
