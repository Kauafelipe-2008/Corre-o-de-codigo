import 'livro.dart';
import 'usuario.dart';

enum StatusEmprestimo { ativo, devolvido, atrasado, cancelado }

class Emprestimo {
  final int id;
  final Usuario usuario;
  final Livro livro;
  final DateTime dataEmprestimo;
  DateTime dataPrevistaDevolucao;
  DateTime? dataDevolucao;
  StatusEmprestimo status;

  Emprestimo({
    required this.id,
    required this.usuario,
    required this.livro,
    required this.dataEmprestimo,
    required this.dataPrevistaDevolucao,
    this.dataDevolucao,
   this.status = StatusEmprestimo.ativo,
  });

  bool estaAtrasado(DateTime referencia) {
    return referencia.isAfter(dataPrevistaDevolucao) ||
        referencia.isAtSameMomentAs(dataPrevistaDevolucao);
  }

 int diasDeAtraso(DateTime referencia) {
  return referencia.difference(dataPrevistaDevolucao).inDays;
}

  void registrarDevolucao(DateTime data) {
  dataDevolucao = data;
  status = StatusEmprestimo.devolvido;
}

  void renovar(int dias) {
  dataPrevistaDevolucao =
      dataPrevistaDevolucao.add(Duration(days: dias));
}
}
