import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:restaurant/core/service/remote/service_locator.dart';
import 'package:restaurant/features/restaurant/domain/entities/map_response.dart';
import 'package:restaurant/features/restaurant/presentation/controller/map/map_cubit.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  PageController? _pageController;
  int _currentPage = 0;

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
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        if (state is MapLoading) {
          return const LoaderOverlay(
              child: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ));
        } else if (state is MapLoaded) {
          context.loaderOverlay.hide();
          return Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(state.mapResponse.first.lat,
                        state.mapResponse.first.long),
                    zoom: 14.0,
                  ),
                  markers: _createMarkers(state.mapResponse),
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
                      itemCount: state.mapResponse.length,
                      onPageChanged: (int index) {
                        setState(() {
                          _currentPage = index;
                        });
                        _animateToLocation(state.mapResponse[index]);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return _buildCard(state.mapResponse[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is MapError) {
          return LoaderOverlay(
              child: Scaffold(
            body: Center(
              child: Text(state.errorMessage.msg),
            ),
          ));
        } else {
          return LoaderOverlay(
              child: Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          ));
        }
      },
    );
  }

  Set<Marker> _createMarkers(List<MapResponse> mapResponse) {
    return mapResponse.map((location) {
      return Marker(
        markerId: MarkerId(location.id.toString()),
        position:
            LatLng(location.lat, location.long),
        onTap: () {
          _pageController!.animateToPage(
            mapResponse.indexOf(location),
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
      );
    }).toSet();
  }

  Widget _buildCard(MapResponse mapResponse) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
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
            ListTile(
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(mapResponse.image)),
                title: Text(
                  "phone number",
                ),
                subtitle: Text(
                  mapResponse.phone,
                )),
            ListTile(
                leading: Icon(Icons.location_on),
                title: Text(
                  "Address",
                ),
                subtitle: Text(
                  mapResponse.address.en,
                )),
          ],
        ),
      ),
    );
  }

  void _animateToLocation(MapResponse location) {
    mapController!.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(
          location.lat,
          location.long,
        ),
      ),
    );
  }
}
