
import 'package:flutter/material.dart';
import 'package:zoftcares/models/version.dart';

class VersionWidget extends StatelessWidget {
  const VersionWidget({
    super.key,
    required this.versionModel,
  });

  final Future<VersionModel> versionModel;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        const Text("Version: "),
        FutureBuilder(
          future: versionModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("......");
            } else if (snapshot.hasError) {
              return Text("Could not get Version, Try Later\n${snapshot.error}");
            } else if (snapshot.data != null) {
              return Text(snapshot.data?.data?["version"]);
            }
            return const Text("Error");
          },
        ),
      ],
    );
  }
}
