import 'package:flutter/material.dart';

class EmptyListPlaceHolder extends StatefulWidget {
  final String title;
  final AssetImage image;
  final String descrizione;

  const EmptyListPlaceHolder(
      {Key? key,
      required this.title,
      required this.descrizione,
      required this.image})
      : super(key: key);

  @override
  EmptyListPlaceHolderState createState() => EmptyListPlaceHolderState();
}

class EmptyListPlaceHolderState extends State<EmptyListPlaceHolder> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Center(child: Image(image: widget.image, width: 150)),
            const SizedBox(height: 30),
            Center(
                child: Text(widget.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold))),
            const SizedBox(height: 5),
            Center(
                child: Text(widget.descrizione,
                    style: const TextStyle(fontWeight: FontWeight.normal))),
          ],
        ));
  }
}
