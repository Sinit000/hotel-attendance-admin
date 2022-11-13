import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/position/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/position/model/position_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/delete_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../appLocalizations.dart';
import 'edit_position.dart';

PositionBlc positionBlc = PositionBlc();

class PositionPage extends StatefulWidget {
  const PositionPage({Key? key}) : super(key: key);

  @override
  State<PositionPage> createState() => _PositionPageState();
}

class _PositionPageState extends State<PositionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("position")!}"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: PositionBody()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addPosition);
            }),
      ),
    );
  }
}

class PositionBody extends StatefulWidget {
  const PositionBody({Key? key}) : super(key: key);

  @override
  State<PositionBody> createState() => _PositionBodyState();
}

class _PositionBodyState extends State<PositionBody> {
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    positionBlc.add(InitializePositionStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: positionBlc,
      listener: (context, state) {
        if (state is FetchedPosition) {
          _refreshController.loadComplete();
          _refreshController.refreshCompleted();
        }
        if (state is EndOfPositionList) {
          _refreshController.loadNoData();
        }
        if (state is AddingPosition) {
          EasyLoading.show(status: "loading....");
        } else if (state is ErrorAddingPosition) {
          EasyLoading.dismiss();
          errorSnackBar(text: state.error.toString(), context: context);
        } else if (state is AddedPosition) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Sucess");
        }
      },
      builder: (context, state) {
        if (state is InitializingPosition) {
          return Center(
            child: Lottie.asset('assets/animation/loader.json',
                width: 200, height: 200),
          );
        } else if (state is ErrorFetchingPosition) {
          return Center(
            child: TextButton(
                onPressed: () {
                  positionBlc.add(RefreshPositionStarted());
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.teal,
                  onSurface: Colors.grey,
                ),
                child: Text(
                    "${AppLocalizations.of(context)!.translate("retry")!}")),
          );
        } else {
          if (positionBlc.positionList.length == 0) {
            return Center(
              child: Text(
                  "${AppLocalizations.of(context)!.translate("no_data")!}"),
            );
          }
          print("length ${positionBlc.positionList.length}");
          return SmartRefresher(
            onRefresh: () {
              positionBlc.add(RefreshPositionStarted());
            },
            onLoading: () {
              positionBlc.add(FetchPositionStarted());
              _refreshController.loadComplete();
            },
            enablePullDown: true,
            enablePullUp: true,
            cacheExtent: 1,
            controller: _refreshController,
            child: _buildList(positionBlc.positionList),
          );
        }
      },
    );
  }

  _buildList(List<PositionModel> positionList) {
    return ListView.builder(
        itemCount: positionList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.grey.withOpacity(0.2)),
              // borderRadius: BorderRadius.circular(6.0),
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
                        "${positionBlc.positionList[index].positionName}",
                        style: TextStyle(
                          color: Colors.red,
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
                          "${AppLocalizations.of(context)!.translate("type")!} :",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Text(
                        "${positionBlc.positionList[index].type}",
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (con) => EditPosition(
                                          positionModel:
                                              positionBlc.positionList[index],
                                        )));
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
                                      "id ${positionBlc.positionList[index].id}");
                                  positionBlc.add(DeletePositionStarted(
                                      id: positionBlc.positionList[index].id));
                                });
                          }),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
