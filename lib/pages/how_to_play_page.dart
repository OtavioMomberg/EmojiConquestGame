import 'package:drag_and_drop_game/themes/app_themes.dart';
import 'package:flutter/material.dart';

class HowToPlayPage extends StatelessWidget {
  const HowToPlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Como Jogar", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 74, 75, 77),
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 46, 46, 47),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: AppThemes.gradient
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                """ 
Objetivo do Jogo:
                
O objetivo é conquistar 3 das 4 áreas de conquista ou derrotar todos os emojis do adversário.

Regras:

1. Cada jogador escolhe 4 emojis para a batalha;

2. Cada emoji possui ataque e classe;

3. Classes mais fortes ganham 3 pontos de ataque extra;

4. Durante a partida é possível ver um diagrama mostrando quais classes possuem vanatagens sobre outras;

5. No início da rodada, o jogador pode posicionar um emoji em um campo de conquisa, mas apenas um (Permanece por 3 rodadas ou se for derrotado antes);

6. Durante a rodada, o jogador deve sortear uma cor a qual seu emoji terá, se essa cor for igual a cor de um dos campo o jogador tem 75% de chance de ganhar 2 pontos de dano extra, caso contrário ele perde 4 pontos

7. Após ter sorteado uma cor, não é possível posicionar um emoji para defender uma área durante a rodada;

8. Caso o emoji posicionado em uma das áreas seja derrotado, ele não poderá mais ser utilizado ao decorrer da partida;

9. Se o emoji que atacar um emoji que esta defendendo uma área possuir menos ataque, este por sua vez será derrotado e não poderá ser utilizado até o fim da partida;

10. A cada rodada 1 dos 4 emojis escolhidos é sortado aleatoriamente para ser usado no ataque;

11. Se o jogador possuir apenas 1 emoji restante, esse não poderá ser posicionado para defender uma área;

12. Cada um dos campos de conquista possuem uma cor e um tipo específico;

13. Cada uma das classes ficam mais fortes ou mais fracas estando em uma tipo de campo especifico (Ganhando 4 pontos ou perdendo 4 pontos de ataque);
                
14. O primeiro jogador é chamado de X e o segundo de Y.
                """,
style: TextStyle(color: Colors.white)
              ),
            ],
          ),
        ),
      ),
    );
  }
}