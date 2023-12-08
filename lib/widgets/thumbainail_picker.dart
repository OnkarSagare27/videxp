import 'package:flutter/material.dart';

class ThumbnailPicker extends StatefulWidget {
  final double height;
  final double width;
  final double borderRadius;

  const ThumbnailPicker({
    super.key,
    this.height = 100,
    this.width = 200,
    this.borderRadius = 20,
  });

  @override
  State<ThumbnailPicker> createState() => _ThumbnailPickerState();
}

class _ThumbnailPickerState extends State<ThumbnailPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius))),
    );
  }
}
