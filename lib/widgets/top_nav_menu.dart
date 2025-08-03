import 'package:flutter/material.dart';

class TopNavMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const TopNavMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final List<_MenuItem> _menuItems = const [
    _MenuItem(icon: Icons.home, label: 'Beranda'),
    _MenuItem(icon: Icons.calendar_month, label: 'Kalkulator Selametan'),
    _MenuItem(icon: Icons.event, label: 'Hitung Weton'),
    _MenuItem(icon: Icons.help_outline, label: 'Bantuan Penggunaan'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_menuItems.length * 2 - 1, (i) {
        if (i.isOdd) {
          // Tambahkan jarak antar ikon
          return const SizedBox(width: 12); // Atur lebar sesuai selera (misal 16)
        }

        final index = i ~/ 2;
        final isActive = selectedIndex == index;
        final item = _menuItems[index];
        return IconButton(
          icon: Icon(item.icon,
              color: isActive ? Colors.deepPurple : Colors.black),
          tooltip: item.label,
          onPressed: () => onItemSelected(index),
        );
      }),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  const _MenuItem({required this.icon, required this.label});
}
