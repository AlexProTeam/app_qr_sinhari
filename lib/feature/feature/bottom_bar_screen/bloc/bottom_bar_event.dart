part of 'bottom_bar_bloc.dart';

abstract class BottomBarEvent extends Equatable {
  const BottomBarEvent();
}

class ChangeTabBottomBarEvent extends BottomBarEvent {
  final BottomBarEnum bottomBarEnum;

  const ChangeTabBottomBarEvent({required this.bottomBarEnum});

  @override
  List<Object?> get props => [bottomBarEnum];
}
