>>> DISPARANDO PROJÉTEIS:

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



>> COOLDOWN DE DISPAROS:

Para coodown de ações ativadas através de love.keypressed

1º Em love.upload na tabela da entidade player por exemplo:
declarar uma variável shootCoolown = 0.2
declarar uma variável shootTimer = 0

2º Em love.update:
player.shootTimer = player.shootTimer - dt

3º Em love.keypressed:
if key == "space" and player.shootTimer <= 0 then
    shoot()
    player.shootTimer = player.shootCooldown
end



>>> DISPARO USANDO love.keyboards.isDown, para um aperto e fluxo contínuo

1. O Problema: O "Dedo Nervoso" vs. O Processador

O computador é rápido demais. Se você simplesmente disser "se apertar espaço, atire", em um único segundo o Love2D vai tentar criar 60 ou 100 balas (uma para cada frame). Isso quebraria seu jogo.

2. O Conceito de Cooldown (Resfriamento)
Pense no Cooldown como a temperatura do canhão da sua nave:

    Quando você atira, o canhão fica quente (o tempo de espera sobe).
    Você não pode atirar enquanto o canhão estiver quente.
    O tempo passa, o canhão esfria (o valor diminui até chegar a zero).

No código:

    -- No update, o tempo "esfria" o canhão
player.cooldown = player.cooldown - dt

O dt (Delta Time) é o segredo aqui. Ele é o tempo real. Se o cooldown era 0.2 e o dt é 0.01, o computador vai subtraindo pedacinhos até que o canhão esteja pronto novamente.
    
3. O Conceito de Fire Rate (Cadência de Tiro)
O Fire Rate é a sua configuração de fábrica. É o valor que define quão rápido sua arma é.

    Um Fire Rate de 0.1 é uma metralhadora (atira a cada 0.1 segundos).
    Um Fire Rate de 1.0 é um canhão lento (atira 1 vez por segundo).

Toda vez que você atira, você "seta" o seu cooldown para o valor do fire rate:
lua

if canhao_frio then
    atirar()
    player.cooldown = player.fireRate -- "Esquenta" o canhão de novo
end

4. Por que usar o love.update em vez do keypressed?
Aqui está a diferença fundamental de experiência de usuário (UX):

    love.keypressed: É um evento. Ele só acontece no momento exato em que o botão desce. Se o jogador quiser dar 10 tiros, ele tem que apertar o botão 10 vezes. É cansativo para jogos de navinha (Shmups).
    love.keyboard.isDown (dentro do update): Ele verifica o estado do botão. Se o jogador segurar o espaço, o código continua tentando atirar a cada frame. Com o sistema de Cooldown, o jogo cria um fluxo rítmico de balas perfeitamente espaçadas, sem sobrecarregar o motor.

Resumo Didático
Imagine um cronômetro de cozinha:

    Ação: O jogador aperta o botão.
    Condição: O cronômetro está no zero?
    Execução: Se sim, dispara a bala e gira o cronômetro para 0.2 segundos.
    Passagem de tempo: O love.update fica girando o cronômetro de volta para o zero.
    Repetição: Enquanto o dedo estiver no botão, esse ciclo se repete assim que o cronômetro zerar.

Isso traz consistência. Não importa se o computador do seu amigo é uma supermáquina ou um PC antigo, graças ao dt, ambos atirarão exatamente na mesma velocidade! Documentação do love.timer e Referência de dt são ótimas fontes para aprofundar esses cálculos de tempo.
