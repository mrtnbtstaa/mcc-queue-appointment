import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  const ServiceEntity({
    this.id,
    required this.name,
    required this.category,
    required this.fee,
    required this.durationMin,
    required this.durationMax,
    required this.requiredDocuments,
    required this.isActive,
  });

  final String? id;
  final String name;
  final String category;
  final String fee;
  final int durationMin;
  final int durationMax;
  final List<String> requiredDocuments;
  final bool isActive;

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    fee,
    durationMin,
    durationMax,
    requiredDocuments,
    isActive,
  ];
}
