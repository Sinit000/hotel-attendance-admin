
import 'package:flutter/material.dart';

menuItemTile(
    {required onPressed(),
    required BuildContext context,
    required String title,
    requrired,
    Widget subtitle = const Center(),
    required String iconPath,
    required Color iconBackgroundColor,
    Widget? overidingWidget,
    AlignmentGeometry alignment = Alignment.centerLeft,
    Color? backgroundColor,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(20),
    Color? overidingColor}) {
  return TextButton(
          style: Theme.of(context).textButtonTheme.style!.copyWith(
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
              backgroundColor: MaterialStateProperty.all(
                  backgroundColor ?? Theme.of(context).colorScheme.surface),
              padding: MaterialStateProperty.all(contentPadding),
              alignment: alignment),
          //  TextButton.styleFrom(
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(standardBorderRadius)),
          //     textStyle: TextStyle(
          //         color:
          //             (overidingColor == null) ? Colors.black : overidingColor),
          //     backgroundColor: backgroundColor,
          //     padding: contentPadding,
          //     alignment: alignment),
          onPressed: () {
            onPressed();
          },
          child: overidingWidget ??
              Container(
                // color: Colors.grey,
                child: Column(
                  crossAxisAlignment: alignment == Alignment.centerLeft
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: alignment == Alignment.centerLeft
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: (overidingColor == null)
                                //         ? iconBackgroundColor.withAlpha(50)
                                //         : overidingColor.withAlpha(50),
                                //     blurRadius:
                                //         10.0, // has the effect of softening the shadow
                                //     spreadRadius:
                                //         2.0, // has the effect of extending the shadow
                                //     offset: Offset(
                                //       2, // horizontal, move right 10
                                //       2, // vertical, move down 10
                                //     ), // Shadow position
                                //   ),
                                // ],
                                color: (overidingColor == null)
                                    ? iconBackgroundColor
                                    : overidingColor,
                                borderRadius: BorderRadius.circular(100)),
                            child: ImageIcon(
                              AssetImage(iconPath),
                              color: Theme.of(context).colorScheme.onPrimary,
                            )),
                        // SizedBox(
                        //   width: 10,
                        // ),

                        subtitle
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      textAlign: alignment == Alignment.centerLeft
                          ? TextAlign.start
                          : TextAlign.center,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: (overidingColor == null)
                                ? Theme.of(context).textTheme.button!.color
                                : overidingColor,
                          ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ));
}

menuSubtitle(String text, {Color textColor = Colors.black26}) {
  return Builder(
    builder: (context) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 10),
          alignment: Alignment.centerRight,
          child: Text(text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: textColor)),
        ),
      );
    },
  );
}