part of 'home_screen.dart';

class LocationReviews extends StatefulWidget {
  const LocationReviews({super.key, required this.locationRef});

  final String locationRef;

  @override
  State<LocationReviews> createState() => _LocationReviewsState();
}

class _LocationReviewsState extends State<LocationReviews> {
  late Timestamp documentTimestamp;

  Future<List<Review>> fetchReviews(
      List<DocumentReference> reviewReferences) async {
    List<Review> reviews = [];

    for (DocumentReference reference in reviewReferences) {
      DocumentSnapshot reviewSnapshot = await reference.get();
      if (reviewSnapshot.exists) {
        Review review = Review(
            author: reviewSnapshot['author'] ?? '',
            rating: reviewSnapshot['rating'] ?? 0,
            description: reviewSnapshot['description'] ?? 0,
            createdAt: reviewSnapshot['created at']);
        reviews.add(review);
      }
    }

    return reviews;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('locations')
            .doc(widget.locationRef)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(255, 106, 84, 1),
              ),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Text('Document does not exist');
          }

          List<DocumentReference> reviewsReference =
              List<DocumentReference>.from(snapshot.data!['reviews']);

          return Column(children: [
            Image.network(
              snapshot.data!['image'],
              height: 300,
            ),
            Text(
              snapshot.data!['name'],
              style: const TextStyle(fontSize: 32),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FutureBuilder<List<Review>>(
                  future: fetchReviews(reviewsReference),
                  builder: (context, reviewSnapshot) {
                    if (reviewSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        color: Color.fromRGBO(255, 106, 84, 1),
                      );
                    }

                    if (reviewSnapshot.hasError) {
                      return Text(
                          'Error fetching reviews: ${reviewSnapshot.error}');
                    }

                    if (!reviewSnapshot.hasData ||
                        reviewSnapshot.data!.isEmpty) {
                      return const Center(child: Text('No reviews available'));
                    }

                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: reviewSnapshot.data!.length,
                        itemBuilder: (context, index) {
                          Review review = reviewSnapshot.data![index];
                          documentTimestamp = review.createdAt;
                          DateTime currentDate = DateTime.now();
                          DateTime documentDate = documentTimestamp.toDate();
                          int differenceInDays =
                              currentDate.difference(documentDate).inDays;
                          String displayText = differenceInDays == 0
                              ? '${documentDate.hour}:${documentDate.minute}'
                              : '$differenceInDays days ago';
                          return ListTile(
                            title: Text(review.description),
                            subtitle: Row(
                              children: [
                                Text(review.author),
                                Text(displayText)
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}

class Review {
  final String author;
  final String description;
  final Timestamp createdAt;
  final int rating;

  Review(
      {required this.author,
      required this.rating,
      required this.description,
      required this.createdAt});
}
