import 'dart:developer';

import 'package:hotle_attendnce_admin/src/feature/notification/model/notification_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/repository/notification_repository.dart';

import 'index.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(InitializingNotification());
  List<NotificationModel> notificationModel = [];
  NotificationRepository _notificationRepository = NotificationRepository();
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is InitializeNotificationStarted) {
      yield InitializingNotification();
      try {
        page = 1;
        notificationModel.clear();
        List<NotificationModel> _temlist = await _notificationRepository
            .getNotification(rowPerpage: rowperpage, page: page);
        notificationModel.addAll(_temlist);
        page++;

        if (event.isRefresh == true) {
          yield FetchedNotification();
        }
        yield InitializedNotification();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingNotification(error: e.toString());
      }
    }
    if (event is FetchNotificationStarted) {
      yield FetchingNotification();
      try {
        List<NotificationModel> _temList = await _notificationRepository
            .getNotification(rowPerpage: rowperpage, page: page);

        notificationModel.addAll(_temList);
        page++;

        if (_temList.length < rowperpage) {
          yield EndOfNotificationList();
        } else {
          yield FetchedNotification();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingNotification(error: e.toString());
      }
    }

    if (event is AddNotificationStarted) {
      yield AddingNotification();
      try {
        await _notificationRepository.addNotification(
            date: event.date,
            time: event.time,
            userId: event.userId,
            title: event.title,
            des: event.des);
        yield AddedNotification();
        yield FetchingNotification();
        notificationModel.clear();
        page = 1;
        List<NotificationModel> _temlist = await _notificationRepository
            .getNotification(rowPerpage: rowperpage, page: page);
        notificationModel.addAll(_temlist);
        page++;

        yield FetchedNotification();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingNotification(error: e.toString());
      }
    }
    if (event is UpdateNotificationStarted) {
      yield AddingNotification();
      try {
        await _notificationRepository.editNotification(
            date: event.date,
            time: event.time,
            userId: event.userId,
            id: event.id,
            title: event.title,
            des: event.des);
        yield AddedNotification();
        yield FetchingNotification();
        notificationModel.clear();
        page = 1;
        List<NotificationModel> _temlist = await _notificationRepository
            .getNotification(rowPerpage: rowperpage, page: page);
        notificationModel.addAll(_temlist);
        page++;
        yield FetchedNotification();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingNotification(error: e.toString());
      }
    }
    if (event is DeleteNotificationStarted) {
      yield AddingNotification();
      try {
        await _notificationRepository.deleteNotification(id: event.id);
        yield AddedNotification();
        yield FetchingNotification();
        notificationModel.clear();
        page = 1;
        List<NotificationModel> _temlist = await _notificationRepository
            .getNotification(rowPerpage: rowperpage, page: page);
        notificationModel.addAll(_temlist);
        page++;
        yield FetchedNotification();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingNotification(error: e.toString());
      }
    }
  }
}
