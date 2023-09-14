part of 'details_product_bloc.dart';

abstract class DetailsProductEvent extends Equatable {
  const DetailsProductEvent();
}

class OnClickBuyEvent extends DetailsProductEvent {
  final int arg;
  final BuildContext context;
  final TextEditingController content;
  final GlobalKey<FormState> formKey;

  const OnClickBuyEvent(this.arg, this.context, this.content, this.formKey);

  @override
  List<Object?> get props => [arg, context, content, formKey];
}
