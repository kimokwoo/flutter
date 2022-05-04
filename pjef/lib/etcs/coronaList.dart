import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pjef/drawers/mainDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pjef/models/coronaInfoModel.dart';
import 'package:pjef/models/teacherModel.dart';
import 'package:pjef/models/commonModel.dart';

class CoronaList extends StatefulWidget {
  const CoronaList({Key? key}) : super(key: key);

  @override
  _CoronaListState createState() => _CoronaListState();
}

class _CoronaListState extends State<CoronaList> {
  late Future<CoronaInfoModel> coronaInfo;
  final coronaListKey = GlobalKey<_CoronaListState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    coronaInfo = getCoronaList();
  }

  Future<CoronaInfoModel> getCoronaList() async {
    http.Response response;
    CoronaInfoModel coronaInfoModel;
    var url = Uri.parse("http://pjef.org/api/api_getcoronalist.php");

    response = await http.post(url);
    if (kDebugMode) {
      print(response.body);
    }
    coronaInfoModel = CoronaInfoModel.fromJson(jsonDecode(response.body));

    return coronaInfoModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('코로나 현황'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        actions: [
          TextButton(onPressed: () {
            Get.offAllNamed('/coronaList/values?todo=update');
          }, child: Text("완치반영", style: TextStyle(
            color: Colors.white,
          ),),),
        ],
      ),
      drawer: MainDrawer(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: FutureBuilder<CoronaInfoModel>(
                future: coronaInfo,
                builder: (BuildContext context, AsyncSnapshot ss) {
                  if (!ss.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                      itemCount: ss.data?.coronaInfo.length,
                      itemBuilder: (context, int index) {
                        var data = ss.data?.coronaInfo[index];
                        return Card(
                          child: ListTile(
                            leading: Text(
                              data.gubun,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            title: Text(
                              "${data.name} ${data.banbunho}",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 2.0, bottom: 2.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.tel),
                                  Text("발생일 : ${data.fromdate}"),
                                  Text("재등교 : ${data.enddate}"),

                                ],
                              ),
                            ),
                            trailing: Text(data.status),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
