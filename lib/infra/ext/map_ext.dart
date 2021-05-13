T tryCast<T>(dynamic x, {required T fallback}) {
  // tryParse from [String] `x`
  if (x is String) {
    if (T == int || T == double) {
      // tryParse to [num] (i.e. [int], [double])
      return num.tryParse(x) as T ?? fallback;
    } else if (T == DateTime) {
      // tryParse to [DateTime]
      return DateTime.tryParse(x) as T ?? fallback;
    } else if (T == Uri) {
      // tryParse to [Uri]
      return Uri.tryParse(x) as T ?? fallback;
    }
  }

  try {
    return (x as T) ?? fallback;
  } on Exception catch (e) {
    print('CastError when trying to cast $x to $T! Exception catched: $e');
    return fallback;
  }
}
