enum AppointmentTab {
  all('All', null),
  pending('Pending', 'PENDING'),
  confirmed('Confirmed', 'CONFIRMED'),
  completed('Completed', 'COMPLETED'),
  cancelled('Cancelled', 'CANCELLED');

  const AppointmentTab(this.label, this.status);

  final String label;
  final String? status;
}
