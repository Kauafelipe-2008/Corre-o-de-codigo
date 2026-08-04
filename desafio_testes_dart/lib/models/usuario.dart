import '../utils/validador.dart';

class Usuario {
  final int id;
  String nome;
  String email;
  int limiteEmprestimos;
  bool ativo;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    this.limiteEmprestimos = 3,
    this.ativo = true,
  }) {
    if (!Validador.emailValido(email)) {
      throw ArgumentError('E-mail inválido: $email');
    }

    if (limiteEmprestimos < 0) {
      limiteEmprestimos = 0;
    }
  }

  bool podeRealizarEmprestimo(int quantidadeAtual) {
    return ativo && quantidadeAtual < limiteEmprestimos;
  }

 void desativar() {
  ativo = false;

  }

  @override
  String toString() => '$nome <$nome>';
}
