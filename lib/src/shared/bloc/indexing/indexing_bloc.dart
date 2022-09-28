import 'package:hotle_attendnce_admin/src/shared/bloc/indexing/indexing_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class IndexingBloc extends Bloc<IndexingEvent, int> {
  @override
  IndexingBloc() : super(0);

  @override
  Stream<int> mapEventToState(IndexingEvent event) async* {
    if (event is Tapped) {
      yield event.index;
    }
  }
}

IndexingBloc categoryIndexBloc = IndexingBloc();
