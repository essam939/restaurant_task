import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:restaurant/core/service/remote/service_locator.dart';
import 'package:restaurant/features/restaurant/presentation/controller/map/map_cubit.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  PageController? _pageController;
  int _currentPage = 0;

  final List<Map<String, dynamic>> locations = [
    {
      'name': 'Store 1',
      'lat': 37.42796133580664,
      'lng': -122.085749655962,
    },
    {
      'name': 'Store 2',
      'lat': 37.4219999,
      'lng': -122.0840575,
    },
    // Add more locations as needed
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.8,
    );
    final authController = ServiceLocator.instance<MapCubit>();
    authController.getRestaurants();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapCubit, MapState>(
      listener: (context, state) {
        if (state is MapLoading) {
          context.loaderOverlay.show();
        } else if (state is MapLoaded) {
          context.loaderOverlay.hide();
        } else if (state is MapError) {
          context.loaderOverlay.hide();
          var snackBar = SnackBar(
            content: Text(state.errorMessage.msg),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 14.0,
              ),
              markers: _createMarkers(),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
            Positioned(
              bottom: 20.0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 200.0,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: locations.length,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPage = index;
                    });
                    _animateToLocation(index);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return _buildCard(locations[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return locations.map((location) {
      return Marker(
        markerId: MarkerId(location['name']),
        position: LatLng(location['lat'], location['lng']),
        onTap: () {
          _pageController!.animateToPage(
            locations.indexOf(location),
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
      );
    }).toSet();
  }

  Widget _buildCard(Map<String, dynamic> location) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 2.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              location['name'],
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Add more details here',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  void _animateToLocation(int index) {
    mapController!.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(
          locations[index]['lat'],
          locations[index]['lng'],
        ),
      ),
    );
  }
}