part of 'bottom_bar_bloc.dart';

class BottomBarState extends Equatable {
  final BottomBarEnum bottomBarEnum;
  final bool isRefresh;
  final bool isShowBottomBarEvent;

  const BottomBarState({
    required this.bottomBarEnum,
    this.isRefresh = false,
    this.isShowBottomBarEvent = true,
  });

  factory BottomBarState.initial() => const BottomBarState(
        bottomBarEnum: BottomBarEnum.home,
        isRefresh: false,
        isShowBottomBarEvent: true,
      );

  @override
  List<Object?> get props => [
        bottomBarEnum,
        isRefresh,
        isShowBottomBarEvent,
      ];

  BottomBarState copyWith({
    BottomBarEnum? bottomBarEnum,
    bool? isRefresh,
    bool? isShowBottomBarEvent,
  }) {
    return BottomBarState(
      bottomBarEnum: bottomBarEnum ?? this.bottomBarEnum,
      isRefresh: isRefresh ?? this.isRefresh,
      isShowBottomBarEvent: isShowBottomBarEvent ?? this.isShowBottomBarEvent,
    );
  }
}
