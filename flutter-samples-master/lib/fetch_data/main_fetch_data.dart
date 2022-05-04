import 'dart:convert'; //JsonDecode를 사용하려면 불러와야함.

import 'package:flutter/material.dart';
import 'package:flutter_samples/fetch_data/photo.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class MainFetchData extends StatefulWidget {
  @override
  _MainFetchDataState createState() => _MainFetchDataState();
}

class _MainFetchDataState extends State<MainFetchData> {
  List<Photo> list = [];
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
      if(response.statusCode == 200) {
        list = (json.decode(response.body) as List)
            .map((data) => new Photo.fromJson(data)).toList();
      } else {
        throw Exception('사진 데이터 로딩에 실패');
      }

      setState(() {
        isLoading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fetch Data JSON"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            child: Text("Fetch Data"),
            onPressed: _fetchData,
          ),
        ),
        body: isLoading
            ? Center(
                child: SpinKitCircle(
                  color: Colors.grey[600],
                  size: 80.0,
                ),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: Text(list[index].title!),
                    trailing: Image.network(
                      list[index].thumbnailUrl!,
                      fit: BoxFit.cover,
                      height: 40.0,
                      width: 40.0,
                    ),
                  );
                }));
  }
}
