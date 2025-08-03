import 'package:flutter/material.dart';
import '../models/hari_variants.dart';

class VariantDropdown extends StatelessWidget {
  final HariVariant? selected;
  final ValueChanged<HariVariant?> onChanged;

  const VariantDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  }) ;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<HariVariant>(
      value: selected,
      hint: const Text("Pilih Varian Hari"),
      onChanged: onChanged,
      items: hariVariants.map((variant) {
        return DropdownMenuItem<HariVariant>(
          value: variant,
          child: Text(variant.label),
        );
      }).toList(),
    );
  }
}
