import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/widgets/category_product_item.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

import '../../injector_container.dart';

class ArgumentListProductScreen {
  final String? url;

  // final List<ProductModel>? products;
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
  final List<ProductModel> _products = [];
  int _page = 1;
  final ScrollController _scrollController = ScrollController();
  bool _enableContinueLoadMore = true;
  bool _loading = false;
  final _itemWidth = (GScreenUtil.screenWidthDp - 48) / 2;

  void _initData({bool showLoading = true}) async {
    try {
      if (showLoading) {
        _loading = true;
      }
      final dataSeller = await injector<AppClient>()
          .get('${widget.argument?.url}?page=$_page');
      int i = 0;
      String? key = (widget.argument?.url ?? '').contains('product-seller')
          ? 'productSellers'
          : null;
      dataSeller['data'][key ?? 'productFeatures']['data'].forEach((e) {
        i++;
        _products.add(ProductModel.fromJson(e));
      });
      if (i == 10) {
        _enableContinueLoadMore = true;
      }
      setState(() {
        _loading = false;
      });
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      _loading = false;
    }
  }

  @override
  void initState() {
    _initData();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 100) {
      if (_enableContinueLoadMore) {
        _enableContinueLoadMore = false;
        setState(() {
          _loading = true;
        });
        _page++;
        _initData(showLoading: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '${widget.argument?.label}',
        isShowBack: true,
      ),
      body: Column(
        children: [
          _loading
              ? const Expanded(
                  child: Center(
                  child: CircularProgressIndicator(),
                ))
              : _products.isEmpty
                  ? const Expanded(
                      child: Center(
                      child: Text("Không có sản phẩm nào!"),
                    ))
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: _products.length,
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
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
                          productModel: _products[index],
                        );
                      },
                    ),
        ],
      ),
    );
  }
}
