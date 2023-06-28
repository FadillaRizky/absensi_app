import 'package:absensi_app/absen_model.dart';
import 'package:absensi_app/database_absen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Absensi extends StatefulWidget {
  const Absensi({Key? key}) : super(key: key);

  @override
  State<Absensi> createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> {
  DateTime now = DateTime.now();
  DatabaseAbsensi databaseAbsensi = DatabaseAbsensi();

  absensi(String today, String currentHour) async {
    Future<List<AbsenModel>> data = databaseAbsensi!.all();
    List<AbsenModel> value = await data;

    if (value.isNotEmpty) {
      var latestDate =
      DateFormat("EEEE, dd MMMM yyyy", ).parse(value.last.today!);
      if (latestDate.day == now.day) {
        EasyLoading.showError("Anda sudah absen untuk hari ini",
            dismissOnTap: true);
        return;
      }
    }  
    setState(() {});
    await databaseAbsensi.insert({
      "today": today,
      "come_in": currentHour,
      "come_out": "-",
    });
  }

  absensiKeluar(String today, String currentHour) async {
    Future<List<AbsenModel>> data = databaseAbsensi!.all();
    List<AbsenModel> value = await data;
    
    if (value.isEmpty) {
      EasyLoading.showError("Absensi masih kosong",
          dismissOnTap: true);
      return;
    }
    await databaseAbsensi.update(value.last.id!, {
      "come_out": currentHour,
    });
    setState(() {});
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
                                absensi(formattedDate, formattedHour);
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
                              onPressed: () {
                                absensiKeluar(formattedDate, formattedHour);
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
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            databaseAbsensi != null
                ? FutureBuilder<List<AbsenModel>>(
                    future: databaseAbsensi!.all(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.length == 0) {
                          return Expanded(
                            child: Center(
                              child: Text("Absensi masih kosong"),
                            ),
                          );
                        }
                        // Membalikkan data agar data yg terbaru tampil di atas
                        var data = snapshot.data!.reversed.toList();
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 80,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(data[index].today!),
                                        Expanded(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(data[index].comeIn!),
                                                Text("Masuk"),
                                              ],
                                            ),
                                            Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(data[index].comeOut!),
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
                            },
                          ),
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
          ],
        ),
      ),
    );
  }
}
