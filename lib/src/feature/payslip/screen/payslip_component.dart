import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/delay_widget.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

import '../../../appLocalizations.dart';
import 'widget/component_widget.dart';

class PayslipComponent extends StatefulWidget {
  const PayslipComponent({Key? key}) : super(key: key);

  @override
  State<PayslipComponent> createState() => _PayslipComponentState();
}

class _PayslipComponentState extends State<PayslipComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("configuration")!}"),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: Theme.of(context).primaryColor,
          ),
          ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 20),
              delayedWidget(
                child: ComponentWidget(
                  name:
                      "${AppLocalizations.of(context)!.translate("contract")!}",
                  onPressed: () {
                    Navigator.of(context).pushNamed(contract);
                  },
                ),
              ),
              SizedBox(height: 20),
              delayedWidget(
                child: ComponentWidget(
                  name:
                      "${AppLocalizations.of(context)!.translate("structure")!}",
                  onPressed: () {
                    Navigator.of(context).pushNamed(structure);
                  },
                ),
              ),
              // SizedBox(height: 20),
              // delayedWidget(
              //   child: ComponentWidget(
              //     name:
              //         "${AppLocalizations.of(context)!.translate("structure_type")!}",
              //     onPressed: () {
              //       Navigator.of(context).pushNamed(structuretype);
              //     },
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
