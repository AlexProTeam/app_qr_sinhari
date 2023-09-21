import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/di/injection.dart';
import 'package:qrcode/app/managers/const/status_bloc.dart';
import 'package:qrcode/domain/login/usecases/app_usecase.dart';

import '../../../app/route/screen_utils.dart';
import '../../widgets/category_product_item.dart';
import '../../widgets/custom_scaffold.dart';
import 'bloc/list_product_bloc.dart';

class ArgumentListProductScreen {
  final String? url;
  final String? label;

  ArgumentListProductScreen({this.url, this.label});
}

class ListProductScreen extends StatefulWidget {
  final ArgumentListProductScreen? argument;

  const ListProductScreen({
    Key? key,
    this.argument,
  }) : super(key: key);

  @override
  ListProductScreenState createState() => ListProductScreenState();
}

class ListProductScreenState extends State<ListProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '${widget.argument?.label}',
        isShowBack: true,
      ),
      body: BlocProvider(
        create: (context) =>
            ListProductBloc(getIt<AppUseCase>(), widget.argument?.url ?? '')
              ..add(const InitListProductEvent()),
        child: BlocBuilder<ListProductBloc, ListProductState>(
          builder: (BuildContext context, state) {
            final products = state.products ?? [];
            if (state.status == BlocStatusEnum.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (products.isEmpty) {
              return const Center(
                child: Text("Không có sản phẩm nào!"),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0)
                      .copyWith(bottom: getPadding(context)),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.5,
              ),
              itemBuilder: (context, index) {
                return CategoryItemProduct(
                  itemWidth: (GScreenUtil.screenWidthDp - 48) / 2,
                  productModel: products[index],
                );
              },
            );
          },
        ),
      ),
    );
  }

  double getPadding(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (height < 800) {
      return 100;
    }
    return 20;
  }
}
