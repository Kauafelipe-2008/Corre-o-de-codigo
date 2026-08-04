import 'package:desafio_testes_dart/models/livro.dart';
import 'package:test/test.dart';

void main() {
  group('Livro', () {
    late Livro livro;

    setUp(() {
      livro = Livro(
        id: 1,
        titulo: 'Dart na Prática',
        autor: 'Maria',
        anoPublicacao: 2024,
        quantidadeTotal: 2,
      );
    });

    test('inicia com a quantidade total disponível', () {
      expect(livro.quantidadeDisponivel, 2);
    });

    test('fica indisponível quando chega a zero', () {
      livro.retirarExemplar();
      livro.retirarExemplar();
      expect(livro.estaDisponivel, isFalse);
    });

    test('não permite retirar quando não há exemplar', () {
      livro.retirarExemplar();
      livro.retirarExemplar();
      expect(() => livro.retirarExemplar(), throwsStateError);
    });

    test('devolver aumenta apenas um exemplar', () {
      livro.retirarExemplar();
      livro.devolverExemplar();
      expect(livro.quantidadeDisponivel, 2);
    });

    test('copyWith altera somente o título', () {
      final copia = livro.copyWith(titulo: 'Novo título');
      expect(copia.titulo, 'Novo título');
      expect(copia.autor, 'Maria');
    });

    test('livros com IDs diferentes não são iguais', () {
      final outro = Livro(
        id: 2,
        titulo: 'Dart na Prática',
        autor: 'Maria',
        anoPublicacao: 2024,
        quantidadeTotal: 2,
      );
      expect(livro, isNot(equals(outro)));
    });
  });
}
