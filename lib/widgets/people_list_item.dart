import 'package:dropnote/models/user.dart';
import 'package:dropnote/widgets/avatar_list_item.dart';
import 'package:flutter/widgets.dart';

class PeopleListItem extends StatelessWidget {
  final DNUser user;
  final bool isExpanded;

  const PeopleListItem({
    super.key,
    required this.user,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return (isExpanded)
        ? ExpandedProfile(
            name: user.name,
            school: user.school,
            profilePicture: user.profilePicture,
            numSaves: user.totalSaves ?? 0,
          )
        : AvatarListItem(
            imageURL: user.profilePicture,
            label: user.name,
          );
  }
}

class ExpandedProfile extends StatelessWidget {
  final String name;
  final String school;
  final String profilePicture;
  final int numSaves;

  const ExpandedProfile({
    super.key,
    required this.name,
    required this.school,
    required this.profilePicture,
    required this.numSaves,
  });

  @override
  Widget build(BuildContext context) {
    // temp
    return AvatarListItem(
      imageURL: profilePicture,
      label: name,
    );
  }
}
