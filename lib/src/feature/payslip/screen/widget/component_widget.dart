import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/widget/menu_item_tile.dart';

class ComponentWidget extends StatelessWidget {
  final String? name;
  final Function onPressed;
  final Color backgroundColor;
  // EdgeInsetsGeometry contentPadding = const EdgeInsets.all(20),
  ComponentWidget(
      {required this.name,
      required this.onPressed,
      this.backgroundColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    // return menuItemTile(
    //     onPressed: onPressed,
    //     title: title,
    //     iconPath: iconPath,
    //     iconBackgroundColor: iconBackgroundColor);
    // return menuItemTile(onPressed: (){}, title: title, iconPath: iconPath, iconBackgroundColor: iconBackgroundColor)
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textStyle: TextStyle(color: Colors.white),
            backgroundColor: backgroundColor,
            alignment: Alignment.center,
            padding: EdgeInsets.all(25)),

        // style: TextStyle(),
        // style: Theme.of(context).textButtonTheme.style!.copyWith(
        //  shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(standardBorderRadius)),
        // textStyle: MaterialStateProperty.all(Theme.of(context)
        //         .textTheme
        //         .button!
        //         .copyWith(
        //             color: (overidingColor == null)
        //                 ? Theme.of(context).textTheme.button!.color
        //                 : overidingColor)

        //     ),

        // ),
        // style: TextButtonTheme.of(context).style!.copyWith(
        //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
        //         borderRadius: new BorderRadius.circular(10),
        //       )),
        //       padding:
        //           MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 35)),
        //     ),
        onPressed: onPressed as void Function()?,
        child: Text(this.name!,
            style: Theme.of(context).textTheme.button!.copyWith(fontSize: 20)),
      ),
    );
  }
}
