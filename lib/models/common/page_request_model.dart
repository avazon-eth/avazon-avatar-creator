/// Common class for pagination requests
class PageRequestModel {
  final String? sortBy;
  final String? sortOrder;
  final int? limit;
  final int? page;
  final int? size; // Added missing field

  const PageRequestModel({
    this.sortBy,
    this.sortOrder,
    this.size,
    this.limit,
    this.page,
  });

  bool get isDefault => sortBy == null && sortOrder == null && size == null;

  PageRequestModel copyWith({
    String? sortBy,
    String? sortOrder,
    int? size,
    int? limit,
    int? page,
  }) {
    return PageRequestModel(
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      size: size ?? this.size,
      limit: limit ?? this.limit,
      page: page ?? this.page,
    );
  }

  PageRequestModel get cursorCleared => PageRequestModel(
        sortBy: sortBy,
        sortOrder: sortOrder,
        size: size,
        limit: limit,
        page: page,
      );

  @override
  int get hashCode {
    if (isDefault) {
      return super.hashCode;
    }
    return (sortBy?.hashCode ?? 0) ^
        (sortOrder?.hashCode ?? 0) ^
        (size?.hashCode ?? 0) ^
        (limit?.hashCode ?? 0) ^
        (page?.hashCode ?? 0);
  }

  @override
  bool operator ==(Object other) {
    if (other is PageRequestModel) {
      return sortBy == other.sortBy &&
          sortOrder == other.sortOrder &&
          size == other.size &&
          limit == other.limit &&
          page == other.page;
    } else {
      return false;
    }
  }

  Map<String, dynamic> toJson() {
    final ret = <String, dynamic>{};
    if (sortBy != null) {
      ret['sortBy'] = sortBy;
    }
    if (sortOrder != null) {
      ret['sortOrder'] = sortOrder;
    }
    if (size != null) {
      ret['size'] = size;
    }
    if (limit != null) {
      ret['limit'] = limit;
    }
    if (page != null) {
      ret['page'] = page;
    }
    return ret;
  }
}
