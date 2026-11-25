import 'package:material_ui/material_ui.dart';

class ExpenseCategory {
  final String name;
  final IconData icon;
  final Color color;

  const ExpenseCategory({
    required this.name,
    required this.icon,
    required this.color,
  });
}

const List<ExpenseCategory> expenseCategories = [
  ExpenseCategory(
      name: 'Food and Drinks',
      icon: Icons.restaurant,
      color: Color(0xFFF28B50)),
  ExpenseCategory(
      name: 'Transportation',
      icon: Icons.directions_bus,
      color: Color(0xFF4C8DF6)),
  ExpenseCategory(
      name: 'School Expenses',
      icon: Icons.school,
      color: Color(0xFF8E6CF0)),
  ExpenseCategory(
      name: 'Bills and Utilities',
      icon: Icons.receipt_long,
      color: Color(0xFFE5B93C)),
  ExpenseCategory(
      name: 'Shopping',
      icon: Icons.shopping_bag,
      color: Color(0xFFE0568B)),
  ExpenseCategory(
      name: 'Health', icon: Icons.favorite, color: Color(0xFF3DB38A)),
  ExpenseCategory(
      name: 'Entertainment', icon: Icons.movie, color: Color(0xFF9B59D0)),
  ExpenseCategory(
      name: 'Others', icon: Icons.more_horiz, color: Color(0xFF7A8A94)),
];

const List<String> paymentMethods = ['Cash', 'GCash', 'Debit Card'];

/// Find a category by its name (falls back to "Others").
ExpenseCategory categoryByName(String name) {
  return expenseCategories.firstWhere(
    (c) => c.name == name,
    orElse: () => expenseCategories.last,
  );
}