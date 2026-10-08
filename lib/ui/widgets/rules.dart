import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:material_ui/material_ui.dart';

class const Rules({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "1. Cada jogador escolhe 4 emojis para a batalha;\n\n"
      "2. Cada emoji possui ataque e classe;\n\n"
      "3. Classes mais fortes ganham 3 pontos de ataque extra;\n\n"
      "4. Durante a partida é possível ver um diagrama mostrando "
      "quais classes possuem vanatagens sobre outras;\n\n"
      "5. No início da rodada, o jogador pode posicionar um emoji "
      "em um campo de conquista, mas apenas um (Permanece por 3 rodadas ou se for derrotado antes);\n\n"
      "6. Durante a rodada, o jogador deve sortear uma cor a qual "
      "seu emoji terá, se essa cor for igual a cor de um dos campo o jogador "
      "tem 75% de chance de ganhar 2 pontos de dano extra, caso contrário ele perde 2 pontos\n\n"
      "7. Após ter sorteado uma cor, não é possível posicionar um emoji "
      "para defender uma área durante a rodada;\n\n"
      "8. Caso o emoji posicionado em uma das áreas seja derrotado, ele "
      "não poderá mais ser utilizado ao decorrer da partida;\n\n"
      "9. Se o emoji que atacar um emoji que esta defendendo uma área "
      "possuir menos ataque, este por sua vez será derrotado e não poderá "
      "ser utilizado até o fim da partida;\n\n"
      "10. A cada rodada 1 dos 4 emojis escolhidos é sortado aleatoriamente "
      "para ser usado no ataque;\n\n"
      "11. Se o jogador possuir apenas 1 emoji restante, esse não poderá ser "
      "posicionado para defender uma área;\n\n"
      "12. Cada um dos campos de conquista possuem uma cor e um tipo específico;\n\n"
      "13. Cada uma das classes ficam mais fortes ou mais fracas estando em uma "
      "tipo de campo especifico (Ganhando 4 pontos ou perdendo 4 pontos de ataque);\n\n"
      "14. O primeiro jogador é chamado de X e o segundo de Y.",
      style: TextStyle(color: AppThemes.white),
    );
  }
}
