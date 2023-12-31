part of 'bottom_bar_bloc.dart';

abstract class BottomBarEvent extends Equatable {
  const BottomBarEvent();
}

class ChangeTabBottomBarEvent extends BottomBarEvent {
  final BottomBarEnum bottomBarEnum;
  final bool isRefresh;

  const ChangeTabBottomBarEvent({
    required this.bottomBarEnum,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [bottomBarEnum, isRefresh];
}
