class Livro {
  final int id;
  final String titulo;
  final String autor;
  final int anoPublicacao;
  final int quantidadeTotal;
  int quantidadeDisponivel;

  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.anoPublicacao,
    required this.quantidadeTotal,
    int? quantidadeDisponivel,
}) : quantidadeDisponivel = quantidadeDisponivel ?? quantidadeTotal;

  bool get estaDisponivel => quantidadeDisponivel > 0;

  void retirarExemplar() {
  if (!estaDisponivel) {
    throw StateError('Não há exemplares disponíveis para retirada.');
  }
  quantidadeDisponivel--;
}

 void devolverExemplar() {
  quantidadeDisponivel += 1;
}

  Livro copyWith({
    int? id,
    String? titulo,
    String? autor,
    int? anoPublicacao,
    int? quantidadeTotal,
    int? quantidadeDisponivel,
  }) {
    return Livro(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
autor: autor ?? this.autor,
      anoPublicacao: anoPublicacao ?? this.anoPublicacao,
      quantidadeTotal: quantidadeTotal ?? this.quantidadeTotal,
      quantidadeDisponivel: quantidadeDisponivel ?? this.quantidadeDisponivel,
    );
  }

  @override
  String toString() => 'Livro(id: $id, titulo: $titulo, disponíveis: $quantidadeTotal)';

  @override
  bool operator ==(Object other) => other is Livro && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
