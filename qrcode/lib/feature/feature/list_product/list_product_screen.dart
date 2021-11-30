import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/gridview_product.dart';
import 'package:qrcode/feature/widgets/gridview_product_item.dart';

class ArgumentListProductScreen {
  final List<ProductModel>? products;
  final String? label;

  ArgumentListProductScreen({this.products, this.label});
}

class ListProductScreen extends StatefulWidget {
  final ArgumentListProductScreen? argument;

  const ListProductScreen({
    Key? key,
    this.argument,
  }) : super(key: key);

  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  @override
  Widget build(BuildContext context) {
    final _itemWidth = (GScreenUtil.screenWidthDp - 48) / 2;
    final _itemHeight = _itemWidth + 50;
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: '${widget.argument?.label}',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: GridView.builder(
        itemCount: widget.argument?.products?.length,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: _itemWidth / _itemHeight,
        ),
        itemBuilder: (context, index) {
          return CategoryDetailWidgetItemProduct(
            itemWidth: _itemWidth,
            productModel: widget.argument?.products?[index],
          );
        },
      ),
    );
  }
}
