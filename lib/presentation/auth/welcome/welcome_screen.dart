// Project imports:
part of app_layer;

Widget get welcomeScreenRoute => BlocProvider(
      create: (context) =>
          WelcomeBloc(getIt<AppUseCase>())..add(const InitWelcomeEvent()),
      child: const WelcomeScreen(
        welcomeModel: [],
      ),
    );

class WelcomeScreen extends StatefulWidget {
  final List<WelcomeModel> welcomeModel;

  const WelcomeScreen({Key? key, required this.welcomeModel}) : super(key: key);

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WelcomeBloc, WelcomeState>(
        listener: (context, state) {
          if (state.status == BlocStatusEnum.loading) {
            DialogManager.showLoadingDialog(context);
          }
          if (state.status == BlocStatusEnum.failed) {
            DialogManager.hideLoadingDialog;
            ToastManager.showToast(context, text: state.errMes);
          }
          if (state.status == BlocStatusEnum.success) {
            DialogManager.hideLoadingDialog;
          }
        },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final listData = state.welcomeModel?.banners ?? [];

          return Stack(
            children: [
              ValueListenableBuilder<int>(
                valueListenable: _currentIndex,
                builder: (context, value, child) => IndexedStack(
                  index: value,
                  children:
                      listData.map((e) => _buildPageView(e.photo)).toList(),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: _currentIndex,
                      builder: (context, value, child) => PointWidget(
                        currentIndex: value,
                        dotSize: listData.length,
                      ),
                    ),
                    const SizedBox(height: 65),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22)
                          .copyWith(bottom: 45),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Routes.instance
                                .navigateAndRemove(RouteDefine.bottomBarScreen),
                            child: _buildSkipButton(),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_currentIndex.value != listData.length - 1) {
                                _currentIndex.value++;
                              } else {
                                Routes.instance.navigateAndRemove(
                                    RouteDefine.bottomBarScreen);
                              }
                            },
                            child: _buildNextButton(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPageView(String? url) {
    return url != null
        ? CustomImageNetwork(
            url: url,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          )
        : Assets.images.welcome.image(
            width: double.maxFinite,
            height: double.infinity,
            fit: BoxFit.cover,
          );
  }

  Widget _buildSkipButton() {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(0.06),
      ),
      child: const Center(
        child: Text(
          'Skip',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      width: 45,
      height: 45,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.colorEF4948,
      ),
      child: const Icon(
        Icons.keyboard_arrow_right,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
