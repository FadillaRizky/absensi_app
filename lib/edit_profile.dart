import 'package:flutter/material.dart';

import 'database_profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DatabaseProfile databaseInstance = DatabaseProfile();
  TextEditingController nameController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController bodController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController addressController = TextEditingController();


  @override
  void initState() {
    databaseInstance.database();
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
        child: Column(
          children: [
            ItemProfile(title: "NamaPanjang", controller: nameController, tipeKeyboard: TextInputType.text),
            ItemProfile(title: "NIK", controller: nikController, tipeKeyboard: TextInputType.text),
            ItemProfile(title: "Tanggal Lahir", controller: bodController, tipeKeyboard: TextInputType.text),
            ItemProfile(title: "Jabatan", controller: positionController, tipeKeyboard: TextInputType.text),
            ItemProfile(title: "Alamat", controller: addressController, tipeKeyboard: TextInputType.text),

            ElevatedButton(onPressed: ()async{
                await databaseInstance.insert({
                  "name" : nameController.text,
                  "nik" : nikController.text,
                  "bod" : bodController.text,
                  "position" : positionController.text,
                  "address" : addressController.text,
                });

            }, child: Text("Submit"))
          ],
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
        Text(title,style: TextStyle(fontSize: 18),),
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