import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/structuretype/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/structuretype/model/structuretype_model.dart';
import 'package:hotle_attendnce_admin/src/feature/structuretype/screen/structuretype_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';

import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

import '../../../appLocalizations.dart';

class AddorEditStructuretype extends StatefulWidget {
  final String isAdd;
  final StructuretypeModel? structuretypeModel;

  AddorEditStructuretype({required this.isAdd, this.structuretypeModel});

  @override
  State<AddorEditStructuretype> createState() => _AddorEditStructuretypeState();
}

class _AddorEditStructuretypeState extends State<AddorEditStructuretype> {
  final TextEditingController _reasonCtrl = TextEditingController();
  final TextEditingController _typeCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.structuretypeModel != null && widget.isAdd == "false") {
      _reasonCtrl.text = widget.structuretypeModel!.name!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.isAdd == "false"
          ? standardAppBar(context,
              "${AppLocalizations.of(context)!.translate("edit_structuretype")!}")
          : standardAppBar(context,
              "${AppLocalizations.of(context)!.translate("add_structuretype")!}"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: structuretypeBloc,
          listener: (context, state) {
            if (state is AddingStructuretype) {
              EasyLoading.show(status: "loading....");
            }
            if (state is ErrorAddingStructuretype) {
              Navigator.pop(context);
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedStructuretype) {
              EasyLoading.dismiss();
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
                            return 'name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 4),
                      widget.isAdd == "false"
                          ? standardBtn(
                              title:
                                  "${AppLocalizations.of(context)!.translate("update")!}",
                              onTap: () {
                                if (_formKey!.currentState!.validate()) {
                                  structuretypeBloc
                                      .add(UpdateStructuretypeStarted(
                                    id: widget.structuretypeModel!.id,
                                    name: _reasonCtrl.text,
                                  ));
                                }
                              })
                          : standardBtn(
                              title:
                                  "${AppLocalizations.of(context)!.translate("submit")!}",
                              onTap: () {
                                if (_formKey!.currentState!.validate()) {
                                  structuretypeBloc.add(AddStructuretypeStarted(
                                    name: _reasonCtrl.text,
                                  ));
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
