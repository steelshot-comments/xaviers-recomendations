part of '../home_screen.dart';

class ViewMap extends StatefulWidget {
  const ViewMap({super.key});

  @override
  _ViewMapState createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  String _title = "";
  String _origin = "";
  String _destination = "";
  final String _travelMode = "";

  Future<void> _launchUrl() async {
    final String title = Uri.encodeFull(_title);
    final Uri url =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$title');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Google Maps not installed")));
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchUrl2() async {
    late String ori = Uri.encodeFull(_origin);
    if (ori == "") {
      ori = "xavier+college";
    }
    final String dest = Uri.encodeFull(_destination);
    final Uri url =
        Uri.parse('https://www.google.com/maps/dir/?api=1&origin=$ori&destination=$dest&travelmode=$_travelMode');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Google Maps not installed")));
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10.0),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Anywhere Door',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 700,
                            child: TextFormField(
                              style: const TextStyle(
                                fontSize: 20.0,
                                height: 2.0,
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                  labelText: 'Origin',
                                  hintText: 'Enter Your Current Location',
                                  border: OutlineInputBorder()),
                              onChanged: (value) => _origin = value,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 700,
                            child: TextFormField(
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  height: 2.0,
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                    labelText: 'Destination',
                                    hintText: 'Enter Your Destination',
                                    border: OutlineInputBorder()),
                                onChanged: (value) {
                                  _destination = value;
                                }),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 700,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Choose a Travelling Mode: ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    height: 2.0,
                                  ),
                                ),
                                const CustomDropdown( options:[
                                   'best travel modes',
                                   'driving',
                                   'walking',
                                   'transit',
                                   'two-wheeler'
                                 ]),
                                const SizedBox(height: 5.0),
                                ElevatedButton(
                                  onPressed: _launchUrl2,
                                  child: const Text('Get Path'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Stack(
                    children: [
                      Image.asset(
                        'assets/bg.jpeg',
                        width: 700.0,
                        height: 400.0),
                      const Card(
                        elevation: 4,
                        
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Verify if the place exists.',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 700,
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  height: 2.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Enter Location',
                                suffixIcon: IconButton(
                                  onPressed: _launchUrl,
                                  icon: const Icon(
                                    Icons.search,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                              onChanged: (value) => _title = value,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}