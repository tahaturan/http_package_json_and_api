import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_package_json_and_api/model/user_model.dart';

class RemoteApi extends StatefulWidget {
  const RemoteApi({Key? key}) : super(key: key);

  @override
  State<RemoteApi> createState() => _RemoteApiState();
}

class _RemoteApiState extends State<RemoteApi> {
  Future<List<UserModel>> _getUserList() async {
    try {
      var response =
          await Dio().get("https://jsonplaceholder.typicode.com/users");
      List<UserModel> userList = [];
      if (response.statusCode == 200) {
        userList =
            (response.data as List).map((e) => UserModel.fromMap(e)).toList();
      }
      return userList;
    } on DioError catch (e) {
      return Future.error(e.message);
    }
  }

  late final Future<List<UserModel>> _userList;

  @override
  void initState() {
    super.initState();
    _userList = _getUserList();
  }

  @override
  Widget build(BuildContext context) {
    _getUserList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote Api With Dio'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _userList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<UserModel> userList = snapshot.data;
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (BuildContext context, int index) {
                var user = userList[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  leading: CircleAvatar(
                    child: Text(user.id.toString()),
                  ),
                  trailing: Text(user.username),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
