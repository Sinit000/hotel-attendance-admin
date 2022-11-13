import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/model/leave_type_model.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/screen/leavetype.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

import '../../../appLocalizations.dart';
import 'leave_type_page.dart';
import 'widget/leave_type_instruction.dart';

class AddLeaveType extends StatefulWidget {
  const AddLeaveType({Key? key}) : super(key: key);

  @override
  State<AddLeaveType> createState() => _AddLeaveTypeState();
}

class _AddLeaveTypeState extends State<AddLeaveType> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  final TextEditingController _scopeCtrl = TextEditingController();
  final TextEditingController _perentCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  LeaveTypeBloc _leaveTypeBloc = LeaveTypeBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("add_leave_type")!}"),
      body: Builder(builder: (context) {
        return BlocListener(
            bloc: typeBloc,
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
            child: BlocListener(
              bloc: _leaveTypeBloc,
              listener: (context, state) {
                if (state is FetchingLeaveType) {
                  EasyLoading.show(status: "loading....");
                }
                if (state is ErrorFetchingLeaveType) {
                  EasyLoading.dismiss();
                  errorSnackBar(text: state.error.toString(), context: context);
                }
                if (state is FetchedLeaveType) {
                  EasyLoading.dismiss();
                  if (_leaveTypeBloc.leavetype.length != 0) {
                    customModal(context,
                        _leaveTypeBloc.leavetype.map((e) => e.name).toList(),
                        (value) {
                      _perentCtrl.text = value;
                    });
                  }
                }
              },
              child: ListView(
                children: [
                  // LeaveTypeInstruction(),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                                labelText:
                                    "${AppLocalizations.of(context)!.translate("name")!}"),
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
                            keyboardType: TextInputType.number,
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
                                labelText:
                                    "${AppLocalizations.of(context)!.translate("duration")!}"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Duration is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: _perentCtrl,
                            keyboardType: TextInputType.number,
                            onTap: () {
                              _leaveTypeBloc.add(FetchAllLeaveTypeStarted());
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.arrow_drop_down),
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
                                labelText:
                                    "${AppLocalizations.of(context)!.translate("parent_id")!}"),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: _noteCtrl,
                            maxLines: null,
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
                                labelText:
                                    "${AppLocalizations.of(context)!.translate("notes")!}"),
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Leavetype name';
                            //   }
                            //   return null;
                            // },
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 4),
                          standardBtn(
                              title:
                                  "${AppLocalizations.of(context)!.translate("submit")!}",
                              onTap: () {
                                if (_formKey!.currentState!.validate()) {
                                  String parentId = "0";
                                  if (_perentCtrl.text != "") {
                                    LeaveTypeModel leavetype =
                                        _leaveTypeBloc.leavetype.firstWhere(
                                            (e) => e.name == _perentCtrl.text);
                                    parentId = leavetype.id;
                                  }
                                  typeBloc.add(AddLeaveTypeStarted(
                                      duration: _scopeCtrl.text,
                                      parentId: parentId,
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
            ));
      }),
    );
  }
}
