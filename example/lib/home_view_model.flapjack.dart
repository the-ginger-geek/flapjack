// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// AsyncLoaderGenerator
// **************************************************************************

extension HomeViewModelExtra on HomeViewModel {
  Future increment(int amount) async {
    setLoading(true);
    await _$increment(amount);
    setLoading(false);
  }

  Future decrement(int amount) async {
    setLoading(true);
    await _$decrement(amount);
    setLoading(false);
  }
}
