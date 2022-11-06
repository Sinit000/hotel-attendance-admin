import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/bloc/counter_event.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/bloc/counter_state.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/model/counter_model.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/screen/counter_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

import '../../../appLocalizations.dart';

class EditCounter extends StatefulWidget {
  final CounterModel counterModel;
  const EditCounter({required this.counterModel});

  @override
  State<EditCounter> createState() => _EditCounterState();
}

class _EditCounterState extends State<EditCounter> {
  final TextEditingController _otCtrl = TextEditingController();
  final TextEditingController _phCtrl = TextEditingController();
  final TextEditingController _marriageCtrl = TextEditingController();
  final TextEditingController _penernityCtrl = TextEditingController();
  final TextEditingController _funeralCtrl = TextEditingController();
  final TextEditingController _meternityCtrl = TextEditingController();
  final TextEditingController _hospitalCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    widget.counterModel.ot == null || widget.counterModel.ot == "null"
        ? _otCtrl.text = ""
        : _otCtrl.text = widget.counterModel.ot!;
    widget.counterModel.ph == null || widget.counterModel.ph == "null"
        ? _phCtrl.text = ""
        : _phCtrl.text = widget.counterModel.ph!;

    widget.counterModel.marriageLeave == null ||
            widget.counterModel.marriageLeave == "null"
        ? _marriageCtrl.text = ""
        : _marriageCtrl.text = widget.counterModel.marriageLeave!;

    widget.counterModel.hospitalLeave == null ||
            widget.counterModel.hospitalLeave == "null"
        ? _hospitalCtrl.text = ""
        : _hospitalCtrl.text = widget.counterModel.hospitalLeave!;
    widget.counterModel.peternityLeave == null ||
            widget.counterModel.peternityLeave == "null"
        ? _penernityCtrl.text = ""
        : _penernityCtrl.text = widget.counterModel.peternityLeave!;
    widget.counterModel.funeralLeave == null ||
            widget.counterModel.funeralLeave == "null"
        ? _funeralCtrl.text = ""
        : _funeralCtrl.text = widget.counterModel.funeralLeave!;
    widget.counterModel.maternityLeave == null ||
            widget.counterModel.maternityLeave == "null"
        ? _meternityCtrl.text = ""
        : _meternityCtrl.text = widget.counterModel.maternityLeave!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("edit_counter")!}"),
      body: BlocListener(
        bloc: counterBloc,
        listener: (context, state) {
          if (state is AddingCounter) {
            EasyLoading.show(status: 'loading...');
          }
          if (state is ErrorFetchingCounter) {
            EasyLoading.dismiss();
            errorSnackBar(text: state.error.toString(), context: context);
          }
          if (state is AddedCounter) {
            EasyLoading.dismiss();
            EasyLoading.showToast("Success");
            Navigator.pop(context);
            print("success");
          }
        },
        child: ListView(
          children: [
            Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _otCtrl,
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            // isDense: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            labelText:
                                "${AppLocalizations.of(context)!.translate("total_ot")!}"),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _phCtrl,
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            // isDense: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            labelText:
                                "${AppLocalizations.of(context)!.translate("ph")!}"),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _hospitalCtrl,
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            // isDense: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            labelText:
                                "${AppLocalizations.of(context)!.translate("h_leave")!}"),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _marriageCtrl,
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            // isDense: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            labelText:
                                "${AppLocalizations.of(context)!.translate("m_leave")!}"),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _penernityCtrl,
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            // isDense: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            labelText:
                                "${AppLocalizations.of(context)!.translate("p_leave")!}"),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _funeralCtrl,
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            // isDense: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            labelText:
                                "${AppLocalizations.of(context)!.translate("f_leave")!}"),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _meternityCtrl,
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            // isDense: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            labelText:
                                "${AppLocalizations.of(context)!.translate("kon_leave")!}"),
                      ),
                      SizedBox(height: 15),
                      standardBtn(
                          title:
                              "${AppLocalizations.of(context)!.translate("update")!}",
                          onTap: () {
                            if (_formKey!.currentState!.validate()) {
                              counterBloc.add(UpdateCounterStarted(
                                  id: widget.counterModel.id!,
                                  userId: widget.counterModel.userId!,
                                  ot: _otCtrl.text,
                                  ph: _phCtrl.text,
                                  funeralLeave: _funeralCtrl.text,
                                  peternityLeave: _penernityCtrl.text,
                                  hospitalLeave: _hospitalCtrl.text,
                                  marriageLeave: _marriageCtrl.text,
                                  maternityLeave: _meternityCtrl.text));
                            }
                          })
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
