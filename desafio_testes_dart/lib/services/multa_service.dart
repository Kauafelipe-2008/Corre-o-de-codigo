import '../models/emprestimo.dart';

class MultaService {
  final double valorPorDia;
  final double valorMaximo;

  MultaService({this.valorPorDia = 2.50, this.valorMaximo = 50.00});

  double calcular(Emprestimo emprestimo, DateTime referencia) {
  if (!emprestimo.estaAtrasado(referencia)) {
    return 0;
  }

  final dias = emprestimo.diasDeAtraso(referencia);
  final total = dias * valorPorDia;

  if (total > valorMaximo) {
    return valorMaximo;
  }

  return total;
}
}
