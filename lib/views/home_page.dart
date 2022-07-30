import 'package:flutter/material.dart';
import 'package:http_package_json_and_api/views/local_json.dart';
import 'package:http_package_json_and_api/views/remote_api.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Json'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocalJson(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: const Text(
                "Local Json",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RemoteApi(),
                    ));
              },
              child: const Text(
                "Remote API",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
