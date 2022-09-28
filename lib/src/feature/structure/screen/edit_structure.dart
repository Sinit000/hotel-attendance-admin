import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/structure/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/structure/model/structure_model.dart';
import 'package:hotle_attendnce_admin/src/feature/structure/screen/structure_page.dart';
import 'package:hotle_attendnce_admin/src/feature/structuretype/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/structuretype/model/structuretype_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

import '../../../appLocalizations.dart';

class EditStructure extends StatefulWidget {
  final StructureModel structureModel;
  const EditStructure({required this.structureModel});

  @override
  State<EditStructure> createState() => _EditStructureState();
}

class _EditStructureState extends State<EditStructure> {
  StructuretypeBloc _structuretypeBloc = StructuretypeBloc();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _baseSalary = TextEditingController();
  final TextEditingController _allowanceCtrl = TextEditingController();
  final TextEditingController _currencyCtrl = TextEditingController();
  final TextEditingController _typeIdCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  List<String> currency = ["riel", "usd"];
  @override
  void initState() {
    _nameCtrl.text = widget.structureModel.name!;
    widget.structureModel.allowance == null
        ? _allowanceCtrl.text = ""
        : _allowanceCtrl.text = widget.structureModel.allowance!;
    // _currencyCtrl.text = widget.structureModel.currency!;
    _baseSalary.text = widget.structureModel.baseSalary!;

    // _typeIdCtrl.text = widget.structureModel.structuretypeModel!.name!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("edit_structure")!}"),
      body: Builder(builder: (context) {
        return BlocListener(
            bloc: structureBloc,
            listener: (context, state) {
              if (state is AddingStructure) {
                EasyLoading.show(status: "loading....");
              }
              if (state is ErrorAddingStructure) {
                EasyLoading.dismiss();

                errorSnackBar(text: state.error.toString(), context: context);
              }
              if (state is AddedStructure) {
                EasyLoading.dismiss();
                EasyLoading.showSuccess("Success");
                Navigator.pop(context);
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
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                left: 14.0,
                              ),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.grey.shade400)),
                              labelText:
                                  "${AppLocalizations.of(context)!.translate("name")!}"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        // TextFormField(
                        //   controller: _typeIdCtrl,
                        //   onTap: () {
                        //     _structuretypeBloc
                        //         .add(FetchAllStructuretypeStarted());
                        //   },
                        //   readOnly: true,
                        //   // keyboardType: TextInputType.text,
                        //   decoration: InputDecoration(
                        //       suffixIcon: Icon(Icons.arrow_drop_down),
                        //       contentPadding: const EdgeInsets.only(
                        //         left: 14.0,
                        //       ),
                        //       fillColor: Colors.grey.shade100,
                        //       filled: true,
                        //       focusedBorder: OutlineInputBorder(
                        //           borderSide: new BorderSide(
                        //               color: Colors.grey.shade400)),
                        //       labelText:
                        //           "${AppLocalizations.of(context)!.translate("structure_type")!}"),
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Structure type is required.';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // SizedBox(height: 15),
                        TextFormField(
                          controller: _baseSalary,

                          // readOnly: true,
                          keyboardType: TextInputType.number,
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
                                  "${AppLocalizations.of(context)!.translate("base_salary")!}"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Base Salary is required.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _allowanceCtrl,
                          keyboardType: TextInputType.number,
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
                                "${AppLocalizations.of(context)!.translate("allowance")!}",
                          ),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Base Salary is required.';
                          //   }
                          //   return null;
                          // },
                        ),
                        // SizedBox(height: 15),
                        // TextFormField(
                        //   controller: _currencyCtrl,
                        //   keyboardType: TextInputType.text,
                        //   // maxLines: null,
                        //   readOnly: true,
                        //   onTap: () {
                        //     customModal(context, currency, (value) {
                        //       _currencyCtrl.text = value;
                        //     });
                        //   },
                        //   decoration: InputDecoration(
                        //       suffixIcon: Icon(Icons.arrow_drop_down),
                        //       contentPadding: const EdgeInsets.only(
                        //         left: 14.0,
                        //       ),
                        //       fillColor: Colors.grey.shade100,
                        //       filled: true,
                        //       focusedBorder: OutlineInputBorder(
                        //           borderSide: new BorderSide(
                        //               color: Colors.grey.shade400)),
                        //       labelText:
                        //           "${AppLocalizations.of(context)!.translate("currency")!}"),
                        // ),
                        // SizedBox(height: 15),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 4),
                        standardBtn(
                            title:
                                "${AppLocalizations.of(context)!.translate("update")!}",
                            onTap: () {
                              if (_formKey!.currentState!.validate()) {
                                // String typeId = "";
                                // if (_typeIdCtrl.text !=
                                //     widget.structureModel.structuretypeModel!
                                //         .name) {
                                //   StructuretypeModel mytype =
                                //       _structuretypeBloc.typeList.firstWhere(
                                //           (e) =>
                                //               "${e.name}" ==
                                //               _typeIdCtrl.text);
                                //   typeId = mytype.id;
                                // } else {
                                //   typeId = widget.structureModel.id;
                                // }

                                structureBloc.add(UpdateStructureStarted(
                                  id: widget.structureModel.id,
                                  name: _nameCtrl.text,
                                  baseSalary: _baseSalary.text,
                                  allowance: _allowanceCtrl.text,
                                  // currency: _currencyCtrl.text,
                                  // structuretypeId: typeId
                                ));
                              }
                            })
                      ],
                    ),
                  ),
                )
              ],
            ));
      }),
    );
  }

  @override
  void dispose() {
    _structuretypeBloc.close();

    super.dispose();
  }
}
