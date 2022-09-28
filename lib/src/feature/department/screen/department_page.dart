import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/delete_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../appLocalizations.dart';

DepartmentBlc departmentBlc = DepartmentBlc();

class DepartmentPage extends StatefulWidget {
  const DepartmentPage({Key? key}) : super(key: key);

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("department")!}"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: DepartmentBody()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addDepartment);
            }),
      ),
    );
  }
}

class DepartmentBody extends StatefulWidget {
  const DepartmentBody({Key? key}) : super(key: key);

  @override
  State<DepartmentBody> createState() => _DepartmentBodyState();
}

class _DepartmentBodyState extends State<DepartmentBody> {
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    super.initState();

    departmentBlc.add(InitializeDepartmentStarted(isRefresh: false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: departmentBlc,
      listener: (context, state) {
        if (state is FetchedDepartment) {
          _refreshController.loadComplete();
          _refreshController.refreshCompleted();
        }
        if (state is EndOfDepartmentList) {
          _refreshController.loadNoData();
        }
        if (state is AddingDepartment) {
          EasyLoading.show(status: "loading....");
        } else if (state is ErrorAddingDepartment) {
          EasyLoading.dismiss();
          errorSnackBar(text: state.error.toString(), context: context);
        } else if (state is AddedDepartment) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Sucess");
        }
      },
      builder: (context, state) {
        if (state is InitializingDepartment) {
          return Center(
            // child: CircularProgressIndicator(),
            child: Lottie.asset('assets/animation/loader.json',
                width: 200, height: 200),
          );
        } else if (state is ErrorFetchingDepartment) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else {
          if (departmentBlc.departmentList.length == 0) {
            return Center(
              child: Text("No Data"),
            );
          }
          print("length ${departmentBlc.departmentList.length}");

          return SmartRefresher(
            onRefresh: () {
              departmentBlc.add(InitializeDepartmentStarted(isRefresh: true));
            },
            onLoading: () {
              departmentBlc.add(FetchDepartmentStarted());
            },
            enablePullDown: true,
            enablePullUp: true,
            cacheExtent: 1,
            controller: _refreshController,
            child: ListView.builder(
                itemCount: departmentBlc.departmentList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.5),
                      //     spreadRadius: 0,
                      //     blurRadius: 3,
                      //     offset: Offset(0, 0), // changes position of shadow
                      //   ),
                      // ],
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
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Text(
                                "${departmentBlc.departmentList[index].name}",
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
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              departmentBlc.departmentList[index].managerName ==
                                      null
                                  ? Text("")
                                  : Text(
                                      "${departmentBlc.departmentList[index].managerName}",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    )
                            ],
                          ),
                          // Row(
                          //   // mainAxisAlignment:
                          //   //     MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.only(right: 10),
                          //       child: Text(
                          //         "${AppLocalizations.of(context)!.translate("workday")!} :",
                          //         style: TextStyle(color: Colors.black),
                          //       ),
                          //     ),
                          //     departmentBlc.departmentList[index]
                          //                 .workingDayModel ==
                          //             null
                          //         ? Text("")
                          //         : Text(
                          //             "${departmentBlc.departmentList[index].workingDayModel!.name}",
                          //             style: TextStyle(
                          //               color: Colors.green,
                          //             ),
                          //           )
                          //   ],
                          // ),
                          Row(
                            // mainAxisAlignment:
                            //     MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  "${AppLocalizations.of(context)!.translate("location")!} :",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Text(
                                "${departmentBlc.departmentList[index].locationModel!.name}",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              )
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
                                    Navigator.pushNamed(context, editDepartment,
                                        arguments: departmentBlc
                                            .departmentList[index]);
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
                                          print(
                                              "id ${departmentBlc.departmentList[index].id}");
                                          departmentBlc.add(
                                              DeleteDepartmentStarted(
                                                  id: departmentBlc
                                                      .departmentList[index]
                                                      .id));
                                        });
                                  }),
                            ],
                          )
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
}
