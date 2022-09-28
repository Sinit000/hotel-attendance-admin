import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/structure/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/structure/model/structure_model.dart';
import 'package:hotle_attendnce_admin/src/feature/structure/screen/edit_structure.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/delete_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../appLocalizations.dart';

StructureBloc structureBloc = StructureBloc();

class Structurepage extends StatelessWidget {
  const Structurepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("structure")!}"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addStructure);
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
    structureBloc.add(InitailizeStructureStarted(isRefresh: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: structureBloc,
      listener: (context, state) {
        if (state is FetchedStructure) {
          _refreshController.loadComplete();
          _refreshController.refreshCompleted();
        }
        if (state is EndofStructureList) {
          _refreshController.loadNoData();
        }
        if (state is AddingStructure) {
          EasyLoading.show(status: "loading....");
        } else if (state is ErrorAddingStructure) {
          EasyLoading.dismiss();
          errorSnackBar(text: state.error.toString(), context: context);
        } else if (state is AddedStructure) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Sucess");
        }
      },
      builder: (context, state) {
        if (state is InitailizingStructure) {
          return Center(
            child: Lottie.asset('assets/animation/loader.json',
                width: 200, height: 200),
          );
        } else if (state is ErrorFetchingStructure) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else {
          if (structureBloc.structure.length == 0) {
            return Center(
              child: Text(
                  "${AppLocalizations.of(context)!.translate("no_data")!}"),
            );
          }
          print("length ${structureBloc.structure.length}");
          return SmartRefresher(
            onRefresh: () {
              structureBloc.add(InitailizeStructureStarted(isRefresh: true));
            },
            onLoading: () {
              structureBloc.add(FetchStructureStarted());
              _refreshController.loadComplete();
            },
            enablePullDown: true,
            enablePullUp: true,
            cacheExtent: 1,
            controller: _refreshController,
            child: ListView.builder(
                itemCount: structureBloc.structure.length,
                itemBuilder: (context, index) {
                  return Slidable(
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            // flex: 2,
                            onPressed: ((ct) {
                              Navigator.pushNamed(context, editStructure,
                                  arguments: structureBloc.structure[index]);
                            }),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            icon: Icons.edit_outlined,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: ((ct) {
                              //
                              deleteDialog(
                                  context: context,
                                  onPress: () {
                                    Navigator.pop(context);
                                    structureBloc.add(DeleteStructureStarted(
                                        id: structureBloc.structure[index].id));
                                  });
                            }),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete_outlined,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child:
                          _buildItem(context, structureBloc.structure[index]));
                  // return _buildItem(context, structuretypeBloc.typeList[index]);
                }),
          );
        }
      },
    );
  }

  _buildItem(BuildContext context, StructureModel structureModel) {
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
            // Text(
            //   "${structureModel.name}",
            //   style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            // )
            // Row(
            //   // mainAxisAlignment:
            //   //     MainAxisAlignment.spaceBetween,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(right: 10),
            //       child: Text(
            //         "${AppLocalizations.of(context)!.translate("name")!} :",
            //         style: TextStyle(color: Colors.grey),
            //       ),
            //     ),
            //     Text(
            //       "${structureModel.name}",
            //       style:
            //           TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            //     )
            //   ],
            // ),
            Row(
              // mainAxisAlignment:
              //     MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    "${AppLocalizations.of(context)!.translate("name")!} :",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Text(
                  "${structureModel.name}",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              // mainAxisAlignment:
              //     MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    "${AppLocalizations.of(context)!.translate("base_salary")!} :",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Text(
                  "\S${structureModel.baseSalary}",
                  style: TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              // mainAxisAlignment:
              //     MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    "${AppLocalizations.of(context)!.translate("allowance")!} :",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Text(
                  "\$${structureModel.allowance}",
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
