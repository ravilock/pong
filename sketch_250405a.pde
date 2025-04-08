// Variáveis da bola
float ballX, ballY, ballSpeedX, ballSpeedY;
float ballSize = 20;

// Variáveis do goleiro
float goalieX, goalieY;
float goalieWidth = 100;
float goalieHeight = 15;
float goalieSpeed = 5;

// Contador de defesas
int defenseCount = 0;

// Estado do jogo
boolean isGameOver = false;

void setup() {
  size(600, 400);
  resetGame();
}

void draw() {
  background(34, 139, 34); // Fundo verde estilo campo

  // Mostrar defesas
  fill(255);
  textSize(16);
  text("Defesas: " + defenseCount, 10, 20);

  if (isGameOver) {
    textSize(32);
    fill(255, 0, 0);
    text("FIM DE JOGO!", width/2 - 100, height/2 - 20);
    textSize(20);
    fill(255);
    text("Pressione 'R' para reiniciar", width/2 - 110, height/2 + 20);
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

  // Rebater no topo
  if (ballY < 0) {
    ballSpeedY *= -1;
  }

  // Verifica se a bola passou pelo goleiro (gol)
  if (ballY > height) {
    isGameOver = true;
  }

  // Verifica colisão com o goleiro
  if (ballY + ballSize/2 >= goalieY &&
      ballX >= goalieX &&
      ballX <= goalieX + goalieWidth &&
      ballY < goalieY + goalieHeight) {
    ballSpeedY *= -1;
    defenseCount++;

    // Corrigir posição da bola para não prender
    ballY = goalieY - ballSize/2;

    // Lógica de dificuldade progressiva
    if (defenseCount == 10) {
      goalieWidth = 70;
    } else if (defenseCount == 15) {
      goalieWidth = 50;
    } else if (defenseCount == 20) {
      ballSpeedX *= 1.5;
      ballSpeedY *= 1.5;
    } else {
      // Aumenta a velocidade levemente a cada defesa
      ballSpeedX *= 1.05;
      ballSpeedY *= 1.05;
    }
  }

  // Movimento do goleiro
  if (keyPressed) {
    if (key == 'a' || keyCode == LEFT) {
      goalieX -= goalieSpeed;
    } else if (key == 'd' || keyCode == RIGHT) {
      goalieX += goalieSpeed;
    }
  }

  // Limitar o movimento do goleiro na tela
  goalieX = constrain(goalieX, 0, width - goalieWidth);

  // Desenha o goleiro marrom
  fill(139, 69, 19); // Cor marrom (saddlebrown)
  rect(goalieX, goalieY, goalieWidth, goalieHeight);
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

  goalieWidth = 100; // resetar tamanho do goleiro
  goalieX = width / 2 - goalieWidth / 2;
  goalieY = height - 40;

  defenseCount = 0;
  isGameOver = false;
}
