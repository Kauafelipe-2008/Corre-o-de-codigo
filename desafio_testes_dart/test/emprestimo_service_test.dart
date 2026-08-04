import 'package:desafio_testes_dart/models/emprestimo.dart';
import 'package:desafio_testes_dart/models/livro.dart';
import 'package:desafio_testes_dart/models/usuario.dart';
import 'package:desafio_testes_dart/services/emprestimo_service.dart';
import 'package:test/test.dart';

void main() {
  group('EmprestimoService', () {
    late EmprestimoService service;
    late Usuario usuario;
    late Livro livro;

    setUp(() {
      service = EmprestimoService();
      usuario = Usuario(
        id: 1,
        nome: 'Daniel',
        email: 'daniel@escola.com',
        limiteEmprestimos: 2,
      );
      livro = Livro(
        id: 1,
        titulo: 'Engenharia de Software',
        autor: 'Equipe',
        anoPublicacao: 2024,
        quantidadeTotal: 1,
      );
    });

    test('realiza empréstimo e reduz disponibilidade', () {
      final emprestimo = service.realizarEmprestimo(
        id: 1,
        usuario: usuario,
        livro: livro,
        data: DateTime(2026, 8, 1),
      );
      expect(emprestimo.status, StatusEmprestimo.ativo);
      expect(livro.quantidadeDisponivel, 0);
    });

    test('não empresta livro indisponível', () {
      livro.retirarExemplar();
      expect(
        () => service.realizarEmprestimo(
          id: 1,
          usuario: usuario,
          livro: livro,
          data: DateTime(2026, 8, 1),
        ),
        throwsStateError,
      );
    });

    test('devolução atualiza status e disponibilidade', () {
      final emprestimo = service.realizarEmprestimo(
        id: 1,
        usuario: usuario,
        livro: livro,
        data: DateTime(2026, 8, 1),
      );
      service.devolver(emprestimoId: emprestimo.id, data: DateTime(2026, 8, 5));
      expect(emprestimo.status, StatusEmprestimo.devolvido);
      expect(livro.quantidadeDisponivel, 1);
    });

    test('renovação aumenta o prazo', () {
      final emprestimo = service.realizarEmprestimo(
        id: 1,
        usuario: usuario,
        livro: livro,
        data: DateTime(2026, 8, 1),
      );
      final prazoAnterior = emprestimo.dataPrevistaDevolucao;
      emprestimo.renovar(7);
      expect(
        emprestimo.dataPrevistaDevolucao,
        prazoAnterior.add(const Duration(days: 7)),
      );
    });

    test('lista somente empréstimos atrasados', () {
      final emprestimo = service.realizarEmprestimo(
        id: 1,
        usuario: usuario,
        livro: livro,
        data: DateTime(2026, 8, 1),
      );
      final atrasados = service.listarAtrasados(DateTime(2026, 8, 20));
      expect(atrasados, contains(emprestimo));
    });

    test('prazo padrão de devolução é de 7 dias', () {
  final emprestimo = service.realizarEmprestimo(
    id: 1,
    usuario: usuario,
    livro: livro,
    data: DateTime(2026, 8, 1),
  );
  expect(emprestimo.dataPrevistaDevolucao, DateTime(2026, 8, 8));
});
  });
}
