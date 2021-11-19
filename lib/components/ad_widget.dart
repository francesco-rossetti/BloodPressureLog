import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ADWidget extends StatefulWidget {
  final BannerAd? banner;

  const ADWidget({Key? key, this.banner}) : super(key: key);

  @override
  _ADWidgetState createState() => _ADWidgetState();
}

class _ADWidgetState extends State<ADWidget> {
  @override
  void initState() {
    widget.banner!.dispose();
    widget.banner!.load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Container(
        child: AdWidget(ad: widget.banner!),
        width: widget.banner!.size.width.toDouble(),
        height: widget.banner!.size.height.toDouble(),
        alignment: Alignment.center,
      ),
    );
  }
}
