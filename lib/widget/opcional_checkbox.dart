import 'package:flutter/material.dart';

class OpcionalCheckbox extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final bool valor;
  final ValueChanged<bool> onChanged;

  const OpcionalCheckbox({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.valor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(titulo),
      subtitle: Text(subtitulo),
      value: valor,
      onChanged: (v) => onChanged(v ?? false),
    );
  }
}
