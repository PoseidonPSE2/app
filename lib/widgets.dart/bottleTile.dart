import 'package:flutter/material.dart';
import 'package:hello_worl2/model/bottle.dart';
import 'package:hello_worl2/provider/bottleProvider.dart';
import 'package:provider/provider.dart';

class BottleTile extends StatefulWidget {
  final Bottle bottle;
  const BottleTile({required this.bottle, super.key});

  @override
  State<BottleTile> createState() => _BottleTileState();
}

class _BottleTileState extends State<BottleTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.bottle.path_image?.isEmpty ?? true
                    ? "assets/image/wasserspender.jpg"
                    : widget.bottle.path_image!,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 10.0),
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
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.bottle.fill_volume} ${widget.bottle.water_type}  ${widget.bottle.water_degree}",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.remove,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      setState(() {
                        context
                            .read<BottleProvider>()
                            .removeBottle(widget.bottle.title);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
