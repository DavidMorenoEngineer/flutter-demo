import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'billing_cubit.freezed.dart';

@freezed
abstract class BillingState with _$BillingState {
  const factory BillingState({@Default(false) bool yearly}) = _BillingState;
}

/// Monthly / Yearly toggle on the pricing tiers.
@injectable
class BillingCubit extends Cubit<BillingState> {
  BillingCubit() : super(const BillingState());

  void setYearly(bool yearly) => emit(BillingState(yearly: yearly));
}
