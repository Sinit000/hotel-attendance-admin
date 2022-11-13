import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/contract/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/contract/model/contract_model.dart';
import 'package:hotle_attendnce_admin/src/feature/contract/screen/edit_contract.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/delete_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../appLocalizations.dart';

ContractBloc contractBloc = ContractBloc();

class Contractpage extends StatelessWidget {
  const Contractpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("contract")!}"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addContract);
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
    super.initState();

    contractBloc.add(InitailizeContractStarted(isRefresh: false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: contractBloc,
      listener: (context, state) {
        if (state is FetchedContract) {
          _refreshController.loadComplete();
          _refreshController.refreshCompleted();
        }
        if (state is EndofContractList) {
          _refreshController.loadNoData();
        }
        if (state is AddingContract) {
          EasyLoading.show(status: "loading....");
        } else if (state is ErrorAddingContract) {
          EasyLoading.dismiss();
          errorSnackBar(text: state.error.toString(), context: context);
        } else if (state is AddedContract) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Sucess");
        }
      },
      builder: (context, state) {
        if (state is InitailizingContract) {
          return Center(
            child: Lottie.asset('assets/animation/loader.json',
                width: 200, height: 200),
          );
        } else if (state is ErrorFetchingDepartment) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else {
          if (contractBloc.contract.length == 0) {
            return Center(
              child: Text(
                  "${AppLocalizations.of(context)!.translate("no_data")!}"),
            );
          }
          print("length ${contractBloc.contract.length}");

          return SmartRefresher(
            onRefresh: () {
              contractBloc.add(InitailizeContractStarted(isRefresh: true));
            },
            onLoading: () {
              contractBloc.add(FetchContractSarted());
              _refreshController.loadComplete();
            },
            enablePullDown: true,
            enablePullUp: true,
            cacheExtent: 1,
            controller: _refreshController,
            child: ListView.builder(
                itemCount: contractBloc.contract.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
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
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                                "${contractBloc.contract[index].refCode}",
                                style: TextStyle(
                                  color: Colors.green,
                                ),
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
                                  "${AppLocalizations.of(context)!.translate("manager")!} :",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Text(
                                "${contractBloc.contract[index].userModel!.name}",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              )
                            ],
                          ),
                          // SizedBox(
                          //   height: 5.0,
                          // ),
                          // build expandable
                          _buildExpenable(context, contractBloc.contract[index])
                        ],
                      ),
                    ),
                  );
                }),
          );
        }
      },
    );
  }

  _buildExpenable(BuildContext context, ContractModel contractModel) {
    return ExpandableNotifier(
        child: Column(
      children: <Widget>[_expandableItemList(context, contractModel)],
    ));
  }

  _expandableItemList(BuildContext context, ContractModel contractModel) {
    return ScrollOnExpand(
        scrollOnExpand: true,
        scrollOnCollapse: false,
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            tapBodyToCollapse: true,
          ),
          header: Builder(
            builder: (c) {
              var controller = ExpandableController.of(c, required: true)!;
              return Text(
               controller.expanded
                    ? "${AppLocalizations.of(context)!.translate("hide")!}"
                    : "${AppLocalizations.of(context)!.translate("view")!}",
                style: Theme.of(context).textTheme.bodyText1,
              );
            },
          ),
          collapsed: Center(),
          expanded: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("start_date")!} :",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Text(
                    "${contractModel.startDate}",
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("end_date")!} :",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Text(
                    "${contractModel.endDate}",
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("working_schedule")!} :",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Text(
                    "${contractModel.workingSchedule}",
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("status")!} :",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Text(
                    "${contractModel.status}",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                      padding: EdgeInsets.all(1.0),
                      color: Colors.blue,
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditContract(
                                    contractModel: contractModel)));
                        // Navigator.pushNamed(context, editContract,
                        //     arguments: contractModel);
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  CupertinoButton(
                      padding: EdgeInsets.all(1.0),
                      color: Colors.red,
                      child: Row(
                        children: [
                          Icon(Icons.delete),
                        ],
                      ),
                      onPressed: () {
                        deleteDialog(
                            context: context,
                            onPress: () {
                              Navigator.pop(context);
                              contractBloc.add(
                                  DeleteContractStarted(id: contractModel.id));
                            });
                      }),
                ],
              )
            ],
          ),
          builder: (_, collapsed, expanded) {
            return Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Expandable(
                collapsed: collapsed,
                expanded: expanded,
                theme: const ExpandableThemeData(crossFadePoint: 0),
              ),
            );
          },
        ));
  }
}
