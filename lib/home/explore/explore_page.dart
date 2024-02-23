part of '../home_screen.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('reviews').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Card(
                  child: Column(
                    children: [
                      ReviewCard(
                        author: data['author'],
                        locationName: data['location'],
                        category: data['category'],
                        description: data['description'],
                        rating: data['rating'],
                      )
                    ],
                  ),
                );
              })
              .toList()
              .cast(),
        );
      },
    );
  }
}
