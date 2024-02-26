part of 'home_screen.dart';

class ExplorePageCopy extends StatefulWidget {
  const ExplorePageCopy({super.key});

  @override
  State<ExplorePageCopy> createState() => _ExplorePageCopyState();
}

class _ExplorePageCopyState extends State<ExplorePageCopy> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('locations').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return LocationCard(
                    locationName: data['name'],
                    image: data['image'],
                    locationRef: document.id,
                  );
                })
                .toList()
                .cast(),
          ),
        );
      },
    );
  }
}
