import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

import '../../../appLocalizations.dart';

class ApproveBoard extends StatefulWidget {
  const ApproveBoard({Key? key}) : super(key: key);

  @override
  State<ApproveBoard> createState() => _ApproveBoardState();
}

class _ApproveBoardState extends State<ApproveBoard> {
  @override
  Widget build(BuildContext context) {
    List<String> mylist = [
      '${AppLocalizations.of(context)!.translate("leave")!}',
      '${AppLocalizations.of(context)!.translate("leave_out")!}',
      '${AppLocalizations.of(context)!.translate("ot_compesation")!}',
      '${AppLocalizations.of(context)!.translate("off_day")!}'
    ];
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("approve_board")!}"),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        // implement GridView.builder
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: 4,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                onTap: () {
                  if (index == 0) {
                    Navigator.pushNamed(context, leave);
                  }
                  if (index == 1) {
                    Navigator.pushNamed(context, leaveout);
                  }
                  if (index == 2) {
                    Navigator.pushNamed(context, otcompesation);
                  }
                  if (index == 3) {
                    Navigator.pushNamed(context, dayoff);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(mylist[index],
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
              );
            }),
      )),
    );
  }
}
