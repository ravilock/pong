// Variáveis da bola
float ballX, ballY, ballSpeedX, ballSpeedY;
float ballSize = 20;

// Goleiro 1 (embaixo)
float goalie1X, goalie1Y;
float goalie1Width = 100;
float goalie1Height = 15;

// Goleiro 2 (em cima)
float goalie2X, goalie2Y;
float goalie2Width = 100;
float goalie2Height = 15;

float goalieSpeed = 5;

// Contadores de defesa
int defensePlayer1 = 0;
int defensePlayer2 = 0;

// Estado do jogo
boolean isGameOver = false;
String winner = "";

void setup() {
  size(600, 400);
  resetGame();
}

void draw() {
  background(34, 139, 34); // Fundo verde estilo campo

  // Mostrar placar dos jogadores
  fill(255);
  textSize(16);
  text("Player 1: " + defensePlayer1, 10, height - 10);
  text("Player 2: " + defensePlayer2, 10, 20);

  if (isGameOver) {
    textSize(32);
    fill(255, 0, 0);
    text("FIM DE JOGO!", width / 2 - 100, height / 2 - 20);
    textSize(20);
    fill(255);
    text(winner + " perdeu!", width / 2 - 70, height / 2 + 10);
    text("Pressione 'R' para reiniciar", width / 2 - 110, height / 2 + 40);
    return;
  }

  // Atualiza e desenha a bola
  ballX += ballSpeedX;
  ballY += ballSpeedY;

  fill(255); // Bola branca
  ellipse(ballX, ballY, ballSize, ballSize);

  // Rebater nas laterais
  if (ballX < 0 || ballX > width) {
    ballSpeedX *= -1;
  }

  // Verifica se a bola passou por algum jogador
  if (ballY > height) {
    isGameOver = true;
    winner = "Player 1";
  } else if (ballY < 0) {
    isGameOver = true;
    winner = "Player 2";
  }

  // Colisão com Goleiro 1 (embaixo)
  if (ballY + ballSize/2 >= goalie1Y &&
      ballX >= goalie1X &&
      ballX <= goalie1X + goalie1Width &&
      ballY < goalie1Y + goalie1Height) {
    ballSpeedY *= -1;
    ballY = goalie1Y - ballSize/2;
    defensePlayer1++;
    aumentarDificuldade();
  }

  // Colisão com Goleiro 2 (em cima)
  if (ballY - ballSize/2 <= goalie2Y + goalie2Height &&
      ballX >= goalie2X &&
      ballX <= goalie2X + goalie2Width &&
      ballY > goalie2Y) {
    ballSpeedY *= -1;
    ballY = goalie2Y + goalie2Height + ballSize/2;
    defensePlayer2++;
    aumentarDificuldade();
  }

  // Movimento dos goleiros
  if (keyPressed) {
    // Player 1 - 'A' e 'D'
    if (key == 'a' || key == 'A') {
      goalie1X -= goalieSpeed;
    } else if (key == 'd' || key == 'D') {
      goalie1X += goalieSpeed;
    }

    // Player 2 - setas
    if (keyCode == LEFT) {
      goalie2X -= goalieSpeed;
    } else if (keyCode == RIGHT) {
      goalie2X += goalieSpeed;
    }
  }

  // Limita os dois goleiros dentro da tela
  goalie1X = constrain(goalie1X, 0, width - goalie1Width);
  goalie2X = constrain(goalie2X, 0, width - goalie2Width);

  // Desenha goleiro 1
  fill(139, 69, 19); // marrom
  rect(goalie1X, goalie1Y, goalie1Width, goalie1Height);

  // Desenha goleiro 2
  fill(160, 82, 45); // outro tom de marrom
  rect(goalie2X, goalie2Y, goalie2Width, goalie2Height);
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    resetGame();
  }
}

void resetGame() {
  // Reiniciar posições e velocidades
  ballX = width / 2;
  ballY = height / 2;
  ballSpeedX = random(-3, 3);
  ballSpeedY = 4;

  goalie1Width = 100;
  goalie2Width = 100;

  goalie1X = width / 2 - goalie1Width / 2;
  goalie1Y = height - 40;

  goalie2X = width / 2 - goalie2Width / 2;
  goalie2Y = 30;

  defensePlayer1 = 0;
  defensePlayer2 = 0;
  isGameOver = false;
  winner = "";
}

void aumentarDificuldade() {
  int totalDefenses = defensePlayer1 + defensePlayer2;

  if (totalDefenses == 10) {
    goalie1Width = 70;
    goalie2Width = 70;
  } else if (totalDefenses == 15) {
    goalie1Width = 50;
    goalie2Width = 50;
  } else if (totalDefenses == 20) {
    ballSpeedX *= 1.5;
    ballSpeedY *= 1.5;
  } else {
    ballSpeedX *= 1.05;
    ballSpeedY *= 1.05;
  }
}
