import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qrcode/common/utils/enum_app_status.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/feature/list_product/bloc/list_product_bloc.dart';
import 'package:qrcode/feature/widgets/category_product_item.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

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
  final ScrollController _scrollController = ScrollController();
  final _itemWidth = (GScreenUtil.screenWidthDp - 48) / 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '${widget.argument?.label}',
        isShowBack: true,
      ),
      body: BlocProvider(
        create: (context) => ListProductBloc(ArgumentListProductScreen(
            url: widget.argument?.url, label: widget.argument?.label))
          ..add(const InitListProductEvent()),
        child: BlocBuilder<ListProductBloc, ListProductState>(
          builder: (BuildContext context, state) {
            final products = state.products ?? [];
            if (products.isEmpty || state.status == ScreenStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return products.isEmpty
                  ? const Center(
                      child: Text("Không có sản phẩm nào!"),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0)
                          .copyWith(bottom: 100),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 12.0,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            2 /
                            (MediaQuery.of(context).size.height / 2.5),
                      ),
                      itemBuilder: (context, index) {
                        return CategoryItemProduct(
                          itemWidth: _itemWidth,
                          productModel: products[index],
                        );
                      },
                    );
            }
          },
        ),
      ),
    );
  }
}
