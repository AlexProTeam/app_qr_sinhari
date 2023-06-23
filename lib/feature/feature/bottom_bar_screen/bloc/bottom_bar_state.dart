part of 'bottom_bar_bloc.dart';

class BottomBarState extends Equatable {
  final BottomBarEnum bottomBarEnum;

  const BottomBarState({required this.bottomBarEnum});

  factory BottomBarState.initial() =>
      const BottomBarState(bottomBarEnum: BottomBarEnum.home);

  @override
  List<Object?> get props => [bottomBarEnum];
}
