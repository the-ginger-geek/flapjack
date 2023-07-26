class LoaderMetaData {
  final bool isLoading;
  final String? loaderKey;

  LoaderMetaData(this.isLoading, {this.loaderKey});

  LoaderMetaData copyWith({bool? isLoading, String? loaderKey}) {
    return LoaderMetaData(
      isLoading ?? this.isLoading,
      loaderKey: loaderKey ?? this.loaderKey,
    );
  }

  bool isLoadingForKey(String key) => isLoading && loaderKey == key;
}
