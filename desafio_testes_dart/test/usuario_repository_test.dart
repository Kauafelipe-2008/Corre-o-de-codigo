import 'package:desafio_testes_dart/models/usuario.dart';
import 'package:desafio_testes_dart/repositories/usuario_repository.dart';
import 'package:test/test.dart';

void main() {
  group('UsuarioRepository', () {
    late UsuarioRepository repository;

    setUp(() {
      repository = UsuarioRepository();
    });

    test('busca usuário pelo mesmo id usado ao salvar', () {
      final usuario = Usuario(id: 1, nome: 'Ana', email: 'ana@escola.com');

      repository.salvar(usuario);

      expect(repository.buscarPorId(1), equals(usuario));
    });

    test('detecta e-mail já cadastrado', () {
      repository.salvar(Usuario(id: 1, nome: 'Ana', email: 'ana@escola.com'));

      expect(repository.existeEmail('ana@escola.com'), isTrue);
    });

    test('não aponta e-mail inexistente como cadastrado', () {
      repository.salvar(Usuario(id: 1, nome: 'Ana', email: 'ana@escola.com'));

      expect(repository.existeEmail('outro@escola.com'), isFalse);
    });

    test('lista apenas usuários ativos', () {
      final ativo = Usuario(id: 1, nome: 'Ana', email: 'ana@escola.com');
      final inativo = Usuario(id: 2, nome: 'Bruno', email: 'bruno@escola.com')
        ..desativar();

      repository.salvar(ativo);
      repository.salvar(inativo);

      expect(repository.listarAtivos(), contains(ativo));
      expect(repository.listarAtivos(), isNot(contains(inativo)));
    });
  });
}