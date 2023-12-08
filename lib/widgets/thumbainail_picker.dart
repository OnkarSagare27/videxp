// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ThumbnailPicker extends StatefulWidget {
  double height;
  double width;
  void Function() onTap;
  BorderRadius borderRadius;
  Widget child;

  ThumbnailPicker({
    super.key,
    this.height = 200,
    this.width = 300,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    required this.onTap,
    required this.child,
  });

  @override
  State<ThumbnailPicker> createState() => _ThumbnailPickerState();
}

class _ThumbnailPickerState extends State<ThumbnailPicker> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: widget.borderRadius,
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: widget.borderRadius,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
