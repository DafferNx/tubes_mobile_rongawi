// File data dummy ulasan (Disiapkan untuk Orang 4 — Review, Komentar, dan Favorite)
class Review {
  final String id;
  final String restaurantId;
  final String userName;
  final double rating;
  final String comment;
  final String date;
  int likes;
  int dislikes;

  Review({
    required this.id,
    required this.restaurantId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
    this.likes = 0,
    this.dislikes = 0,
  });
}

final List<Review> dummyReviews = [];
