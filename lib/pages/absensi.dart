import 'package:absensi_app/models/absen_model.dart';
import 'package:absensi_app/database/database_absen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../firestore_services.dart';

class Absensi extends StatefulWidget {
  const Absensi({Key? key}) : super(key: key);

  @override
  State<Absensi> createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> {
  DateTime now = DateTime.now();
  DatabaseAbsensi databaseAbsensi = DatabaseAbsensi();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // absensi(String today, String currentHour) async {
  //   Future<List<AbsenModel>> data = databaseAbsensi!.all();
  //   List<AbsenModel> value = await data;
  //
  //   if (value.isNotEmpty) {
  //     var latestDate =
  //     DateFormat("EEEE, dd MMMM yyyy", ).parse(value.last.today!);
  //     if (latestDate.day == now.day) {
  //       EasyLoading.showError("Anda sudah absen untuk hari ini",
  //           dismissOnTap: true);
  //       return;
  //     }
  //   }
  //   setState(() {});
  //   await databaseAbsensi.insert({
  //     "today": today,
  //     "come_in": currentHour,
  //     "come_out": "-",
  //   });
  // }

  // absensiKeluar(String today, String currentHour) async {
  //   Future<List<AbsenModel>> data = databaseAbsensi!.all();
  //   List<AbsenModel> value = await data;
  //
  //   if (value.isEmpty) {
  //     EasyLoading.showError("Absensi masih kosong",
  //         dismissOnTap: true);
  //     return;
  //   }
  //   await databaseAbsensi.update(value.last.id!, {
  //     "come_out": currentHour,
  //   });
  //   setState(() {});
  // }
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getDataFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.collection("absensi").get();
    return querySnapshot.docs;
  }

  selectId() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        await getDataFromFirestore();
    var id = documents.last.id;
    // List<AbsenModel> myModels = documents.map((doc) => AbsenModel.fromSnapshot(doc)).toList();
    // List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = await getDataFromFirestore();
    // List<QueryDocumentSnapshot<Map<String,dynamic>>> myModels = documents.map((docs) => AbsenModel.fromSnapshot(doc)).toList();
    // final data = await FirebaseFirestore.instance.collection("absensi").id;
    // // List<AbsenModel> result = data.map((e) => AbsenModel.fromJson(e)).toList();
    //
    // var result = data.map((e) => AbsenModel.fromSnapshot(e)).toList();
    return id;
  }

  Future initDatabase() async {
    await databaseAbsensi!.database();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    databaseAbsensi.database();
    databaseAbsensi = DatabaseAbsensi();
    initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('EEEE, dd MMMM yyyy');
    final String formattedDate = formatter.format(now);

    String formattedHour = DateFormat('HH:mm').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text("Absensi"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Align(
                child: Column(
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                FirestoreService.addAbsensi(AbsenModel(
                                    today: formattedDate,
                                    comeIn: formattedHour,
                                    comeOut: '-'));
                                // absensi(formattedDate, formattedHour);
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5), // Set the border radius of the button
                                ),
                              )),
                              child: Text("Absen Masuk"),
                            )),
                        SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () async {
                                List<
                                        QueryDocumentSnapshot<
                                            Map<String, dynamic>>> documents =
                                    await getDataFromFirestore();
                                var id = documents.last.id;
                                print(id);
                                FirestoreService.editAbsensi(
                                    {"come_out" : formattedHour},
                                    id);
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5), // Set the border radius of the button
                                ),
                              )),
                              child: Text("Absen Keluar"),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Riwayat Presensi",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    FirebaseFirestore.instance.collection("absensi").snapshots(),
                builder: (context, snapshot) {
                  try {
                     
                    if (snapshot.data!.docs.length <= 0) {
                      return Center(
                        child: Text("Data Kosong"),
                      );
                    }
                    if (snapshot.hasData) {
                      var valueAbsen = snapshot.data!.docs
                          .map((absensi) => AbsenModel.fromSnapshot(absensi))
                          .toList();
                      return ListView.builder(
                          itemCount: valueAbsen.length,
                          itemBuilder: (context, index) {
                            var id = snapshot.data!.docs[index].id;
                            return SizedBox(
                              height: 80,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(valueAbsen[index].today!),
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(valueAbsen[index].comeIn!),
                                              Text("Masuk"),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(valueAbsen[index].comeOut!),
                                              Text("keluar"),
                                            ],
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                    
                  } catch (e) {
                    print(e); 
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
            // databaseAbsensi != null
            //     ? FutureBuilder<List<AbsenModel>>(
            //         future: databaseAbsensi!.all(),
            //         builder: (context, snapshot) {
            //           if (snapshot.hasData) {
            //             if (snapshot.data!.length == 0) {
            //               return Expanded(
            //                 child: Center(
            //                   child: Text("Absensi masih kosong"),
            //                 ),
            //               );
            //             }
            //             // Membalikkan data agar data yg terbaru tampil di atas
            //             var data = snapshot.data!.reversed.toList();
            //             return Expanded(
            //               child: ListView.builder(
            //                 itemCount: snapshot.data!.length,
            //                 itemBuilder: (context, index) {
            //                   return SizedBox(
            //                     height: 80,
            //                     child: Card(
            //                       child: Padding(
            //                         padding: const EdgeInsets.all(8.0),
            //                         child: Row(
            //                           children: [
            //                             Text(data[index].today!),
            //                             Expanded(
            //                                 child: Row(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment.spaceEvenly,
            //                               children: [
            //                                 Column(
            //                                   mainAxisAlignment: MainAxisAlignment.center,
            //                                   children: [
            //                                     Text(data[index].comeIn!),
            //                                     Text("Masuk"),
            //                                   ],
            //                                 ),
            //                                 Column(
            //                                     mainAxisAlignment: MainAxisAlignment.center,
            //                                   children: [
            //                                     Text(data[index].comeOut!),
            //                                     Text("keluar"),
            //                                   ],
            //                                 )
            //                               ],
            //                             ))
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 },
            //               ),
            //             );
            //           }
            //           if (snapshot.hasError) {
            //             Center(child: Text("${snapshot.error}"));
            //           }
            //           return Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         },
            //       )
            //     : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
