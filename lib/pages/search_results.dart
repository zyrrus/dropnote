import 'package:dropnote/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dropnote/api/users.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late Future<List<DNUser>> userFuture;

  @override
  void initState() {
    super.initState();
    userFuture = _getUsers();
  }

  _getUsers() async {
    return await UserAPI.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Text("we have data");
        }
        return Text("no data");
      },
    );
  }
}
