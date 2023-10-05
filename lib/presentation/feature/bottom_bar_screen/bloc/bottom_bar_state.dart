part of 'bottom_bar_bloc.dart';

class BottomBarState extends Equatable {
  final BottomBarEnum bottomBarEnum;
  final bool isRefresh;

  const BottomBarState({
    required this.bottomBarEnum,
    this.isRefresh = false,
  });

  factory BottomBarState.initial() =>
      const BottomBarState(bottomBarEnum: BottomBarEnum.home, isRefresh: false);

  @override
  List<Object?> get props => [bottomBarEnum, isRefresh];
}
