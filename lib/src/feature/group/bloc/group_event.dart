import 'package:equatable/equatable.dart';

class GroupEvent extends Equatable {
  GroupEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchGroupStarted extends GroupEvent {}

class FetchAllGroupStarted extends GroupEvent {}

class InitializeGroupStarted extends GroupEvent {}

class RefreshGroupStarted extends GroupEvent {}

class AddGroupStarted extends GroupEvent {
  final String name;
  final String workdayId;
 
  final String notes;
  AddGroupStarted({
    required this.name,
    required this.workdayId,
   
    required this.notes
  });
}

class UpdateGroupStarted extends GroupEvent {
  final String id;
  final String name;
   final String worddayId;
  
  final String notes;
  UpdateGroupStarted({
    required this.id, 
    required this.name,
     required this.worddayId,
    
    required this.notes});
}

class DeleteGroupStarted extends GroupEvent {
  final String id;
 
  DeleteGroupStarted({
    required this.id,
  });
}
