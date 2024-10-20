class Pair<T, U> {
  final T first;
  final U second;

  const Pair(this.first, this.second);

  @override
  int get hashCode => Object.hash(first, second);

  @override
  String toString() => 'Pair($first, $second)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pair<T, U> &&
        other.first == first &&
        other.second == second;
  }
}
