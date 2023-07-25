// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// LoadingMethodGenerator
// **************************************************************************

extension HomeViewModelExtra on HomeViewModel {
  Future increment(int amount) async {
    setLoading(true);
    await _$increment(amount);
    setLoading(false);
  }
}
