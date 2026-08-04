import '../models/livro.dart';

class LivroRepository {
  final List<Livro> _livros = [];

  Future<void> salvar(Livro livro) async {
    await Future<void>.delayed(const Duration(milliseconds: 5));
    _livros.add(livro);
  }

  Livro? buscarPorId(int id) {
  try {
    return _livros.firstWhere((livro) => livro.id == id);
  } on StateError {
    return null;
  }
}

 List<Livro> buscarPorTitulo(String termo) {
  return _livros
      .where((livro) => livro.titulo.toLowerCase().contains(termo.toLowerCase()))
      .toList();
}

 Future<bool> remover(int id) async {
  await Future<void>.delayed(const Duration(milliseconds: 5));
  final tamanhoAntes = _livros.length;
  _livros.removeWhere((livro) => livro.id == id);
  return _livros.length < tamanhoAntes;
}

  List<Livro> listarTodos() => List.of(_livros);

  void limpar() => _livros.clear();
}
