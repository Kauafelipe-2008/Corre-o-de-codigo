import 'package:desafio_testes_dart/models/livro.dart';
import 'package:desafio_testes_dart/repositories/livro_repository.dart';
import 'package:test/test.dart';

void main() {
  group('LivroRepository', () {
    late LivroRepository repository;
    late Livro livro1;
    late Livro livro2;

    setUp(() async {
      repository = LivroRepository();
      livro1 = Livro(
        id: 1,
        titulo: 'Introdução ao Dart',
        autor: 'Ana',
        anoPublicacao: 2023,
        quantidadeTotal: 2,
      );
      livro2 = Livro(
        id: 2,
        titulo: 'Testes Automatizados',
        autor: 'Bruno',
        anoPublicacao: 2024,
        quantidadeTotal: 1,
      );
      await repository.salvar(livro1);
      await repository.salvar(livro2);
    });

    test('busca livro pelo ID correto', () {
      expect(repository.buscarPorId(2), equals(livro2));
    });

    test('retorna nulo para ID inexistente', () {
      expect(repository.buscarPorId(99), isNull);
    });

    test('pesquisa parte do título sem diferenciar maiúsculas', () {
      expect(repository.buscarPorTitulo('dart'), contains(livro1));
    });

    test('remove livro existente', () async {
      expect(await repository.remover(1), isTrue);
      expect(repository.buscarPorId(1), isNull);
    });

    test('listarTodos não permite alterar o repositório por fora', () {
      final lista = repository.listarTodos();
      lista.clear();
      expect(repository.listarTodos(), hasLength(2));
    });
  });
}
