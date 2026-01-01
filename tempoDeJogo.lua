--Declare e inicialize a variável para o tempo do jogo fora do escopo das funções
local tempoDeJogo = 0

--em love.update atribua na variável o tempo, usando o dt
tempoDeJogo = tempoDeJogo + dt

--em love.draw separem os minutos e segundos e rederize
local minutes = math.floor(tempoDeJogo / 60)
local seconds = math.floor(tempoDeJogo % 60)
love.graphics.print(string.format("TEMPO DE JOGO: %02d:%02d", minutes, seconds), hud.x, hud.y)
