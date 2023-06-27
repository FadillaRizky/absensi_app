import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, "/absensi");
                }, child: Text("Form Absen"))),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){}, child: Text("Form Izin Cuti"))),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, "/editprofile");
                }, child: Text("Form Biodata")))
          ],
        ),
      ),
    );
  }
}
