// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// AsyncLoaderGenerator
// **************************************************************************

extension HomeViewModelExtra on HomeViewModel {
  Future increment(int amount) async {
    setLoading(LoaderMetaData(true, loaderKey: 'increment'));
    await _$increment(amount);
    setLoading(LoaderMetaData(false, loaderKey: 'increment'));
  }

  Future decrement(int amount) async {
    setLoading(LoaderMetaData(true, loaderKey: 'decrement'));
    await _$decrement(amount);
    setLoading(LoaderMetaData(false, loaderKey: 'decrement'));
  }
}
