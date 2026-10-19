import 'package:flutter/material.dart';

enum Veiculo {
  economico('Econômico', 120),
  suv('SUV', 180),
  luxo('Luxo', 300);

  final String nome;
  final double precoDia;
  const Veiculo(this.nome, this.precoDia);
}

class SeletorVeiculo extends StatelessWidget {
  final Veiculo selecionado;
  final ValueChanged<Veiculo> onChanged;

  const SeletorVeiculo({
    super.key,
    required this.selecionado,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Veiculo>(
      showSelectedIcon: false,
      segments: Veiculo.values.map((v) {
        return ButtonSegment<Veiculo>(
          value: v,
          label: Text(
            '${v.nome}\nR\$ ${v.precoDia.toStringAsFixed(0)}/dia',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        );
      }).toList(),
      selected: {selecionado},
      onSelectionChanged: (selecao) => onChanged(selecao.first),
    );
  }
}
