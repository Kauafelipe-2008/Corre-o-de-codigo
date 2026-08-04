import 'package:desafio_testes_dart/models/usuario.dart';
import 'package:test/test.dart';

void main() {
  group('Usuario', () {
    test('cria usuário com e-mail válido', () {
      final usuario = Usuario(id: 1, nome: 'Carlos', email: 'carlos@escola.com');
      expect(usuario.email, 'carlos@escola.com');
    });

    test('rejeita e-mail inválido', () {
      expect(
        () => Usuario(id: 1, nome: 'Carlos', email: 'email-invalido'),
        throwsArgumentError,
      );
    });

    test('permite empréstimo abaixo do limite', () {
      final usuario = Usuario(
        id: 1,
        nome: 'Carlos',
        email: 'carlos@escola.com',
        limiteEmprestimos: 3,
      );
      expect(usuario.podeRealizarEmprestimo(2), isTrue);
    });

    test('não permite empréstimo no limite', () {
      final usuario = Usuario(
        id: 1,
        nome: 'Carlos',
        email: 'carlos@escola.com',
        limiteEmprestimos: 3,
      );
      expect(usuario.podeRealizarEmprestimo(3), isFalse);
    });

    test('usuário desativado não pode emprestar', () {
      final usuario = Usuario(id: 1, nome: 'Carlos', email: 'carlos@escola.com');
      usuario.desativar();
      expect(usuario.podeRealizarEmprestimo(0), isFalse);
    });
  });
}
