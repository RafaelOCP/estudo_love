>>> DISPARANDO PROJÉTEIS COM KEYPRESSED, CADA APERTO UM DISPARO:

--criar a tabela para cada uma das balas
--em love.load:
bullets = {}

--criar uma função para disparar o projétil, note que cada projétil disparado vira uma tabela independente dentro da tabela mãe bullets
local function shoot(shooter)
    local b = {
        x = shooter.x + shooter.w / 2 - 1,
        y = shooter.y,
        w = 2,
        h = 10,
        speed = 400
    }
    table.insert(bullets, b)
end


--para o momento do projétil em love.update, veja que se percorre de trás para frente a tabela mãe e para cada projétil e adicionado o movimento. Veja que é feito o código para remover o projétil:
    for i = #bullets, 1, -1 do
        local b = bullets[i]
        b.y = b.y - b.speed * dt

        if b.y + b.h < 0 then
            table.remove(bullets, i)
        end
    end

--love.keypressed para chamar a função do disparo
function love.keypressed(key)
    if key == "space" then
        shoot(player)
    end
end

--love.draw para desenhar o projétil
    for _, b in ipairs(bullets) do
        love.graphics.rectangle("fill", b.x, b.y, b.w, b.h)
    end


>>> COOLDOWN DE DISPAROS:

Para coodown de ações ativadas através de love.keypressed

1º Em love.upload na tabela da entidade player por exemplo:
declarar uma variável shootCooldown = 0.2 --configuração
declarar uma variável shootTimer = 0 --estado atual

2º Em love.update:
player.shootTimer = player.shootTimer - dt

3º Em love.keypressed:
if key == "space" and player.shootTimer <= 0 then
    shoot(player)
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
