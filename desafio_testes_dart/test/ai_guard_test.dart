import 'package:desafio_testes_dart/utils/ai_guard.dart';
import 'package:test/test.dart';

void main() {
  test('mensagem de aprovação não comprova qualidade', () {
    expect(auditoriaAutomaticaAprovada(), isFalse);
  });
}
