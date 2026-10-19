import 'package:flutter/material.dart';

class OpcionalSwitch extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final bool valor;
  final ValueChanged<bool> onChanged;

  const OpcionalSwitch({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.valor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(titulo),
      subtitle: Text(subtitulo),
      value: valor,
      onChanged: onChanged,
    );
  }
}
