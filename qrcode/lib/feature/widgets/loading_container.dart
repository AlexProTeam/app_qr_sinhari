import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_state.dart';
import 'package:qrcode/feature/injector_container.dart';

class LoadingContainer extends StatelessWidget {
  final Widget? child;

  const LoadingContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          child ?? SizedBox(),
          BlocBuilder<LoadingBloc, LoadingState>(
            bloc: injector<LoadingBloc>(),
            builder: (context, state) {
              return Visibility(
                visible: state.loading ?? true,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.1),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
