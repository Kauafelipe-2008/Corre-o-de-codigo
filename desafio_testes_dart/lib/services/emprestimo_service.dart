import '../models/emprestimo.dart';
import '../models/livro.dart';
import '../models/usuario.dart';

class EmprestimoService {
  final List<Emprestimo> _emprestimos = [];

  List<Emprestimo> get emprestimos => _emprestimos;

  Emprestimo realizarEmprestimo({
    required int id,
    required Usuario usuario,
    required Livro livro,
    required DateTime data,
  }) {
    final ativosDoUsuario = _emprestimos
    .where((item) =>
        item.usuario.id == usuario.id &&
        item.status == StatusEmprestimo.ativo)
    .length;

if (!usuario.podeRealizarEmprestimo(ativosDoUsuario)) {
  throw StateError('Usuário atingiu o limite de empréstimos.');
}

    if (!livro.estaDisponivel) {
      throw StateError('Livro indisponível.');
    }

    livro.retirarExemplar();

    final emprestimo = Emprestimo(
      id: id,
      usuario: usuario,
      livro: livro,
      dataEmprestimo: data,
      dataPrevistaDevolucao: data.add(const Duration(days: 7)),
    );

    _emprestimos.add(emprestimo);
    return emprestimo;
  }

  void devolver({required int emprestimoId, required DateTime data}) {
    final emprestimo =
        _emprestimos.firstWhere((item) => item.id == emprestimoId);

    emprestimo.registrarDevolucao(data);
    emprestimo.livro.devolverExemplar();
  }

  List<Emprestimo> listarAtrasados(DateTime referencia) {
  return _emprestimos
      .where((emprestimo) => emprestimo.estaAtrasado(referencia))
      .toList();
}
}
