import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/model/leave_type_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

import 'leave_type_page.dart';
import 'widget/leave_type_instruction.dart';

class EditLeaveType extends StatefulWidget {
  final LeaveTypeModel leaveTypeModel;
  const EditLeaveType({required this.leaveTypeModel});

  @override
  State<EditLeaveType> createState() => _EditLeaveTypeState();
}

class _EditLeaveTypeState extends State<EditLeaveType> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  final TextEditingController _scopeCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameCtrl.text = widget.leaveTypeModel.name;
    widget.leaveTypeModel.scope == null
        ? _scopeCtrl.text = ""
        : _scopeCtrl.text = widget.leaveTypeModel.scope!;
    widget.leaveTypeModel.note == null || widget.leaveTypeModel.note == ""
        ? _noteCtrl.text = ""
        : _noteCtrl.text = widget.leaveTypeModel.note!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Edit Leavetype"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: leaveTypeBloc,
          listener: (context, state) {
            if (state is AddingLeaveType) {
              EasyLoading.show(status: "loading....");
            }
            if (state is ErrorAddingLeaveType) {
              Navigator.pop(context);
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedLeaveType) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess("Sucess");
              Navigator.pop(context);
            }
          },
          child: ListView(
            children: [
              LeaveTypeInstruction(),
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
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              borderSide: new BorderSide(
                                width: 1,
                              ),
                            ),
                            isDense: true,
                            labelText: "Leavetype name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Leavetype name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _scopeCtrl,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              borderSide: new BorderSide(
                                width: 1,
                              ),
                            ),
                            isDense: true,
                            labelText: "Scope "),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Scope is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _noteCtrl,
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              borderSide: new BorderSide(
                                width: 1,
                              ),
                            ),
                            isDense: true,
                            labelText: "Notes"),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Leavetype name';
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 4),
                      standardBtn(
                          title: "Submit",
                          onTap: () {
                            if (_formKey!.currentState!.validate()) {
                              leaveTypeBloc.add(UpdateLeaveTypeStarted(
                                  id: widget.leaveTypeModel.id,
                                  name: _nameCtrl.text,
                                  note: _noteCtrl.text));
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
