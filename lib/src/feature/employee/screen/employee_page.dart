import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/edit_employee.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/employee_detail_page.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/reset_password.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/delete_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

EmployeeBloc employeeBloc = EmployeeBloc();

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // centerTitle: true,
        title: Text(
          "Employee page",
          style:
              TextStyle(color: Colors.white, fontFamily: 'BattambangRegular'),
          textScaleFactor: 1.1,
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResetPassword()));
              },
              child: Icon(Icons.restore)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addEmployee);
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
    employeeBloc.add(InitializeEmployeeStarted());
  }

  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: employeeBloc,
      listener: (context, state) {
        if (state is ErrorFetchingEmployee) {
          Helper.handleState(state: state, context: context);
        }
        if (state is FetchedEmployee) {
          _refreshController.loadComplete();
          _refreshController.refreshCompleted();
        }
        if (state is EndofEmployeeList) {
          _refreshController.loadNoData();
        }
        if (state is AddingEmployee) {
          EasyLoading.show(status: "loading....");
        } else if (state is ErorrAddingEmployee) {
          EasyLoading.dismiss();
          errorSnackBar(text: state.error.toString(), context: context);
          // errorSnackBar(text: state.error.toString(), context: context);
        } else if (state is AddedEmployee) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Sucess");
        }
      },
      builder: (context, state) {
        if (state is InitializingEmployee) {
          return Center(
            // child: CircularProgressIndicator(),
            child: Lottie.asset('assets/animation/loader.json',
                width: 200, height: 200),
          );
        } else if (state is ErrorFetchingEmployee) {
          return Center(
            child: TextButton(
                onPressed: () {
                  employeeBloc.add(InitializeEmployeeStarted());
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.teal,
                  onSurface: Colors.grey,
                ),
                child: Text("Retry")),
          );
        } else {
          if (employeeBloc.emploList.length == 0) {
            return Center(
              child: Text("No Data"),
            );
          }
          return SmartRefresher(
            onRefresh: () {
              employeeBloc.add(RefreshEmployeeStarted());
            },
            onLoading: () {
              employeeBloc.add(FetchEmloyeeStarted());
            },
            enablePullDown: true,
            enablePullUp: true,
            cacheExtent: 1,
            controller: _refreshController,
            child: ListView.builder(
                itemCount: employeeBloc.emploList.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 10),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          // backgroundColor: Colors.blue,
                          padding: EdgeInsets.all(20),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmployeeDetailPage(
                                      id: employeeBloc.emploList[index].id)));
                        },
                        child: Row(
                          children: [
                            employeeBloc.emploList[index].img == null
                                ? Container(
                                    height: 80,
                                    width: 80,
                                    child:
                                        Image.asset("assets/icon/avartar.png"),
                                  )
                                : Container(
                                    height: 80,
                                    width: 80,
                                    // padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.grey[300]),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: "assets/icon/avartar.png",
                                        // imageCacheHeight: 80,
                                        // imageCacheWidth: 80,
                                        image:
                                            "${employeeBloc.emploList[index].img}",
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        employeeBloc.emploList[index].name,
                                        textAlign: TextAlign.right,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      // AspectRatio(aspectRatio: 1)
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  employeeBloc.emploList[index].phone == null
                                      ? Text("")
                                      : Text(
                                          employeeBloc.emploList[index].phone!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                          textAlign: TextAlign.right,
                                        ),
                                  SizedBox(height: 10),
                                  employeeBloc.emploList[index].address == null
                                      ? Text("")
                                      : Text(
                                          employeeBloc
                                              .emploList[index].address!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                          textAlign: TextAlign.right,
                                        ),
                                ],
                              ),
                            ),
                            CupertinoButton(
                                padding: EdgeInsets.all(1.0),
                                color: Colors.blue,
                                child: Row(
                                  children: [
                                    Icon(Icons.edit),
                                  ],
                                ),
                                onPressed: () {
                                  // employeeBloc.add(FetchEmployeeDetailStarted(
                                  //     id: employeeBloc.emploList[index].id));
                                  // Future.delayed(Duration(milliseconds: 5));
                                  // print(employeeBloc
                                  //     .employeeModel!.employeeModel.name);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (con) => EditEmployee(
                                                employeeModel: employeeBloc
                                                    .emploList[index],
                                              )));
                                }),
                            SizedBox(
                              width: 3,
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
                                            "id ${employeeBloc.emploList[index].id}");
                                        employeeBloc.add(DeleteEmployeeStarted(
                                            id: employeeBloc
                                                .emploList[index].id));
                                      });
                                }),
                          ],
                        )),
                  );
                }),
          );
        }
      },
    );
  }
}
