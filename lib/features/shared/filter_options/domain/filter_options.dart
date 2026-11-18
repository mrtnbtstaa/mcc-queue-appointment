class FilterOption {
  final String value;
  final String label;

  const FilterOption({required this.value, required this.label});

  factory FilterOption.fromJson(Map<String, dynamic> json) {
    return FilterOption(
      value: json['value']?.toString() ?? '',
      label: json['label']?.toString() ?? '',
    );
  }
}

class FilterOptions {
  final List<FilterOption> courses;
  final List<FilterOption> serviceCategories;
  final List<FilterOption> appointmentStatuses;
  final List<FilterOption> queueStatuses;

  const FilterOptions({
    this.courses = const [],
    this.serviceCategories = const [],
    this.appointmentStatuses = const [],
    this.queueStatuses = const [],
  });

  factory FilterOptions.fromJson(Map<String, dynamic> json) {
    return FilterOptions(
      courses: _options(json['courses']),
      serviceCategories: _options(json['service_categories']),
      appointmentStatuses: _options(json['appointment_statuses']),
      queueStatuses: _options(json['queue_statuses']),
    );
  }

  static List<FilterOption> _options(Object? raw) {
    return (raw as List? ?? const [])
        .map((item) => FilterOption.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
