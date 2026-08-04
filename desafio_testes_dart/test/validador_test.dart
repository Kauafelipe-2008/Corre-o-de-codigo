import 'package:desafio_testes_dart/utils/validador.dart';
import 'package:test/test.dart';

void main() {
  group('Validador', () {
    test('aceita e-mail válido', () {
      expect(Validador.emailValido('aluno@escola.com'), isTrue);
    });

    test('rejeita e-mail sem domínio', () {
      expect(Validador.emailValido('aluno@'), isFalse);
    });

    test('rejeita texto somente com espaços', () {
      expect(Validador.textoNaoVazio('   '), isFalse);
    });

    test('aceita ano passado', () {
      expect(Validador.anoPublicacaoValido(2020, anoAtual: 2026), isTrue);
    });

    test('rejeita ano futuro', () {
      expect(Validador.anoPublicacaoValido(2030, anoAtual: 2026), isFalse);
    });

    test('rejeita quantidade negativa', () {
      expect(Validador.quantidadeValida(-2), isFalse);
    });
  });
}
