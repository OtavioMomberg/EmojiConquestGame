final class const RulesData._() {
  static const rules = [
    "Cada jogador escolhe 4 emojis para a batalha",
    "Cada emoji possui ataque e classe",
    "Classes mais fortes ganham 1 ponto de ataque",
    "Classes mais fracas perdem 1 ponto de ataque",
    "No início da rodada, o jogador pode posicionar um emoji "
    "em uma área (Permanece por 3 rodadas ou se for derrotado antes)",
    "Durante a rodada, o jogador sorteia uma cor a qual o emoji terá",
    "De acordo com a cor, o ataque pode sofre alterações:\n"
    "Azul: +2\nVemelho: -2\nDemais cores: 0",
    "Após ter sorteado uma cor, não é possível posicionar um emoji "
    "para defender uma área durante a rodada",
    "Caso o emoji posicionado em uma das áreas seja derrotado, ele "
    "não poderá mais ser utilizado ao decorrer da partida",
    "Se o emoji que atacar um emoji que esta defendendo uma área "
    "possuir menos ataque, este por sua vez será derrotado e não poderá "
    "ser utilizado até o fim da partida",
    "A cada rodada 1 dos 4 emojis escolhidos é sortado aleatoriamente "
    "para ser usado no ataque",
    "Se o jogador possuir apenas 1 emoji restante, esse não poderá ser "
    "posicionado para defender uma área",
    "Um jogador será o X e o outro o Y"
  ];
}