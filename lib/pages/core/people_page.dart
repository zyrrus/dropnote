import 'package:dropnote/api/apiMethod.dart';
import 'package:dropnote/api/user.dart';
import 'package:dropnote/pages/core/core_page.dart';
import 'package:dropnote/widgets/horizontal_list.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Number Formater
final formatter = NumberFormat('#,###,###.#k');
// final formatter = NumberFormat('#,###,###.##');

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> with TickerProviderStateMixin {
  // final _users = ApiMethod.getUsers();
  final List<User> _users = [
    User(
        'Ashleyy Palacios',
        'Example State University',
        'https://images.unsplash.com/photo-1504735217152-b768bcab5ebc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=0ec8291c3fd2f774a365c8651210a18b',
        false,
        2125),
    User(
        'Kayley Dwyer',
        'Example State University',
        'https://images.unsplash.com/photo-1503467913725-8484b65b0715?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=cf7f82093012c4789841f570933f88e3',
        false,
        561),
    User(
        'Kathleen Mcdonough',
        'Example State University',
        'https://images.unsplash.com/photo-1507081323647-4d250478b919?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=b717a6d0469694bbe6400e6bfe45a1da',
        false,
        54500),
    User(
        'Manuel Steuber',
        'Example State University',
        'https://images.unsplash.com/photo-1502980426475-b83966705988?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=ddcb7ec744fc63472f2d9e19362aa387',
        false,
        7442),
    User(
        'Rosie McLaughlin',
        'Example State University',
        'https://images.unsplash.com/photo-1541710430735-5fca14c95b00?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false,
        73000),
    User(
        'Mikayla Marquez',
        'Example State University',
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZSUyMHBpY3R1cmVzfGVufDB8fDB8fA%3D%3D&&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false,
        57),
    User(
        'Dr. Young Man',
        'Example State University',
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGUlMjBwaWN0dXJlc3xlbnwwfHwwfHw%3D&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false,
        747),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Transform(
        // Using Transform the translate title to lower
        transform: Matrix4.translationValues(0.0, 40.0, 0.0),
        child: HorizontalList(spacing: 12.0, children: ApiMethod.getTags()),
      ),
      appBar: AppBar(
          toolbarHeight: 100.0,
          elevation: 4,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Transform(
            // using Transform the translate title to align left
            transform: Matrix4.translationValues(-70.0, 0.0, 0.0),
            child: const TitleBar(title: "People", showBackButton: true),
          )),
      body: CoreTemplate(
        child: SizedBox(
          child: Container(
              padding: const EdgeInsets.only(top: 90, right: 20, left: 20),
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return userComponent(user: _users[index]);
                },
              )),
        ),
      ),
    );
  }

  userComponent({required User user}) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            SizedBox(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(user.image),
                )),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(user.name,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 5,
              ),
              Text(user.userSchool, style: TextStyle(color: Colors.grey[600])),
              Row(
                children: [
                  Text(' 📥', style: TextStyle(color: Colors.grey[600])),
                  Text(formatter.format(user.downloadCount).toString(),
                      style: TextStyle(color: Colors.grey[600])),
                ],
              )
            ])
          ]),
          Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffeeeeee)),
                borderRadius: BorderRadius.circular(50),
              ),
              child: MaterialButton(
                elevation: 0,
                color: user.isSelected
                    ? const Color(0xffeeeeee)
                    : const Color(0xffffff),
                onPressed: () {
                  setState(() {
                    user.isSelected = !user.isSelected;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(user.isSelected ? 'Delete' : 'Download',
                    style: const TextStyle(color: Colors.black)),
              ))
        ],
      ),
    );
  }
}
