import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/group/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/group/screen/widget/group_item.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

GroupBloc groupBloc = GroupBloc();

class GroupPage extends StatelessWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Group Department"),
      body: Container(
        child: GroupBody(),
      ),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addGroup);
            }),
      ),
    );
  }
}

class GroupBody extends StatefulWidget {
  const GroupBody({Key? key}) : super(key: key);

  @override
  State<GroupBody> createState() => _GroupBodyState();
}

class _GroupBodyState extends State<GroupBody> {
  final RefreshController _refreshController = RefreshController();
  void initState() {
    super.initState();

    groupBloc.add(InitializeGroupStarted());
  }

  @override
  Widget build(BuildContext context) {
    //  BlocProvider.of<WantedBloc>(context).add(FetchWantedStarted());

    return BlocConsumer(
        bloc: groupBloc,
        builder: (context, state) {
          if (state is InitializingGroup) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorFetchingGroup) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            if (groupBloc.departmentList.length == 0) {
              return Center(
                child: Text("No Data"),
              );
            }
            print("length ${groupBloc.departmentList.length}");

            return SmartRefresher(
              onRefresh: () {
                groupBloc.add(RefreshGroupStarted());
              },
              onLoading: () {
                groupBloc.add(FetchGroupStarted());
                _refreshController.loadComplete();
              },
              enablePullDown: true,
              enablePullUp: true,
              cacheExtent: 1,
              controller: _refreshController,
              child: ListView.builder(
                  itemCount: groupBloc.departmentList.length,
                  itemBuilder: (context, index) {
                    return groupItem(
                        context: context,
                        groupModel: groupBloc.departmentList[index]);
                  }),
            );
          }
        },
        listener: (context, state) {
          if (state is FetchedGroup) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndOfGroupList) {
            _refreshController.loadNoData();
          }
          if (state is AddingGroup) {
            EasyLoading.show(status: "loading....");
          } else if (state is ErrorAddingGroup) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.error.toString());
          } else if (state is AddedGroup) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Sucess");
          }
        });
  }
}
