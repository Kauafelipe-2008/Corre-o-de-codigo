import '../models/usuario.dart';

class UsuarioRepository {
  final Map<int, Usuario> _usuarios = {};

  void salvar(Usuario usuario) {
  _usuarios[usuario.id] = usuario;
}

  Usuario buscarPorId(int id) {
    return _usuarios[id]!;
  }

  bool existeEmail(String email) {
  return _usuarios.values.any(
    (usuario) => usuario.email.toLowerCase() == email.toLowerCase(),
  );
}

  List<Usuario> listarAtivos() {
  return _usuarios.values.where((usuario) => usuario.ativo).toList();
}
}
