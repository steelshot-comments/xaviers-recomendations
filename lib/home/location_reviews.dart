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

          Future<void> _launchUrl2() async {
            String uri = "xavier+college";

            final String dest = Uri.encodeFull(snapshot.data!['name']);
            final Uri url = Uri.parse(
                'https://www.google.com/maps/dir/?api=1&origin=$uri&destination=$dest');
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Google Maps not installed")));
              throw 'Could not launch $url';
            }
          }

          return Column(children: [
            Image.network(
              snapshot.data!['image'],
              height: 300,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Text(
                snapshot.data!['name'],
                style: const TextStyle(fontSize: 32),
              ),
              ElevatedButton(
                  onPressed: () {
                    _launchUrl2();
                  },
                  child: Text('Directions'))
            ]),
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
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${review.author} ($displayText)",
                                        style: TextStyle(fontSize: 14)),
                                    Row(
                                      children: [
                                        Text(
                                            "(${review.rating} out of 5 stars)  ",
                                            style: TextStyle(fontSize: 12)),
                                        StarRating(rating: review.rating),
                                      ],
                                    ),
                                    const SizedBox(height: 5)
                                  ],
                                ),
                                subtitle: Text(review.description,
                                    style: TextStyle(fontSize: 15)),
                              ),
                              const Divider(),
                            ],
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

  Review({
    required this.author,
    required this.rating,
    required this.description,
    required this.createdAt,
  });
}
