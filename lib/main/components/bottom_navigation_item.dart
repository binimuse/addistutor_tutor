// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer' as developer;

// ignore: import_of_legacy_library_into_null_safe
import 'package:tuple/tuple.dart';

import '../../../constants.dart';

class BottomNavigationItem extends StatefulWidget {
  static const ROUTE_NAME = 'BottomNavigationItem';

  final Tuple2<String, String> icon;
  final VoidCallback onPress;
  final bool isSelected;
  const BottomNavigationItem(this.icon, this.isSelected,
      {required this.onPress});

  @override
  _BottomNavigationItemState createState() => _BottomNavigationItemState();
}

class _BottomNavigationItemState extends State<BottomNavigationItem> {
  static const TAG = 'BottomNavigationItem';
  @override
  Widget build(BuildContext context) {
    developer.log('build', name: TAG);
    return InkResponse(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: kIsWeb
            ? Image.asset(
                widget.isSelected ? widget.icon.item2 : widget.icon.item1,
                color: Colors.black,
              )
            : SvgPicture.asset(
                widget.isSelected ? widget.icon.item2 : widget.icon.item1,
                color: kPrimaryColor,
              ),
      ),
      onTap: widget.onPress,
    );
  }
}
