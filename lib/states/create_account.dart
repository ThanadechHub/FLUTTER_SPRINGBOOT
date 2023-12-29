import 'package:flutter/material.dart';
import 'package:flutter_application/utility/my_constant.dart';
import 'package:flutter_application/utility/my_style.dart';
import 'package:flutter_application/widgets/show_progress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateAccount extends StatefulWidget {
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  double? lat, lng;
  bool load = true;

  final formField = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    findLatLan();
  }

  Future<void> findLatLan() async {
    Position? position = await findPosition();

    if (position != null) {
      setState(() {
        lat = position.latitude;
        lng = position.longitude;
        load = false;
      });
      print('lat = $lat, lng = $lng ,load = $load');
    } else {
      print('Unable to retrieve position.');
    }
  }

  Future<Position?> findPosition() async {
    var status = await Permission.location.status;

    if (status == PermissionStatus.granted) {
      try {
        Position position = await Geolocator.getCurrentPosition();
        return position;
      } catch (e) {
        print('Error retrieving position: $e');
        return null;
      }
    } else if (status == PermissionStatus.denied) {
      var result = await Permission.location.request();

      if (result == PermissionStatus.granted) {
        try {
          Position position = await Geolocator.getCurrentPosition();
          return position;
        } catch (e) {
          print('Error retrieving position: $e');
          return null;
        }
      } else {
        print('Error retrieving position: Location permission denied.');
        return null;
      }
    } else {
      print('Error retrieving position: Location permission status: $status');
      return null;
    }
  }

  Container buildName(double size) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'โปรดระบุชื่อ!';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'Name : ',
          prefixIcon: const Icon(
            Icons.fingerprint,
            color: MyConstant.light,
            size: 30,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyConstant.dart)),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }

  Container buildUser(double size) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'User : ',
          prefixIcon: const Icon(
            Icons.perm_identity,
            color: MyConstant.light,
            size: 30,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyConstant.dart)),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }

  Container buildPassword(double size) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Password : ',
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: MyConstant.light,
            size: 30,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyConstant.dart)),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: MyConstant.statndard,
        title: const Text(
          'Create Account',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: load ? const ShowProgress() : buildCenter(size),
    );
  }

  Center buildCenter(double size) {
    return Center(
      child: Form(
        key: formField,
        child: Column(
          children: [
            buildName(size),
            buildUser(size),
            buildPassword(size),
            buildMap(size),
            buildCreateAccount(size)
          ],
        ),
      ),
    );
  }

  Container buildCreateAccount(double size) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: size * 0.6,
      child: ElevatedButton.icon(
        style: MyStyle().myButtonStyleV2(),
        onPressed: () {
          if (formField.currentState!.validate()) {}
        },
        icon: const Icon(Icons.cloud_upload_rounded, color: Colors.white),
        label: const Text(
          'Create Account',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Set<Marker> setMarkers() {
    return {
      Marker(
        markerId: MarkerId('id'),
        position: LatLng(lat!, lng!),
        infoWindow: InfoWindow(
            title: 'You Are Here!', snippet: 'Lat = $lat , lng = $lng'),
      ),
    };
  }

  Expanded buildMap(double size) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 30),
        width: size * 0.8,
        color: Colors.grey,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(lat!, lng!),
            zoom: 20,
          ),
          onMapCreated: (controller) {},
          markers: setMarkers(),
        ),
      ),
    );
  }
}
