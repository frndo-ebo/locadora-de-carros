import 'package:flutter/material.dart';  
import 'widget/dias_slider.dart';  
import 'widget/opcional_checkbox.dart';  
import 'widget/opcional_switch.dart';  
import 'widget/resumo_locacao.dart';  
import 'widget/seletor_veiculo.dart';  
  
void main() => runApp(const LocadoraApp());  
  
class LocadoraApp extends StatelessWidget {  
  const LocadoraApp({super.key});  
  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      debugShowCheckedModeBanner: false,  
      title: 'Locadora de Carros',  
      theme: ThemeData(  
        colorSchemeSeed: Colors.indigo,  
        useMaterial3: true,  
      ),  
      home: const TelaLocacao(),  
    );  
  }  
}  
  
class TelaLocacao extends StatefulWidget {  
  const TelaLocacao({super.key});  
  
  @override  
  State<TelaLocacao> createState() => _TelaLocacaoState();  
}  
  
class _TelaLocacaoState extends State<TelaLocacao> {  
  Veiculo veiculo = Veiculo.economico;  
  bool seguro = false;  
  bool gps = false;  
  bool motorista = false;  
  int dias = 1;  
  
  // ---------- Cálculos ----------  
  double get valorDiario =>  
      veiculo.precoDia + (seguro ? 40 : 0) + (gps ? 15 : 0);  
  
  double get valorBruto => valorDiario * dias + (motorista ? 100 : 0);  
  
  int get descontoPercentual {  
    if (dias >= 15) return 10;  
    if (dias >= 7) return 5;  
    return 0;  
  }  
  
  double get desconto => valorBruto * descontoPercentual / 100;  
  
  double get valorFinal => valorBruto - desconto;  
  
  String get categoria {  
    if (valorFinal <= 1000) return 'Cliente Bronze';  
    if (valorFinal <= 3000) return 'Cliente Prata';  
    if (valorFinal <= 5000) return 'Cliente Ouro';  
    return 'Cliente Platinum';  
  }  
  
  // ---------- Resumo Reutilizável ----------  
  Widget get resumo => ResumoLocacao(  
        veiculo: veiculo.nome,  
        dias: dias,  
        seguro: seguro,  
        gps: gps,  
        motorista: motorista,  
        valorBruto: valorBruto,  
        descontoPercentual: descontoPercentual,  
        desconto: desconto,  
        valorFinal: valorFinal,  
        categoria: categoria,  
      );  
  
  void finalizarReserva() {  
    showDialog(  
      context: context,  
      builder: (dialogContext) => AlertDialog(  
        title: const Text('Confirmar reserva'),  
        content: SingleChildScrollView(child: resumo),  
        actions: [  
          TextButton(  
            onPressed: () => Navigator.pop(dialogContext),  
            child: const Text('Cancelar'),  
          ),  
          FilledButton(  
            onPressed: () {  
              Navigator.pop(dialogContext);  
              if (!mounted) return;  
              ScaffoldMessenger.of(context).showSnackBar(  
                const SnackBar(  
                  content: Text('Reserva realizada com sucesso!'),  
                  behavior: SnackBarBehavior.floating,  
                ),  
              );  
            },  
            child: const Text('Confirmar Reserva'),  
          ),  
        ],  
      ),  
    );  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Locadora de Carros'),  
        centerTitle: true,  
      ),  
      body: ListView(  
        padding: const EdgeInsets.all(16),  
        children: [  
          const Text(  
            'Escolha o veículo',  
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),  
          ),  
          const SizedBox(height: 8),  
          SeletorVeiculo(  
            selecionado: veiculo,  
            onChanged: (v) => setState(() => veiculo = v),  
          ),  
          const SizedBox(height: 16),  
          OpcionalCheckbox(  
            titulo: 'Seguro Completo',  
            subtitulo: '+ R\$ 40,00 por dia',  
            valor: seguro,  
            onChanged: (v) => setState(() => seguro = v),  
          ),  
          OpcionalCheckbox(  
            titulo: 'GPS',  
            subtitulo: '+ R\$ 15,00 por dia',  
            valor: gps,  
            onChanged: (v) => setState(() => gps = v),  
          ),  
          OpcionalSwitch(  
            titulo: 'Motorista Adicional',  
            subtitulo: 'Taxa fixa de R\$ 100,00',  
            valor: motorista,  
            onChanged: (v) => setState(() => motorista = v),  
          ),  
          const SizedBox(height: 8),  
          DiasSlider(  
            dias: dias,  
            onChanged: (v) => setState(() => dias = v),  
          ),  
          const SizedBox(height: 12),  
          Card(  
            elevation: 2,  
            child: Padding(  
              padding: const EdgeInsets.all(16),  
              child: Column(  
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [  
                  const Text(  
                    'Resumo da Locação',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                  ),  
                  const Divider(height: 20),  
                  resumo,  
                ],  
              ),  
            ),  
          ),  
          const SizedBox(height: 20),  
          FilledButton(  
            onPressed: finalizarReserva,  
            child: const Padding(  
              padding: EdgeInsets.all(14),  
              child: Text(  
                'Finalizar Reserva',  
                style: TextStyle(fontSize: 16),  
              ),  
            ),  
          ),  
        ],  
      ),  
    );  
  }  
}