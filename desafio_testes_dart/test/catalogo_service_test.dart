import 'package:desafio_testes_dart/models/livro.dart';
import 'package:desafio_testes_dart/repositories/livro_repository.dart';
import 'package:desafio_testes_dart/services/catalogo_service.dart';
import 'package:test/test.dart';

void main() {
  group('CatalogoService', () {
    late LivroRepository repository;
    late CatalogoService service;

    setUp(() {
      repository = LivroRepository();
      service = CatalogoService(repository);
    });

    test('cadastra livro válido de forma assíncrona', () async {
      final livro = Livro(
        id: 1,
        titulo: 'Testes em Dart',
        autor: 'Equipe',
        anoPublicacao: 2025,
        quantidadeTotal: 2,
      );
      await service.cadastrarLivro(livro);
      expect(repository.buscarPorId(1), equals(livro));
    });

    test('rejeita título vazio', () async {
      final livro = Livro(
        id: 1,
        titulo: '   ',
        autor: 'Equipe',
        anoPublicacao: 2025,
        quantidadeTotal: 2,
      );
      expect(() => service.cadastrarLivro(livro), throwsArgumentError);
    });

    test('pesquisa termo parcial', () async {
      final livro = Livro(
        id: 1,
        titulo: 'Automação de Testes',
        autor: 'Equipe',
        anoPublicacao: 2025,
        quantidadeTotal: 2,
      );
      await repository.salvar(livro);
      expect(service.pesquisar('automação'), contains(livro));
    });
  });
}
