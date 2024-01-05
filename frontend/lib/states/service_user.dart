import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/model/loan.dart';
import 'package:flutter_application/utility/my_constant.dart';
import 'package:flutter_application/utility/my_style.dart';
import 'package:flutter_application/widgets/show_progress.dart';
import 'package:flutter_application/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceUser extends StatefulWidget {
  const ServiceUser({super.key});

  @override
  State<ServiceUser> createState() => _ServiceUserState();
}

class _ServiceUserState extends State<ServiceUser> {
  List<Widget> widgets = [];
  List<String> pathImages = [
    'images/banner1.jpg',
    'images/banner2.png',
    'images/banner3.jpg',
  ];

  List<String> pathLoanImages = [
    'images/loan1.png',
    'images/loan2.png',
    'images/loan3.png'
  ];

  List<LoanModel> LoanModels = [];
  List<Widget> imageWidgets = [];

  @override
  void initState() {
    super.initState();
    buildWidgets();
    readData();
  }

  Future<Null> readData() async {
    String apiLoan = 'http://10.0.2.2:8080/api/Loan';
    await Dio().get(apiLoan).then(
      (value) {
        print('### apiLoan = $value');
        for (var element in value.data) {
          LoanModel model = LoanModel.fromMap(element);
          setState(() {
            LoanModels.add(model);
          });
        }
      },
    );
  }

  void buildWidgets() {
    for (var element in pathImages) {
      widgets.add(Image.asset(element));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.statndard,
        title: Center(
          child: Column(
            children: [
              Image.asset(
                'images/somwang_logo.png',
                height: 50,
              ),
            ],
          ),
        ),
        actions: [buildSignOut()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCarouselSlider(),
            buildTiltle(),
            LoanModels.length == 0 ? const ShowProgress() : buildListView()
          ],
        ),
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: pathLoanImages.length,
      itemBuilder: (context, index) => Row(
        children: [
          Container(
            child: Image.asset(
              pathLoanImages[
                  index], // แทนที่ 'path/to/image.jpg' ด้วย path จริง
              height: 50, // ปรับความสูงตามต้องการ
              width: 50, // ปรับความกว้างตามต้องการ
            ),
          )
        ],
      ),
    );
  }

  Row buildTiltle() {
    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        ShowTitle(
          title: 'สินเชื่อ : ',
          textStyle: MyStyle().h1Style(),
        ),
      ],
    );
  }

  CarouselSlider buildCarouselSlider() {
    return CarouselSlider(
      items: widgets,
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        viewportFraction: 0.8,
      ),
    );
  }

  IconButton buildSignOut() {
    return IconButton(
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        Navigator.pushNamedAndRemoveUntil(context, '/authen', (route) => false);
      },
      icon: const Icon(
        Icons.exit_to_app,
        color: Colors.white,
      ),
    );
  }
}
