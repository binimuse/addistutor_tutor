// ignore: file_names
// ignore_for_file: non_constant_identifier_names

class DropDownCommenModel {
  late String id;
  late String name;
  String? education_levels_status;
  String? description;

  String? skillProficiency;
  String? labourId;

  //late String ad_banners;

  DropDownCommenModel(
      {required this.id,
      required this.name,
      //education
      this.education_levels_status,
      this.description,

      //Skill

      this.skillProficiency,
      this.labourId});
}
