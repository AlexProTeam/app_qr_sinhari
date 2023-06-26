import 'package:flutter/cupertino.dart';

import '../bottom/home_enum.dart';

class FilterItemWidget extends StatelessWidget {
  final int index;

  const FilterItemWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            IconHomeEnum.values[index].getIcon,
            width: 45,
            height: 45,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 2),
          Text(
            IconHomeEnum.values[index].getTitle,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Color(0xFFACACAC)),
          )
        ],
      ),
    );
  }
}
