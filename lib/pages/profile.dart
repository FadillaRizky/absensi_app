import 'package:absensi_app/database/database_profile.dart';
import 'package:absensi_app/models/profile_model.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController bodController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
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
        title: Text("My Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Container(
            child: databaseInstance != null
                ? FutureBuilder<List<ProfileModel>>(
                    future: databaseInstance!.all(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.length == 0) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama",
                                style: TextStyle(fontSize: 18),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 3),
                                width: double.infinity,
                                height: 50,
                                child: TextFormField(
                                  enabled: false,
                                  style: TextStyle(color: Colors.black),
                                  initialValue: "..",
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 3, 1, 3),
                                    hintStyle: TextStyle(color: Colors.black26),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Color.fromARGB(
                                      239,
                                      239,
                                      239,
                                      239,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "NIK",
                                style: TextStyle(fontSize: 18),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 3),
                                width: double.infinity,
                                height: 50,
                                child: TextFormField(
                                  enabled: false,
                                  style: TextStyle(color: Colors.black),
                                  initialValue: "..",
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 3, 1, 3),
                                    hintStyle: TextStyle(color: Colors.black26),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Color.fromARGB(
                                      239,
                                      239,
                                      239,
                                      239,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Tanggal Lahir",
                                style: TextStyle(fontSize: 18),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 3),
                                width: double.infinity,
                                height: 50,
                                child: TextFormField(
                                  enabled: false,
                                  style: TextStyle(color: Colors.black),
                                  initialValue: "..",
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 3, 1, 3),
                                    hintStyle: TextStyle(color: Colors.black26),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Color.fromARGB(
                                      239,
                                      239,
                                      239,
                                      239,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Jabatan",
                                style: TextStyle(fontSize: 18),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 3),
                                width: double.infinity,
                                height: 50,
                                child: TextFormField(
                                  enabled: false,
                                  style: TextStyle(color: Colors.black),
                                  initialValue: "..",
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 3, 1, 3),
                                    hintStyle: TextStyle(color: Colors.black26),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Color.fromARGB(
                                      239,
                                      239,
                                      239,
                                      239,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Alamat",
                                style: TextStyle(fontSize: 18),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 3),
                                width: double.infinity,
                                height: 50,
                                child: TextFormField(
                                  enabled: false,
                                  style: TextStyle(color: Colors.black),
                                  initialValue: "..",
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 3, 1, 3),
                                    hintStyle: TextStyle(color: Colors.black26),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Color.fromARGB(
                                      239,
                                      239,
                                      239,
                                      239,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.blueAccent)
                                  ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/editprofile");
                                    },
                                    child: Text("Ubah",style: TextStyle(color: Colors.white))),
                              )
                            ],
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama",
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              width: double.infinity,
                              height: 50,
                              child: TextFormField(
                                enabled: false,
                                style: TextStyle(color: Colors.black),
                                initialValue: snapshot.data![0].name ?? "",
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 3, 1, 3),
                                  hintStyle: TextStyle(color: Colors.black26),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(
                                    239,
                                    239,
                                    239,
                                    239,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "NIK",
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              width: double.infinity,
                              height: 50,
                              child: TextFormField(
                                enabled: false,
                                style: TextStyle(color: Colors.black),
                                initialValue: snapshot.data![0].nik ?? "",
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 3, 1, 3),
                                  hintStyle: TextStyle(color: Colors.black26),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(
                                    239,
                                    239,
                                    239,
                                    239,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "Tanggal Lahir",
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              width: double.infinity,
                              height: 50,
                              child: TextFormField(
                                enabled: false,
                                style: TextStyle(color: Colors.black),
                                initialValue: snapshot.data![0].bod ?? "",
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 3, 1, 3),
                                  hintStyle: TextStyle(color: Colors.black26),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(
                                    239,
                                    239,
                                    239,
                                    239,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "Jabatan",
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              width: double.infinity,
                              height: 50,
                              child: TextFormField(
                                enabled: false,
                                style: TextStyle(color: Colors.black),
                                initialValue: snapshot.data![0].position ?? "",
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 3, 1, 3),
                                  hintStyle: TextStyle(color: Colors.black26),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(
                                    239,
                                    239,
                                    239,
                                    239,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "Alamat",
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              width: double.infinity,
                              height: 50,
                              child: TextFormField(
                                enabled: false,
                                style: TextStyle(color: Colors.black),
                                initialValue: snapshot.data![0].address ?? "",
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 3, 1, 3),
                                  hintStyle: TextStyle(color: Colors.black26),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(
                                    239,
                                    239,
                                    239,
                                    239,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent)
                                ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/editprofile");
                                  },
                                  child: Text("Ubah",style: TextStyle(color: Colors.white),)),
                            )
                          ],
                        );
                      }
                      if (snapshot.hasError) {
                        Center(child: Text("${snapshot.error}"));
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class ItemProfile extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType tipeKeyboard;

  const ItemProfile({
    Key? key,
    required this.title,
    required this.controller,
    required this.tipeKeyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 3),
          width: double.infinity,
          height: 50,
          child: TextFormField(
            controller: controller,
            keyboardType: tipeKeyboard,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 3, 1, 3),
              hintText: title,
              hintStyle: TextStyle(color: Colors.black26),
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Color.fromARGB(
                239,
                239,
                239,
                239,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
