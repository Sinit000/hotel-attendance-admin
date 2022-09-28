import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/contract/bloc/contract_event.dart';
import 'package:hotle_attendnce_admin/src/feature/contract/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/contract/model/contract_model.dart';
import 'package:hotle_attendnce_admin/src/feature/contract/screen/contract_page.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/structure/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/structure/model/structure_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';
import '../../../appLocalizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class EditContract extends StatefulWidget {
  final ContractModel contractModel;
  const EditContract({required this.contractModel});

  @override
  State<EditContract> createState() => _EditContractState();
}

class _EditContractState extends State<EditContract> {
  StructureBloc _structureBloc = StructureBloc();
  EmployeeBloc _employeeBloc = EmployeeBloc();
  final TextEditingController _refCtrl = TextEditingController();
  final TextEditingController _userIdCtrl = TextEditingController();
  final TextEditingController _strucuteCtrl = TextEditingController();
  final TextEditingController _startCtrl = TextEditingController();
  final TextEditingController _endCtrl = TextEditingController();
  final TextEditingController _workCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? dateToday;
  String id = "";
  @override
  void initState() {
    _refCtrl.text = widget.contractModel.refCode!;
    _userIdCtrl.text = widget.contractModel.userModel!.name;
    _strucuteCtrl.text = widget.contractModel.structureModel!.name!;
    _startCtrl.text = widget.contractModel.startDate!;
    _endCtrl.text = widget.contractModel.endDate!;
    _workCtrl.text = widget.contractModel.workingSchedule!;

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    dateToday = formattedDate.toString();
    super.initState();
  }

  _dialogDate({required TextEditingController controller}) async {
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
    print(widget.contractModel.id);
    return Scaffold(
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("edit_contract")!}"),
      body: Builder(builder: (context) {
        return BlocListener(
            bloc: contractBloc,
            listener: (context, state) {
              if (state is AddingContract) {
                EasyLoading.show(status: "loading....");
              }
              if (state is ErrorAddingContract) {
                EasyLoading.dismiss();

                errorSnackBar(text: state.error.toString(), context: context);
              }
              if (state is AddedContract) {
                EasyLoading.dismiss();
                EasyLoading.showSuccess("Success");
                Navigator.pop(context);
              }
            },
            child: BlocListener(
                bloc: _employeeBloc,
                listener: (context, state) {
                  if (state is FetchingEmployee) {
                    EasyLoading.show(status: "loading...");
                  }
                  if (state is ErrorFetchingEmployee) {
                    EasyLoading.dismiss();
                    errorSnackBar(text: state.toString(), context: context);
                  }
                  if (state is FetchedEmployee) {
                    EasyLoading.dismiss();

                    customModal(
                        context,
                        _employeeBloc.emploList
                            .map((e) => "${e.name}")
                            .toList(), (value) {
                      _userIdCtrl.text = value;
                    });
                  }
                },
                child: BlocListener(
                  bloc: _structureBloc,
                  listener: (context, state) {
                    if (state is FetchingStructure) {
                      EasyLoading.show(status: "loading...");
                    }
                    if (state is ErrorFetchingStructure) {
                      EasyLoading.dismiss();
                      errorSnackBar(text: state.toString(), context: context);
                    }
                    if (state is FetchedStructure) {
                      EasyLoading.dismiss();

                      customModal(
                          context,
                          _structureBloc.structure
                              .map((e) => "${e.name}")
                              .toList(), (value) {
                        _strucuteCtrl.text = value;
                      });
                    }
                  },
                  child: ListView(
                    children: [
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            children: [
                              SizedBox(height: 15),
                              TextFormField(
                                controller: _refCtrl,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  // suffixIcon: Icon(Icons.arrow_drop_down),
                                  contentPadding: const EdgeInsets.only(
                                    left: 14.0,
                                  ),
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.grey.shade400)),
                                  labelText:
                                      "${AppLocalizations.of(context)!.translate("ref_code")!}",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Ref code is required.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: _userIdCtrl,
                                onTap: () {
                                  _employeeBloc.add(FetchAllEmployeeStarted());
                                },
                                readOnly: true,
                                // keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.arrow_drop_down),
                                    contentPadding: const EdgeInsets.only(
                                      left: 14.0,
                                    ),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.grey.shade400)),
                                    labelText:
                                        "${AppLocalizations.of(context)!.translate("employee")!}"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Employee is required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: _strucuteCtrl,
                                onTap: () {
                                  _structureBloc
                                      .add(FetchAllStructureStarted());
                                },
                                readOnly: true,
                                // keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.arrow_drop_down),
                                    contentPadding: const EdgeInsets.only(
                                      left: 14.0,
                                    ),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.grey.shade400)),
                                    labelText:
                                        "${AppLocalizations.of(context)!.translate("structure")!}"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Structure is required.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: _startCtrl,
                                readOnly: true,
                                onTap: () {
                                  _dialogDate(controller: _startCtrl);
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.lightBlue,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                      left: 14.0,
                                    ),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.grey.shade400)),
                                    labelText:
                                        "${AppLocalizations.of(context)!.translate("start_date")!}"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Start date is required.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: _startCtrl,
                                readOnly: true,
                                onTap: () {
                                  _dialogDate(controller: _endCtrl);
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.lightBlue,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                      left: 14.0,
                                    ),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.grey.shade400)),
                                    labelText:
                                        "${AppLocalizations.of(context)!.translate("end_date")!}"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'End date is required.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: _workCtrl,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  // suffixIcon: Icon(Icons.arrow_drop_down),
                                  contentPadding: const EdgeInsets.only(
                                    left: 14.0,
                                  ),
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.grey.shade400)),
                                  labelText:
                                      "${AppLocalizations.of(context)!.translate("working_schedule")!}",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Working schedule is required.';
                                  }
                                  return null;
                                },
                              ),
                              // SizedBox(height: 15),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 4),
                              standardBtn(
                                  title:
                                      "${AppLocalizations.of(context)!.translate("update")!}",
                                  onTap: () {
                                    if (_formKey!.currentState!.validate()) {
                                      String userId = "";
                                      String structureId = "";
                                      if (widget
                                              .contractModel.userModel!.name !=
                                          _userIdCtrl.text) {
                                        EmployeeModel employeeModel =
                                            _employeeBloc.emploList.firstWhere(
                                                (e) =>
                                                    "${e.name}" ==
                                                    _userIdCtrl.text);

                                        userId = employeeModel.id;
                                      } else {
                                        userId = widget.contractModel.userId!;
                                      }
                                      if (widget.contractModel.structureModel!
                                              .name !=
                                          _strucuteCtrl.text) {
                                        StructureModel structureModel =
                                            _structureBloc.structure.firstWhere(
                                                (e) =>
                                                    "${e.name}" ==
                                                    _strucuteCtrl.text);
                                        structureId = structureModel.id;
                                      } else {
                                        structureId =
                                            widget.contractModel.structureId!;
                                      }

                                      contractBloc.add(UpdateContractStarted(
                                          id: widget.contractModel.id,
                                          userId: userId,
                                          structureId: structureId,
                                          startedDate: _startCtrl.text,
                                          endDate: _endCtrl.text,
                                          workingSchedule: _workCtrl.text,
                                          refCode: _refCtrl.text));
                                    }
                                  })
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )));
      }),
    );
  }

  @override
  void dispose() {
    _structureBloc.close();
    _employeeBloc.close();
    super.dispose();
  }
}
