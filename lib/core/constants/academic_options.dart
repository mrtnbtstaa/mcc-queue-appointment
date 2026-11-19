/// Backend-aligned academic choices for student accounts.
///
/// Values mirror `Course` and `YearLevel` from
/// `apps/authentication/models.py` in the backend.
class AcademicOption {
  const AcademicOption(this.value, this.label);

  final String value;
  final String label;
}

const List<AcademicOption> courseOptions = [
  AcademicOption('bsit', 'BSIT'),
  AcademicOption('bshm', 'BSHM'),
  AcademicOption('bstm', 'BSTM'),
  AcademicOption('bsa', 'BSA'),
  AcademicOption('bsca', 'BSCA'),
  AcademicOption('bse', 'BSE'),
  AcademicOption('bsma', 'BSMA'),
  AcademicOption('bsoa', 'BSOA'),
  AcademicOption('beed', 'BEED'),
  AcademicOption('beced', 'BECED'),
  AcademicOption('bsed-english', 'BSED English'),
  AcademicOption('bsed-filipino', 'BSED Filipino'),
  AcademicOption('bsed-math', 'BSED Math'),
  AcademicOption('bsed-science', 'BSED Science'),
  AcademicOption('bsed-social-studies', 'BSED Social Studies'),
  AcademicOption('bped', 'BPED'),
  AcademicOption('btvte', 'BTVTE'),
  AcademicOption('ab-history', 'AB History'),
  AcademicOption('ab-psychology', 'AB Psychology'),
  AcademicOption('bpa', 'BPA'),
  AcademicOption('bsbio', 'BSBIO'),
  AcademicOption('bslm', 'BSLM'),
];

const List<AcademicOption> yearLevelOptions = [
  AcademicOption('1', 'First Year'),
  AcademicOption('2', 'Second Year'),
  AcademicOption('3', 'Third Year'),
  AcademicOption('4', 'Fourth Year'),
];

/// Maps a stored value (code, label, or casing variant) to the backend code.
String? normalizeAcademicValue(List<AcademicOption> options, String raw) {
  final value = raw.trim();
  if (value.isEmpty) return null;

  final lower = value.toLowerCase();
  for (final option in options) {
    if (option.value == lower || option.label.toLowerCase() == lower) {
      return option.value;
    }
  }
  return value;
}
