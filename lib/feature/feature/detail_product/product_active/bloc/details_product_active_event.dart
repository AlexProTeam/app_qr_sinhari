part of 'details_product_active_bloc.dart';

abstract class DetailsProductActiveEvent extends Equatable {
  const DetailsProductActiveEvent();
}

class InitDetailsProductEvent extends DetailsProductActiveEvent {
  final int arg;
  final BuildContext context;
  final TextEditingController content;
  final GlobalKey<FormState> formKey;

  const InitDetailsProductEvent(this.arg, this.context, this.content, this.formKey);

  @override
  List<Object?> get props => [arg];
}
