import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/core/num_ex.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/widgets/check_box_custom.dart';

import '../../../../domain/entity/list_carts_response.dart';
import '../bloc/carts_bloc.dart';

class ListProducts extends StatelessWidget {
  final List<ItemsCarts> listItemsCarts;

  const ListProducts({
    Key? key,
    required this.listItemsCarts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listItemsCarts.length,
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          ItemList(itemsCarts: listItemsCarts[index]),
    );
  }
}

class ItemList extends StatefulWidget {
  final ItemsCarts itemsCarts;

  const ItemList({
    Key? key,
    required this.itemsCarts,
  }) : super(key: key);

  @override
  ItemListState createState() => ItemListState();
}

class ItemListState extends State<ItemList> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.colorF1F1F1))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCheckBox(),
          _buildProductImage(),
          _buildProductDetails(),
        ],
      ),
    );
  }

  Widget _buildCheckBox() {
    return SizedBox(
      width: 30.r,
      height: 30.r,
      child: CheckBoxCustom(
        enable: false,
        onChanged: (value) {
          setState(() {
            isCheck = value ?? true;
          });
        },
        value: isCheck,
      ),
    );
  }

  Widget _buildProductImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Image.network(
        widget.itemsCarts.image ?? '',
        width: 105.w,
        height: 95.h,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildProductDetails() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 8.r, right: 8.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductName(),
            8.verticalSpace,
            _buildPriceSection(),
            8.verticalSpace,
            _buildQuantitySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductName() {
    return Text(
      widget.itemsCarts.name ?? '',
      style: TextStyleManager.mediumBlack14px.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _buildPriceSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPriceText(
          widget.itemsCarts.getSalePrice.toAppNumberFormat,
          textColor: AppColors.color7F2B81,
        ),
        _buildPriceText(
          widget.itemsCarts.getOriginPrice.toAppNumberFormat,
          decoration: TextDecoration.lineThrough,
        ),
      ],
    );
  }

  Widget _buildPriceText(String price,
      {TextDecoration? decoration, Color? textColor}) {
    return Expanded(
      child: Text(
        '$price vnđ',
        style: TextStyleManager.mediumBlack14px.copyWith(
          decoration: decoration,
          fontSize: 12.sp,
          color: textColor ?? AppColors.black,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _buildQuantitySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Số lượng: ',
          style: TextStyleManager.mediumBlack14px,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        _buildQuantityButton(Assets.icons.iconDown.path, onTap: () {
          context.read<CartsBloc>().add(ChangeQualityCartEvent(
              widget.itemsCarts.productId ?? 0,
              widget.itemsCarts.getQtyNum - 1));
        }),
        Text(
          widget.itemsCarts.getQtyNum.toString(),
          style: TextStyleManager.mediumBlack14px,
        ),
        _buildQuantityButton(
          Assets.icons.icPlus.path,
          onTap: () {
            context.read<CartsBloc>().add(ChangeQualityCartEvent(
                widget.itemsCarts.productId ?? 0,
                widget.itemsCarts.getQtyNum + 1));
          },
          color: AppColors.color7F2B81,
        ),
      ],
    );
  }

  Widget _buildQuantityButton(
    String iconPath, {
    required Function() onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? AppColors.red,
        ),
        child: Image.asset(iconPath),
      ),
    );
  }
}
