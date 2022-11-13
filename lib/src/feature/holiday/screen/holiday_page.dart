import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/model/holiday_model.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/screen/edit_holiday.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/delete_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../appLocalizations.dart';

HolidayBloc holidayBloc = HolidayBloc();

class HolidayPage extends StatelessWidget {
  const HolidayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("holiday")!}"),
      body: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Body(),
      ),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addHoliday);
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

    holidayBloc.add(InitializeHolidayStarted(isRefresh: false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: holidayBloc,
      listener: (context, state) {
        if (state is FetchedHoliday) {
          _refreshController.loadComplete();
          _refreshController.refreshCompleted();
        }
        if (state is EndOfHolidayList) {
          _refreshController.loadNoData();
        }
        if (state is AddingHoliday) {
          EasyLoading.show(status: "loading....");
        }
        if (state is ErrorAddingHoliday) {
          EasyLoading.dismiss();
          errorSnackBar(text: state.error.toString(), context: context);
        }
        if (state is AddedHoliday) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Sucess");
        }
      },
      builder: (context, state) {
        if (state is InitializingHoliday) {
          return Center(
            child: Lottie.asset('assets/animation/loader.json',
                width: 200, height: 200),
          );
        } else if (state is ErrorFetchingHoliday) {
         return Center(
              child: TextButton(
                  onPressed: () {
                    holidayBloc.add(InitializeHolidayStarted(isRefresh: false));
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
          if (holidayBloc.holidaylist.length == 0) {
            return Center(
              child: Text(
                  "${AppLocalizations.of(context)!.translate("no_data")!}"),
            );
          }
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            cacheExtent: 1,
            controller: _refreshController,
            onRefresh: () {
              // holidayBloc.add(RefreshHolidayStarted());
              holidayBloc.add(InitializeHolidayStarted(isRefresh: true));
            },
            onLoading: () {
              holidayBloc.add(FetchHolidayStarted());
            },
            child: ListView.builder(
                itemCount: holidayBloc.holidaylist.length,
                itemBuilder: (context, index) {
                  return _buildListItem(holidayBloc.holidaylist[index]);
                }),
          );
        }
      },
    );
  }

  _buildListItem(HolidayModel holidayModel) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
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
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment:
              //     MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    "${AppLocalizations.of(context)!.translate("name")!} :",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Flexible(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${holidayModel.name}",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        )
                      ]),
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
                    "${AppLocalizations.of(context)!.translate("notes")!} :",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Row(
                  children: [
                    holidayModel.notes == null || holidayModel.notes == "null"
                        ? Text("")
                        : Text(
                            "${holidayModel.notes} ",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                    // Text("- "),
                    // Text(
                    //   " ${BlocProvider.of<WantedBloc>(context).wantedList[index].maxPrice}",
                    //   style: TextStyle(
                    //       color: Colors.red,
                    //       fontWeight: FontWeight.bold),
                    // ),
                  ],
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
                    "${AppLocalizations.of(context)!.translate("from_date")!} :",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Text(
                  "${holidayModel.fromDate} ${AppLocalizations.of(context)!.translate("to")!} ${holidayModel.toDate}",
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
                    "${AppLocalizations.of(context)!.translate("duration")!} :",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                holidayModel.duration != "1"
                    ? Text(
                        "${holidayModel.duration} days",
                      )
                    : Text(
                        "${holidayModel.duration} day",
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
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Text(
                  "${holidayModel.status}",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                holidayModel.status == "pending"
                    ? CupertinoButton(
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
                                  builder: (con) =>
                                      EditHoliday(holidayModel: holidayModel)));
                        })
                    : Container(),
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
                            print("id ${holidayModel.id}");
                            holidayBloc
                                .add(DeleteHolidayStarted(id: holidayModel.id));
                          });
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
