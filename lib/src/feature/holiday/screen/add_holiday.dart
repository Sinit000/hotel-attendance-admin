import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/screen/holiday_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';
import 'package:intl/intl.dart';

import '../../../appLocalizations.dart';

class AddHoliday extends StatefulWidget {
  const AddHoliday({Key? key}) : super(key: key);

  @override
  State<AddHoliday> createState() => _AddHolidayState();
}

class _AddHolidayState extends State<AddHoliday> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _fromCtrl = TextEditingController();
  final TextEditingController _toCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();

  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? dateToday;
  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    dateToday = formattedDate.toString();

    super.initState();
  }

  _datePicker({required TextEditingController controller}) {
    return showDatePicker(
      context: context,
      initialDate: dateNow,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 60),
    ).then((value) {
      if (value == null) {
        print("null");
      } else {
        setState(() {
          date = value;
          String formateDate = DateFormat('yyyy/MM/dd').format(date!);
          controller.text = formateDate.toString();
        });
      }
      // after click on date ,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("add_holiday")!}"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: holidayBloc,
          listener: (context, state) {
            if (state is AddingHoliday) {
              EasyLoading.show(status: "loading....");
            }
            if (state is ErrorAddingHoliday) {
              EasyLoading.dismiss();
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedHoliday) {
              EasyLoading.dismiss();
              // EasyLoading.dismiss();
              EasyLoading.showSuccess("Sucess");
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
                        controller: _nameCtrl,
                        keyboardType: TextInputType.text,
                        maxLines: null,
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
                                "${AppLocalizations.of(context)!.translate("name")!} "),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'name is required.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _fromCtrl,
                        readOnly: true,
                        // keyboardType: TextInputType.text,
                        onTap: () {
                          _datePicker(controller: _fromCtrl);
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.date_range_outlined,
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
                                "${AppLocalizations.of(context)!.translate("from_date")!}"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'From date is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _toCtrl,
                        readOnly: true,
                        // keyboardType: TextInputType.text,
                        onTap: () {
                          _datePicker(controller: _toCtrl);
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.date_range_outlined,
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
                                "${AppLocalizations.of(context)!.translate("to_date")!}"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'To Date is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _noteCtrl,
                        maxLines: null,
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
                                "${AppLocalizations.of(context)!.translate("notes")!}"),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 5),
                      standardBtn(
                          title:
                              "${AppLocalizations.of(context)!.translate("submit")!}",
                          onTap: () {
                            if (_formKey!.currentState!.validate()) {
                              print(_toCtrl.text);
                              holidayBloc.add(AddHolidayStarted(
                                  name: _nameCtrl.text,
                                  note: _noteCtrl.text,
                                  fromDate: _fromCtrl.text,
                                  toDate: _toCtrl.text));
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
