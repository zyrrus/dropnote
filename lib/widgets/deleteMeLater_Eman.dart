// CoreTemplate(
//         child: SizedBox(
//             height: constrains.maxHeight,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   const TitleBar(
//                     title: "People",
//                     showBackButton: true,
//                     // onIconPressed: () {
//                     //   Navigator.pop(context);
//                     // }),
//                   ),
//                   const Padding(padding: EdgeInsets.only(bottom: 15)),
//                   HorizontalList(spacing: 10.0, children: getTags()),
//                   const Padding(padding: EdgeInsets.only(bottom: 10)),
//                   const Bar(),