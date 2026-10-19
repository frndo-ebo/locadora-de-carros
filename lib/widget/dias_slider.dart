import 'package:flutter/material.dart';

class DiasSlider extends StatelessWidget {
  final int dias;
  final ValueChanged<int> onChanged;

  const DiasSlider({super.key, required this.dias, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantidade de dias: $dias',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: dias.toDouble(),
          min: 1,
          max: 30,
          divisions: 29,
          label: '$dias',
          onChanged: (v) => onChanged(v.round()),
        ),
      ],
    );
  }
}
