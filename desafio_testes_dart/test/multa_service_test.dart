import 'package:desafio_testes_dart/models/emprestimo.dart';
import 'package:desafio_testes_dart/models/livro.dart';
import 'package:desafio_testes_dart/models/usuario.dart';
import 'package:desafio_testes_dart/services/multa_service.dart';
import 'package:test/test.dart';

void main() {
  group('MultaService', () {
    late Usuario usuario;
    late Livro livro;
    late MultaService service;

    setUp(() {
      usuario = Usuario(id: 1, nome: 'Bianca', email: 'bianca@escola.com');
      livro = Livro(
        id: 1,
        titulo: 'Qualidade de Software',
        autor: 'Equipe',
        anoPublicacao: 2022,
        quantidadeTotal: 1,
      );
      service = MultaService(valorPorDia: 2.5, valorMaximo: 50);
    });

    Emprestimo criarEmprestimo(DateTime prevista) {
      return Emprestimo(
        id: 1,
        usuario: usuario,
        livro: livro,
        dataEmprestimo: DateTime(2026, 8, 1),
        dataPrevistaDevolucao: prevista,
        status: StatusEmprestimo.ativo,
      );
    }

   test('não cobra multa antes do prazo', () {
  final emprestimo = criarEmprestimo(DateTime(2026, 8, 10));
  expect(service.calcular(emprestimo, DateTime(2026, 8, 9)), 0);
});

    test('não cobra multa exatamente no prazo', () {
  final emprestimo = criarEmprestimo(DateTime(2026, 8, 10));
  expect(service.calcular(emprestimo, DateTime(2026, 8, 10)), 0);
});
test('cobra por cinco dias de atraso', () {
  final emprestimo = criarEmprestimo(DateTime(2026, 8, 10));
  expect(service.calcular(emprestimo, DateTime(2026, 8, 15)), 12.5);
});

    test('limita a multa ao valor máximo', () {
      final emprestimo = criarEmprestimo(DateTime(2026, 8, 1));
      expect(service.calcular(emprestimo, DateTime(2026, 9, 1)), 50);
    });
  });
}
