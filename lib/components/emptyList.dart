import 'package:flutter/material.dart';

class EmptyListPlaceHolder extends StatefulWidget {
  final String title;
  final AssetImage image;
  final String descrizione;

  EmptyListPlaceHolder(
      {Key key,
      @required this.title,
      @required this.descrizione,
      @required this.image})
      : super(key: key);

  @override
  _EmptyListPlaceHolderState createState() => _EmptyListPlaceHolderState();
}

class _EmptyListPlaceHolderState extends State<EmptyListPlaceHolder> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Center(child: Image(image: widget.image, width: 150)),
            SizedBox(height: 30),
            Center(
                child: Text(widget.title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            SizedBox(height: 5),
            Center(
                child: Text(widget.descrizione,
                    style: TextStyle(fontWeight: FontWeight.normal))),
          ],
        ));
  }
}
