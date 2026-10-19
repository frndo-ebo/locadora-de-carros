import 'package:flutter/material.dart';

String moeda(double valor) => 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';

class ResumoLocacao extends StatelessWidget {
  final String veiculo;
  final int dias;
  final bool seguro;
  final bool gps;
  final bool motorista;
  final double valorBruto;
  final int descontoPercentual;
  final double desconto;
  final double valorFinal;
  final String categoria;

  const ResumoLocacao({
    super.key,
    required this.veiculo,
    required this.dias,
    required this.seguro,
    required this.gps,
    required this.motorista,
    required this.valorBruto,
    required this.descontoPercentual,
    required this.desconto,
    required this.valorFinal,
    required this.categoria,
  });

  String _simNao(bool v) => v ? 'Sim' : 'Não';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Linha('Veículo', veiculo),
        _Linha('Dias', '$dias'),
        _Linha('Seguro', _simNao(seguro)),
        _Linha('GPS', _simNao(gps)),
        _Linha('Motorista adicional', _simNao(motorista)),
        const Divider(),
        _Linha('Valor bruto', moeda(valorBruto)),
        _Linha('Desconto ($descontoPercentual%)', '- ${moeda(desconto)}'),
        _Linha('Valor final', moeda(valorFinal), destaque: true),
        const Divider(),
        _Linha('Categoria', categoria, destaque: true),
      ],
    );
  }
}

class _Linha extends StatelessWidget {
  final String titulo;
  final String valor;
  final bool destaque;

  const _Linha(this.titulo, this.valor, {this.destaque = false});

  @override
  Widget build(BuildContext context) {
    final estilo = TextStyle(
      fontWeight: destaque ? FontWeight.bold : FontWeight.normal,
      fontSize: destaque ? 16 : 14,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titulo, style: estilo),
          Text(valor, style: estilo),
        ],
      ),
    );
  }
}
