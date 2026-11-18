import 'package:material_ui/material_ui.dart';

final List<BottomNavigationBarItem> studentNavigations = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.grid_view_outlined),
    activeIcon: Icon(Icons.grid_view),
    label: 'Services',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.calendar_month_outlined),
    activeIcon: Icon(Icons.calendar_month),
    label: 'Appointments',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.confirmation_number_outlined),
    activeIcon: Icon(Icons.confirmation_number),
    label: 'Queue',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.receipt_long_outlined),
    activeIcon: Icon(Icons.receipt_long),
    label: 'History',
  ),
];

final List<BottomNavigationBarItem> staffNavigations = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.grid_view_outlined),
    activeIcon: Icon(Icons.grid_view),
    label: 'Services',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.calendar_month_outlined),
    activeIcon: Icon(Icons.calendar_month),
    label: 'Schedules',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.event_available_outlined),
    activeIcon: Icon(Icons.event_available),
    label: 'Appointments',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.confirmation_number_outlined),
    activeIcon: Icon(Icons.confirmation_number),
    label: 'Queue',
  ),
];
