class Validador {
  static bool emailValido(String email) {
    return email.contains('@') && email.endsWith('.com');
  }

  static bool textoNaoVazio(String valor) {
    return valor.trim().isNotEmpty;
  }

  static bool anoPublicacaoValido(int ano, {int? anoAtual}) {
    final atual = anoAtual ?? DateTime.now().year;
    return ano > 0 && ano <= atual;
  }

  static bool quantidadeValida(int quantidade) {
    return quantidade > 0;
  }
}
