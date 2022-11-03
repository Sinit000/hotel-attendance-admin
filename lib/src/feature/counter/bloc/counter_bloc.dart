import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/bloc/counter_event.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/bloc/counter_state.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/model/checkin_history_model.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/model/counter_model.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/repository/counter_repository.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(InitailizingCounter());
  CounterRepository counterRepository = CounterRepository();
  List<CounterModel> checkilist = [];
  List<CheckinHistory> history = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is InitilizeCounterStarted) {
      yield InitailizingCounter();
      try {
        page = 1;
        List<CounterModel> _temlist = await counterRepository.getCounter(
            page: page, rowperpage: rowperpage);
        checkilist.addAll(_temlist);
        page++;
        if (event.isRefresh == true) {
          yield FetchedCounter();
        } else {
          yield InitailizedCounter();
        }
      } catch (e) {
        yield ErrorFetchingCounter(error: e.toString());
      }
    }
    if (event is FetchCounterStarted) {
      yield FetchingCounter();
      try {
        List<CounterModel> _temlist = await counterRepository.getCounter(
            page: page, rowperpage: rowperpage);
        checkilist.addAll(_temlist);
        page++;
        if (_temlist.length < rowperpage) {
          yield EndOfCounterList();
        } else {
          yield FetchedCounter();
        }
      } catch (e) {
        yield ErrorFetchingCounter(error: e.toString());
      }
    }
    if (event is UpdateCounterStarted) {
      yield AddingCounter();
      try {
        await counterRepository.editCounter(
            id: event.id,
            userId: event.userId,
            ot: event.ot,
            ph: event.ph,
            hospitalLeave: event.hospitalLeave,
            marriageLeave: event.marriageLeave,
            peternityLeave: event.peternityLeave,
            funeralLeave: event.funeralLeave,
            maternityLeave: event.maternityLeave);
        yield AddedCounter();
      } catch (e) {
        yield ErrorFetchingCounter(error: e.toString());
      }
    }
    // checkin history
    if (event is InitailizeHistoryStarted) {
      yield InitailizingHistory();
      try {
        page = 1;
        List<CheckinHistory> _temlist = await counterRepository
            .getCheckinHistory(page: page, rowperpage: rowperpage);
        history.addAll(_temlist);
        page++;
        if (event.isRefresh == true) {
          yield FetchedHistory();
        } else {
          yield InitailizedHistory();
        }
      } catch (e) {
        yield ErrorFetchingHistory(error: e.toString());
      }
    }
    if (event is FetchHistoryStarted) {
      yield FetchingHistory();
      try {
        List<CheckinHistory> _temlist = await counterRepository
            .getCheckinHistory(page: page, rowperpage: rowperpage);
        history.addAll(_temlist);
        page++;
        if (_temlist.length < rowperpage) {
          yield EndOfHistoryList();
        } else {
          yield FetchedHistory();
        }
      } catch (e) {
        yield ErrorFetchingHistory(error: e.toString());
      }
    }
  }
}
