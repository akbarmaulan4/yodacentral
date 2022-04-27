import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/models/model_pipeline.dart';

class FilterChipCustom extends StatefulWidget {
  const FilterChipCustom({
    Key? key,
    required this.onTap,
    required this.modelPipeline,
    this.isCek = false,
  }) : super(key: key);
  final ValueChanged<ModelReturnPipeline> onTap;
  final ModelPipeline modelPipeline;
  final bool isCek;

  @override
  _FilterChipCustomState createState() => _FilterChipCustomState();
}

class _FilterChipCustomState extends State<FilterChipCustom> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        side: widget.isCek
            ? BorderSide(color: Colors.transparent, width: 1)
            : BorderSide(
                color: Colors.black,
                width: 1,
              ),
        borderRadius: BorderRadius.circular(8),
      ),
      selectedColor: yd_Color_Primary_opacity,
      backgroundColor: widget.isCek ? yd_Color_Primary_opacity : Colors.white,
      selected: widget.isCek,
      onSelected: (v) {
        log(widget.modelPipeline.title);
        setState(() {
          widget.onTap(
            ModelReturnPipeline(
              id: widget.modelPipeline.id,
              title: widget.modelPipeline.title,
              category: widget.modelPipeline.category,
              isActive: v,
            ),
          );
        });
      },
      label: Text(widget.modelPipeline.title),
    );
  }
}

Widget chipSelected(ModelReturnPipeline modelPipeline) {
  return Container(
    margin: EdgeInsets.only(top: 5, bottom: 5),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    decoration: BoxDecoration(
      color: yd_Color_Primary_opacity,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(modelPipeline.title),
  );

  // IgnorePointer(
  //   ignoring: true,
  //   child: FilterChip(
  //     showCheckmark: false,
  //     shape: RoundedRectangleBorder(
  //       side: BorderSide(color: Colors.transparent, width: 1),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     selectedColor: yd_Color_Primary_opacity,
  //     backgroundColor: yd_Color_Primary_opacity,
  //     selected: true,
  //     onSelected: (v) {},
  //     label: Text(modelPipeline.title),
  //   ),
  // );
}

class ModelReturnPipeline {
  ModelReturnPipeline({
    required this.id,
    required this.title,
    required this.category,
    required this.isActive,
  });

  int id;
  String title;
  String category;
  bool isActive;
}
