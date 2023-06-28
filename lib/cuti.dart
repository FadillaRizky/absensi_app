import 'package:absensi_app/absen_model.dart';
import 'package:absensi_app/cuti_model.dart';
import 'package:absensi_app/database_absen.dart';
import 'package:absensi_app/database_cuti.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Cuti extends StatefulWidget {
  const Cuti({Key? key}) : super(key: key);

  @override
  State<Cuti> createState() => _CutiState();
}

class _CutiState extends State<Cuti> {
  DatabaseCuti databaseCuti = DatabaseCuti();
  DatabaseCuti? databaseInstance;
  DateTime now = DateTime.now();
  DateTime? startCuti;
  DateTime? endCuti;

  tambahCuti(DateTime startCuti,DateTime endCuti) async {
    if (!startCuti.isBefore(endCuti)) {
      EasyLoading.showError("Tanggal mulai cuti tidak boleh lebih dari sampai cuti",dismissOnTap: true);
      return;
    }
    Future<List<CutiModel>> data = databaseInstance!.all();
    List<CutiModel> value = await data;
    await databaseCuti.insert({
      "start_cuti": startCuti.toString(),
      "end_cuti": endCuti.toString(),
    });
    setState(() {});
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    databaseCuti.database();
    databaseInstance = DatabaseCuti();
    initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(now);
    String formattedHour = DateFormat('HH:mm').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cuti"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
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
                        Container(
                          height: 40,
                          width: 150,
                          child: DateTimeFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20, 3, 1, 3),
                              hintText: "Mulai Cuti",
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
                            mode: DateTimeFieldPickerMode.date,
                            // autovalidateMode: AutovalidateMode.always,
                            // validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                            onDateSelected: (DateTime value) {
                              setState(() {
                                startCuti = value;
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 150,
                          child: DateTimeFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20, 3, 1, 3),
                              hintText: "Sampai Cuti",
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
                            mode: DateTimeFieldPickerMode.date,
                            // autovalidateMode: AutovalidateMode.always,
                            // validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                            onDateSelected: (DateTime value) {
                              setState(() {
                                endCuti = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            tambahCuti(startCuti!, endCuti!);
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // Set the border radius of the button
                            ),
                          )),
                          child: Text("Tambah Cuti"),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "List Cuti",
              style: TextStyle(fontSize: 20),
            ),
            databaseInstance != null
                ? FutureBuilder<List<CutiModel>>(
                    future: databaseInstance!.all(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.length == 0) {
                          return Expanded(
                            child: Center(
                              child: Text("Cuti masih kosong"),
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
                                        Expanded(child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Text(DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(data[index].startCuti!)).toString()),
                                                Text("Mulai"),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(data[index].endCuti!)).toString()),
                                                Text("Selesai"),
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
