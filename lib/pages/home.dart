import 'package:absensi_app/database/database_profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   DatabaseProfile? databaseInstance;

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseProfile();
    initDatabase();
    super.initState();
  }
  
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
                child: ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, "/cuti");
                }, child: Text("Form Izin Cuti"))),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                  if(databaseInstance != null){
                    Navigator.pushNamed(context, "/profile");
                  }else{
                    Navigator.pushNamed(context, "/editprofile");
                  }
                }, child: Text("Form Biodata")))
          ],
        ),
      ),
    );
  }
}
