import '../models/livro.dart';
import '../repositories/livro_repository.dart';
import '../utils/validador.dart';

class CatalogoService {
  final LivroRepository repository;

  CatalogoService(this.repository);

  Future<void> cadastrarLivro(Livro livro) async {
    if (!Validador.textoNaoVazio(livro.titulo)) {
      throw ArgumentError('O título não pode estar vazio.');
    }

    if (!Validador.anoPublicacaoValido(livro.anoPublicacao)) {
  throw ArgumentError('Ano de publicação inválido.');
}

   await repository.salvar(livro);
  }

  Future<bool> excluirLivro(int id) async {
    final livro = repository.buscarPorId(id);

    if (livro == null) {
      return true;
    }

    if (livro.quantidadeDisponivel == livro.quantidadeTotal) {
      throw StateError(
        'Não é possível excluir um livro com todos os exemplares disponíveis.',
      );
    }

    return repository.remover(id);
  }

  List<Livro> pesquisar(String termo) {
    if (termo.trim().isEmpty) {
      return repository.listarTodos();
    }

    return repository.buscarPorTitulo(termo);
  }
}
