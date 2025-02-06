
part of 'home_bloc.dart';

class HomeState {
  int currentIndex;
  bool isShowNameHuman;

  HomeState({this.currentIndex = 0, this.isShowNameHuman = true});
}

final class LoadHomeState extends HomeState {}

final class SuccessHomeState extends HomeState {}

final class ErrorHomeState extends HomeState {}