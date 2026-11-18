import '../../domain/entities/service_entity.dart';

class ServiceDto {
  const ServiceDto({
    this.id,
    required this.name,
    required this.category,
    required this.fee,
    required this.durationMin,
    required this.durationMax,
    required this.requiredDocuments,
    required this.isActive,
  });

  factory ServiceDto.fromJson(Map<String, dynamic> json) {
    return ServiceDto(
      id: json['id']?.toString(),
      name: json['name'] as String,
      category: json['category'] as String,
      fee: json['fee'].toString(),
      durationMin: (json['duration_min'] as num).toInt(),
      durationMax: (json['duration_max'] as num).toInt(),
      requiredDocuments: List<String>.from(json['required_documents'] ?? []),
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  factory ServiceDto.fromDomain(ServiceEntity entity) {
    return ServiceDto(
      id: entity.id,
      name: entity.name,
      category: entity.category,
      fee: entity.fee,
      durationMin: entity.durationMin,
      durationMax: entity.durationMax,
      requiredDocuments: entity.requiredDocuments,
      isActive: entity.isActive,
    );
  }

  final String? id;
  final String name;
  final String category;
  final String fee;
  final int durationMin;
  final int durationMax;
  final List<String> requiredDocuments;
  final bool isActive;

  Map<String, dynamic> toJson() {
    return {
      // Don't send ID on creation
      if (id != null) 'id': id,
      'name': name,
      'category': category,
      'fee': fee,
      'duration_min': durationMin,
      'duration_max': durationMax,
      'required_documents': requiredDocuments,
      'is_active': isActive,
    };
  }

  ServiceEntity toDomain() {
    return ServiceEntity(
      id: id,
      name: name,
      category: category,
      fee: fee,
      durationMin: durationMin,
      durationMax: durationMax,
      requiredDocuments: requiredDocuments,
      isActive: isActive,
    );
  }
}
