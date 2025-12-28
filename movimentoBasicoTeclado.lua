--Movimento básico com teclado utilizando WASD, tendo como limite de movimento as bordas da tela

--[[
LINGUAGEM NATURAL

Inicialmente, o algoritmo realiza a criação de uma entidade denominada jogador, à qual são atribuídos valores iniciais para suas propriedades fundamentais.

A posição inicial do jogador no ambiente gráfico é definida pelas coordenadas X = 400 e Y = 300, representando sua localização inicial no plano bidimensional da tela. Em seguida, são definidos os atributos dimensionais do jogador, estabelecendo-se uma largura de 32 unidades e uma altura de 32 unidades. Além disso, é atribuída ao jogador uma velocidade de deslocamento igual a 200, a qual determina a taxa de variação de sua posição durante o movimento.

Durante a execução do programa, o algoritmo monitora continuamente as entradas do teclado a fim de controlar o deslocamento do jogador. Caso a tecla “A” esteja pressionada, a coordenada horizontal (X) do jogador é decrementada, resultando em um movimento para a esquerda. Caso a tecla “D” esteja pressionada, a coordenada X é incrementada, promovendo o deslocamento para a direita. De forma análoga, ao pressionar a tecla “W”, a coordenada vertical (Y) é decrementada, ocasionando um movimento para cima, enquanto o pressionamento da tecla “S” incrementa a coordenada Y, produzindo um movimento para baixo.

Após o processamento do movimento, o algoritmo obtém as dimensões atuais da tela, armazenando a largura em SW e a altura em SH. Em seguida, é realizado o controle de limites do jogador através da técnica de clamping (limitação de valores), garantindo que sua posição permaneça dentro da área visível da tela. Caso a coordenada X seja inferior a zero, seu valor é ajustado para zero. Caso a coordenada X ultrapasse o limite máximo permitido, definido como a largura da tela menos a largura do jogador (SW − largura do jogador), seu valor é ajustado para esse limite. Procedimento equivalente é aplicado à coordenada Y, restringindo-a ao intervalo entre zero e a altura máxima permitida (SH − altura do jogador).

Finalmente, renderiza um retângulo preenchido na tela, tendo como ponto de origem as coordenadas (x, y) do objeto player, com largura (w) e altura (h) definidas pelas propriedades do jogador.

Dessa forma, o algoritmo assegura que o jogador possa se mover livremente em todas as direções, respeitando tanto as entradas do usuário quanto os limites físicos do ambiente gráfico.

PSEUDOCÓDIGO

Criar jogador

Definir posição inicial X do jogador como 400
Definir posição inicial Y do jogador como 300

Definir largura do jogador como 32
Definir altura do jogador como 32

Definir velocidade do jogador como 200


SE a tecla "A" estiver pressionada ENTÃO
    Diminuir a posição X do jogador
FIM SE

SE a tecla "D" estiver pressionada ENTÃO
    Aumentar a posição X do jogador
FIM SE

SE a tecla "W" estiver pressionada ENTÃO
    Diminuir a posição Y do jogador
FIM SE

SE a tecla "S" estiver pressionada ENTÃO
    Aumentar a posição Y do jogador
FIM SE


Obter a largura da tela e armazenar em SW
Obter a altura da tela e armazenar em SH

SE a posição X do jogador for menor que 0 ENTÃO
    Definir X como 0
SENÃO SE a posição X for maior que (SW - largura do jogador) ENTÃO
    Definir X como (SW - largura do jogador)
FIM SE

SE a posição Y do jogador for menor que 0 ENTÃO
    Definir Y como 0
SENÃO SE a posição Y for maior que (SH - altura do jogador) ENTÃO
    Definir Y como (SH - altura do jogador)
FIM SE

Desenhar retângulo preenchido
na posição (x, y)
com largura w e altura h
]]

--o objeto criado em love.load
    player = {
        x = 400, y = 300,
        w = 32, h = 32,
        speed = 200
    }

--para o movimento através do estade das teclas em love.update
    if love.keyboard.isDown("a") then
        player.x = player.x - player.speed * dt
    end
    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed * dt
    end
    if love.keyboard.isDown("w") then
        player.y = player.y - player.speed * dt
    end
    if love.keyboard.isDown("s") then
        player.y = player.y + player.speed * dt
    end

--para o limite do movimento em love.update
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
    player.x = math.max(0, math.min(player.x, sw - player.w))
    player.y = math.max(0, math.min(player.y, sh - player.h))

--renderizando o objeto em love.draw
    love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)