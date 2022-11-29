class School {
  final String name;
  final String image;

  const School({required this.name, required this.image});
}

const List<School> _schools = [
  School(
      name: "Louisiana State University",
      image:
          "https://www.klfy.com/wp-content/uploads/sites/9/2019/07/lsu_logo2_400x400.jpg"),
  School(
      name: "University of Louisiana Lafayette",
      image:
          "https://pbs.twimg.com/profile_images/817127494788804608/SmY_ctJX_400x400.jpg"),
  School(
      name: "Tulane University",
      image:
          "https://pbs.twimg.com/profile_images/1116476139558572032/XJyCCQd4_400x400.jpg"),
  School(
      name: "McNeese State University",
      image:
          "https://upload.wikimedia.org/wikipedia/en/thumb/f/f7/McNeese_State_Athletics_logo.svg/1200px-McNeese_State_Athletics_logo.svg.png"),
];

class SchoolAPI {
  static List<String> getSchoolNames() {
    return _schools.map((e) => e.name).toList();
  }

  static List<School> getSchools() {
    return _schools;
  }

  static School? getSchool(String school) {
    school = school.trim().toLowerCase();
    return _schools.firstWhere((e) => e.name.toLowerCase() == school);
  }

  static List<School> querySchools(String query) {
    return _schools.where((e) => e.name.contains(query)).toList();
  }
}
