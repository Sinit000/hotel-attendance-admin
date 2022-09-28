import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/screen/timetable_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';
import 'package:intl/intl.dart';

import '../../../appLocalizations.dart';
import 'widget/time_instruction.dart';

class EditTimetable extends StatefulWidget {
  final TimetableModel timetableModel;
  const EditTimetable({required this.timetableModel});

  @override
  State<EditTimetable> createState() => _EditTimetableState();
}

class _EditTimetableState extends State<EditTimetable> {
  final TextEditingController _reasonCtrl = TextEditingController();
  final TextEditingController _ondutyCtrl = TextEditingController();
  final TextEditingController _ofDutyCtrl = TextEditingController();
  final TextEditingController _lateMnCtrl = TextEditingController();
  final TextEditingController _earlyMnCtrl = TextEditingController();
  //  final TextEditingController _reasonCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  void initState() {
    _reasonCtrl.text = widget.timetableModel.timetableName;
    _ondutyCtrl.text = widget.timetableModel.onDutyTtime;
    _ofDutyCtrl.text = widget.timetableModel.offDutyTime;
    widget.timetableModel.lateMn == null
        ? _lateMnCtrl.text = "0"
        : _lateMnCtrl.text = widget.timetableModel.lateMn!;
    widget.timetableModel.earlyMn == null
        ? _earlyMnCtrl.text = "0"
        : _earlyMnCtrl.text = widget.timetableModel.earlyMn!;
    super.initState();
  }

  _dialogTime({required TextEditingController controller}) async {
    showTimePicker(
      context: context,
      initialTime: selectedTime,
    ).then((value) {
      print(value);
      if (value == null) {
        print("no selt");
      } else {
        setState(() {
          selectedTime = value;
          DateTime parsedTime =
              DateFormat.jm().parse(selectedTime.format(context).toString());
          final String time = DateFormat('HH:mm:ss').format(parsedTime);
          print("out put time $time");

          controller.text = time;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("add_timetable")!}"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: timetableBloc,
          listener: (context, state) {
            if (state is AddingTimetable) {
              EasyLoading.show(status: "loading....");
            }
            if (state is ErrorAddingTimetable) {
              EasyLoading.dismiss();
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedTimetable) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess("Sucess");
              Navigator.pop(context);
            }
          },
          child: ListView(
            children: [
              TimeInstruction(),
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _reasonCtrl,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            labelText:
                                "${AppLocalizations.of(context)!.translate("name")!}"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Timetable is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _ondutyCtrl,
                        readOnly: true,
                        onTap: () {
                          _dialogTime(controller: _ondutyCtrl);
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.timer_sharp,
                              color: Colors.blue,
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            labelText:
                                "${AppLocalizations.of(context)!.translate("time_in")!}"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Time in is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _ofDutyCtrl,
                        keyboardType: TextInputType.text,
                        readOnly: true,
                        onTap: () {
                          _dialogTime(controller: _ofDutyCtrl);
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.timer_sharp,
                              color: Colors.blue,
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            labelText:
                                "${AppLocalizations.of(context)!.translate("time_out")!}"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Time out required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _lateMnCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            labelText:
                                "${AppLocalizations.of(context)!.translate("late_minute")!}"),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _earlyMnCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            labelText:
                                "${AppLocalizations.of(context)!.translate("early_leave")!}"),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 4),
                      standardBtn(
                          title:
                              "${AppLocalizations.of(context)!.translate("update")!}",
                          onTap: () {
                            if (_formKey!.currentState!.validate()) {
                              timetableBloc.add(UpdateTimetableStarted(
                                  id: widget.timetableModel.id,
                                  name: _reasonCtrl.text,
                                  offDuty: _ofDutyCtrl.text,
                                  onDuty: _ondutyCtrl.text,
                                  lateMn: _lateMnCtrl.text,
                                  earlyMn: _earlyMnCtrl.text));
                            }
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
