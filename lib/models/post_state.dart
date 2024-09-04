enum PostStatus { initial, success, error }

class PostState<T> {
  final PostStatus status;
  final List<T> posts;
  final bool hasReachedMax;

  const PostState({
    this.status = PostStatus.initial,
    this.posts = const [],
    this.hasReachedMax = false,
  });

  PostState<T> copyWith({
    PostStatus? status,
    List<T>? posts,
    bool? hasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
