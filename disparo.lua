--Disparando um projétil

--[[
LINGUAGEM NATURAL

Define-se uma estrutura de dados denominada bullet, responsável por representar um projétil, contendo atributos de posição (x, y), dimensões (largura w e altura h), velocidade de deslocamento vertical (speed) e um estado lógico (active) que indica se o projétil está atualmente em uso.

Uma função local denominada shoot é responsável por inicializar o disparo do projétil. Ao ser chamada, essa função ativa o projétil, posicionando-o horizontalmente no centro do jogador e verticalmente na mesma coordenada superior do personagem.

Durante o ciclo de atualização do jogo, é verificado se o projétil encontra-se ativo. Caso positivo, sua posição vertical é atualizada de forma contínua, deslocando-o para cima com base em sua velocidade e no intervalo de tempo entre quadros (dt). Se o projétil ultrapassar o limite superior da tela, ele é automaticamente desativado.

Um manipulador de eventos de teclado detecta o pressionamento da tecla espaço. Quando essa tecla é acionada e não há um projétil ativo no momento, a função de disparo é executada, garantindo que apenas um projétil possa existir simultaneamente.

No processo de renderização, o sistema verifica novamente se o projétil está ativo. Em caso afirmativo, define-se a cor de desenho para verde e o projétil é renderizado na tela como um retângulo preenchido, utilizando suas coordenadas e dimensões. Após o desenho, a cor padrão de renderização é restaurada.

PSEUDOCÓDIGO

INÍCIO

// Definição do projétil
CRIAR bullet
    bullet.x ← 0
    bullet.y ← 0
    bullet.w ← 2
    bullet.h ← 10
    bullet.speed ← 400
    bullet.active ← falso
FIM CRIAR

// Função de disparo
FUNÇÃO shoot()
    bullet.active ← verdadeiro
    bullet.x ← player.x + (player.w / 2) − (bullet.w / 2)
    bullet.y ← player.y
FIM FUNÇÃO

// Atualização do projétil
SE bullet.active = verdadeiro ENTÃO
    bullet.y ← bullet.y − (bullet.speed × dt)

    SE bullet.y + bullet.h < 0 ENTÃO
        bullet.active ← falso
    FIM SE
FIM SE

// Evento de teclado
AO PRESSIONAR TECLA key
    SE key = "espaço" E bullet.active = falso ENTÃO
        CHAMAR shoot()
    FIM SE
FIM EVENTO

// Renderização do projétil
SE bullet.active = verdadeiro ENTÃO
    DEFINIR COR PARA verde
    DESENHAR RETÂNGULO PREENCHIDO
        NA posição (bullet.x, bullet.y)
        COM largura bullet.w
        E altura bullet.h
    RESTAURAR COR PADRÃO
FIM SE

FIM
]]

--objeto criado em love.load
    bullet = {
        x = 0, y = 0,
        w = 2, h = 10,
        speed = 400,
        active = false
    }

--função para ativar o tiro e a posição inicial do projétil
local function shoot()
    bullet.active = true
    bullet.x = player.x + player.w / 2 - bullet.w / 2
    bullet.y = player.y
end

--para o movimento do projétil em love.update
    if bullet.active then
        bullet.y = bullet.y - bullet.speed * dt
        if bullet.y + bullet.h < 0 then
            bullet.active = false
        end
    end

--callback keypressed para ativar a função do tiro
function love.keypressed(key)
    if key == "space" and not bullet.active then
        shoot()
    end
end

--para renderizar o projétil em love.draw
    if bullet.active then
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle("fill", bullet.x, bullet.y, bullet.w, bullet.h)
        love.graphics.setColor(1,1,1)
    end