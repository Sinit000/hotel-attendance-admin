import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';

import 'package:hotle_attendnce_admin/src/feature/structuretype/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/structuretype/model/structuretype_model.dart';
import 'package:hotle_attendnce_admin/src/feature/structuretype/screen/add_structuretype.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/delete_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../appLocalizations.dart';

StructuretypeBloc structuretypeBloc = StructuretypeBloc();

class StructuretypePage extends StatelessWidget {
  const StructuretypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("structure_type")!}"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddorEditStructuretype(isAdd: "true")));
              // Navigator.pushNamed(context, addStructuretype);
            }),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    structuretypeBloc.add(InitailizeStructuretypeStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: structuretypeBloc,
      listener: (context, state) {
        if (state is FetchedStructuretype) {
          _refreshController.loadComplete();
          _refreshController.refreshCompleted();
        }
        if (state is EndofStructuretypeList) {
          _refreshController.loadNoData();
        }
        if (state is AddingStructuretype) {
          EasyLoading.show(status: "loading....");
        } else if (state is ErrorAddingStructuretype) {
          EasyLoading.dismiss();
          errorSnackBar(text: state.error.toString(), context: context);
        } else if (state is AddedStructuretype) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Sucess");
        }
      },
      builder: (context, state) {
        if (state is InitailizingStructuretype) {
          return Center(
            child: Lottie.asset('assets/animation/loader.json',
                width: 200, height: 200),
          );
        } else if (state is ErrorFetchingStructuretype) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else {
          if (structuretypeBloc.typeList.length == 0) {
            return Center(
              child: Text(
                  "${AppLocalizations.of(context)!.translate("no_data")!}"),
            );
          }
          print("length ${structuretypeBloc.typeList.length}");
          return SmartRefresher(
            onRefresh: () {
              structuretypeBloc.add(InitailizeStructuretypeStarted());
            },
            onLoading: () {
              structuretypeBloc.add(FetchStructuretypeStarted());
              _refreshController.loadComplete();
            },
            enablePullDown: true,
            enablePullUp: true,
            cacheExtent: 1,
            controller: _refreshController,
            child: ListView.builder(
                itemCount: structuretypeBloc.typeList.length,
                itemBuilder: (ct, index) {
                  return Slidable(
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            // flex: 2,
                            onPressed: ((con) {
                              print(structuretypeBloc.typeList[index].name);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddorEditStructuretype(
                                            isAdd: "false",
                                            structuretypeModel:
                                                structuretypeBloc
                                                    .typeList[index],
                                          )));
                            }),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            icon: Icons.edit_outlined,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: ((con) {
                              //
                              deleteDialog(
                                  context: context,
                                  onPress: () {
                                    Navigator.pop(context);
                                    structuretypeBloc.add(
                                        DeleteStructuretypeStarted(
                                            id: structuretypeBloc
                                                .typeList[index].id));
                                  });
                            }),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete_outlined,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: _buildItem(
                          context, structuretypeBloc.typeList[index]));
                  // return _buildItem(context, structuretypeBloc.typeList[index]);
                }),
          );
        }
      },
    );
  }

  _buildItem(BuildContext context, StructuretypeModel structureModel) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 5, bottom: 5.0, left: 5, right: 5),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${structureModel.name}",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            )
            // Row(
            //   // mainAxisAlignment:
            //   //     MainAxisAlignment.spaceBetween,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(right: 10),
            //       child: Text(
            //         "${AppLocalizations.of(context)!.translate("name")!} :",
            //         style: TextStyle(color: Colors.black),
            //       ),
            //     ),
            //     Text(
            //       "${structureModel.name}",
            //       style: TextStyle(
            //         color: Colors.red,
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
