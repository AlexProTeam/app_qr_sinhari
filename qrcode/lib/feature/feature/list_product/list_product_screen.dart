import 'package:flutter/material.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/gridview_product.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key? key}) : super(key: key);

  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Sẩn phẩm bán chạy',
        iconLeftTap: (){
          Routes.instance.pop();
        },
      ),
      body: Column(
        children: [
          Expanded(child: GridViewDisplayProduct(
            numberItem: 20,
          ))
        ],
      ),
    );
  }
}
