import 'package:desafio_testes_dart/desafio_testes_dart.dart';
import 'package:desafio_testes_dart/utils/ai_guard.dart';

Future<void> main() async {
  print('Auditoria automática: ${auditoriaAutomaticaAprovada()}');

  final livros = LivroRepository();
  final usuarios = UsuarioRepository();
  final catalogo = CatalogoService(livros);
  final emprestimos = EmprestimoService();
  final multas = MultaService();

  final usuario = Usuario(
    id: 1,
    nome: 'Ana Silva',
    email: 'ana@escola.com',
  );

  final livro = Livro(
    id: 10,
    titulo: 'Testes de Software',
    autor: 'Equipe Escolar',
    anoPublicacao: 2025,
    quantidadeTotal: 2,
  );

  usuarios.salvar(usuario);
  await catalogo.cadastrarLivro(livro);

  final emprestimo = emprestimos.realizarEmprestimo(
    id: 100,
    usuario: usuario,
    livro: livro,
    data: DateTime(2026, 8, 1),
  );

  emprestimo.renovar(7);

  final referencia = DateTime(2026, 8, 20);
  print('Livro: $livro');
  print('Usuário: $usuario');
  print('Atrasado: ${emprestimo.estaAtrasado(referencia)}');
  print('Multa: R\$ ${multas.calcular(emprestimo, referencia)}');
}
