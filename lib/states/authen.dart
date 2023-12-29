import 'package:flutter/material.dart';
import 'package:flutter_application/utility/my_constant.dart';
import 'package:flutter_application/utility/my_style.dart';
import 'package:flutter_application/widgets/show_image.dart';
import 'package:flutter_application/widgets/show_title.dart';

class Authen extends StatefulWidget {
  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    print('size = $size');
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildImage(size),
                ShowTitle(
                  title: 'tisco.co.th',
                  textStyle: MyStyle().h2Style(),
                ),
                buildUser(size),
                buildPassword(size),
                buildLogin(size),
                buildRow()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: 'Non Account ?',
          textStyle: MyStyle().h3Style(),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/createAccount'),
          child: const Text(
            'Create Account',
            style: TextStyle(color: MyConstant.statndard),
          ),
        )
      ],
    );
  }

  Container buildLogin(double size) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: size * 0.6,
      child: ElevatedButton(
        style: MyStyle().myButtonStyleV2(),
        onPressed: () {},
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
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
        obscureText: true,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove_red_eye),
          ),
          labelText: 'Password : ',
          prefixIcon: const Icon(
            Icons.lock_outlined,
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

  Container buildImage(double size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: 400,
      child: const ShowImage(),
    );
  }
}
