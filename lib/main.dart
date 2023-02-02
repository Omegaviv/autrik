import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDarkEnable = true;
  final String darkModeMapUrl =
      "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png";
  final String lightModeMapUrl =
      "https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}{r}.png";

  ButtonStyle returnButtonStyle() {
    return ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(color: Colors.red))));
  }

  @override
  Widget build(BuildContext context) {
    //18.467799, 73.864729
    final myLocation = LatLng(18.467799, 73.864729);
    return MaterialApp(
      title: "My Location",
      home: Scaffold(
        body: Center(
            child: Stack(
          children: <Widget>[
            FlutterMap(
              options: MapOptions(center: myLocation, zoom: 13.0),
              children: [
                TileLayer(
                  urlTemplate: _isDarkEnable ? darkModeMapUrl : lightModeMapUrl,
                  minZoom: 0,
                  maxZoom: 22,
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                        point: myLocation,
                        width: 80,
                        height: 80,
                        builder: (context) => const Icon(Icons.location_on,
                            size: 60.0, color: Colors.red),
                        rotate: true),
                  ],
                )
              ],
            ),
            Positioned(
                left: 15,
                top: 15,
                child: Row(
                  children: [
                    ElevatedButton(
                        style: returnButtonStyle(),
                        onPressed: () {
                          setState(() {
                            _isDarkEnable = true;
                          });
                        },
                        child: const Text("Dark")),
                    const SizedBox(
                      width: 7,
                    ),
                    ElevatedButton(
                        style: returnButtonStyle(),
                        onPressed: () {
                          setState(() {
                            _isDarkEnable = false;
                          });
                        },
                        child: const Text("Light")),
                  ],
                ))
          ],
        )),
      ),
    );
  }
}
