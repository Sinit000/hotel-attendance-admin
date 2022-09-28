import 'package:hotle_attendnce_admin/src/feature/structuretype/model/structuretype_model.dart';

class StructureModel {
  final String id;
  final String? name;
  final String? baseSalary;
  final String? allowance;
  // final String? currency;
  // final String? structuretypeId;
  // final StructuretypeModel? structuretypeModel;
  factory StructureModel.fromJson(Map<String, dynamic> json) {
    return StructureModel(
      id: json["id"].toString(),
      name: json["name"],
      baseSalary: json["base_salary"].toString(),
      allowance: json["allowance"].toString(),
      // currency: json["currency"],
      // structuretypeId: json["structure_type_id"].toString(),
      // structuretypeModel: json["type"] == null
      //     ? null
      //     : StructuretypeModel.fromJson(json["type"])
    );
  }
  StructureModel({
    required this.id,
    required this.name,
    required this.baseSalary,
    required this.allowance,
    // required this.currency,
    // required this.structuretypeId,
    // required this.structuretypeModel
  });
}
