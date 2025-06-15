-- main.lua

local Card = require("card")
local Deck = require("deck")
local Player = require("player")
local UI = require("ui")
local cardData = require("card_data")

local player

local selectedCard = nil
local hoveredIndex = nil
local draggingCard = nil
local dragOffsetY = 0

local locations = {
    { cards = {}, ai = {} },
    { cards = {}, ai = {} },
    { cards = {}, ai = {} }
}

local LOCATION_Y = 400
local LOCATION_WIDTH = 200
local LOCATION_HEIGHT = 100

-- ai player set up stuff

local aiPlayer = nil
local turn = 1
local maxPoints = 15

local gamePhase = "play" -- other phases: "resolving", "gameover"
local playerScore = 0
local aiScore = 0

local submitButton = { x = 1200, y = 600, w = 150, h = 50 }

function buildDeck(cardPool, size)
    local deck = {}
    local counts = {}

    while #deck < size do
        local cardData = cardPool[love.math.random(#cardPool)]
        counts[cardData.name] = (counts[cardData.name] or 0)

        if counts[cardData.name] < 2 then
            table.insert(deck, Card:new(cardData.name, cardData.cost, cardData.power, cardData.text))
            counts[cardData.name] = counts[cardData.name] + 1
        end
    end

    return deck
end

function love.load()
    love.graphics.setBackgroundColor(0, 0, 0)

    local playerDeck = Deck:new(buildDeck(cardData, 20))
    playerDeck:shuffle()

    local aiDeck = Deck:new(buildDeck(cardData, 20))
    aiDeck:shuffle()

    player = Player:new(playerDeck)
    aiPlayer = Player:new(aiDeck)

    for _ = 1, 3 do
        player:drawCard()
        aiPlayer:drawCard()
    end
end

function love.update(dt)
    hoveredIndex = nil
    local mouseX, mouseY = love.mouse.getPosition()

    for i, card in ipairs(player.hand) do
        local y = 30 + (i - 1) * 60
        if mouseX >= 10 and mouseX <= 300 and mouseY >= y and mouseY <= y + 50 then
            hoveredIndex = i
            break
        end
    end
end

function love.draw()
    UI.drawText("Player Hand:", 10, 10)

    -- Draw the player's hand
    for i, card in ipairs(player.hand) do
        local y = 30 + (i - 1) * 60

        if i == hoveredIndex then
            love.graphics.setColor(1, 1, 0.5) -- highlight
        elseif card == selectedCard then
            love.graphics.setColor(0.5, 1, 1) -- selected
        else
            love.graphics.setColor(1, 1, 1)   -- default
        end

        UI.drawText("Name: " .. card.name, 10, y)
        UI.drawText("Cost: " .. card.cost .. "  Power: " .. card.power, 10, y + 15)
        UI.drawText("Text: " .. card.text, 10, y + 30)
    end

    -- Draw board locations
    for i, loc in ipairs(locations) do
        local lx = 50 + (i - 1) * (LOCATION_WIDTH + 20)
        local ly = LOCATION_Y
        love.graphics.setColor(0.3, 0.3, 0.3)
        love.graphics.rectangle("fill", lx, ly, LOCATION_WIDTH, LOCATION_HEIGHT)

        love.graphics.setColor(1, 1, 1)
        UI.drawText("Location " .. i, lx + 10, ly + 5)

        for j, card in ipairs(loc.cards) do
            UI.drawText(card.name, lx + 10, ly + 20 + (j - 1) * 20)
        end
    end

    -- Draw dragging card (floating with mouse)
    if draggingCard then
        local mx, my = love.mouse.getPosition()
        love.graphics.setColor(1, 1, 1)
        UI.drawText("Name: " .. draggingCard.name, mx + 10, my - dragOffsetY)
        UI.drawText("Cost: " .. draggingCard.cost .. "  Power: " .. draggingCard.power, mx + 10, my - dragOffsetY + 15)
        UI.drawText("Text: " .. draggingCard.text, mx + 10, my - dragOffsetY + 30)
    end

    -- Draw Submit Button
    love.graphics.setColor(0.2, 0.6, 1)
    love.graphics.rectangle("fill", submitButton.x, submitButton.y, submitButton.w, submitButton.h)
    love.graphics.setColor(1, 1, 1)
    UI.drawText("Submit", submitButton.x + 40, submitButton.y + 15)

    -- Draw Scores
    UI.drawText("Player Score: " .. playerScore, 1050, 20)
    UI.drawText("AI Score: " .. aiScore, 1050, 50)

    -- Draw AI cards
    for i, loc in ipairs(locations) do
        local lx = 50 + (i - 1) * (LOCATION_WIDTH + 20)
        local ly = LOCATION_Y - 150
        love.graphics.setColor(0.15, 0.15, 0.15)
        love.graphics.rectangle("fill", lx, ly, LOCATION_WIDTH, LOCATION_HEIGHT)

        love.graphics.setColor(1, 1, 1)
        UI.drawText("AI Location " .. i, lx + 10, ly + 5)

        for j, card in ipairs(loc.ai) do
            UI.drawText(card.name, lx + 10, ly + 20 + (j - 1) * 20)
        end
    end

    -- UI Header
    love.graphics.setColor(1, 1, 1)
    UI.drawText("Greekstone", 800, 10)
    UI.drawText("Turn: " .. turn, 600, 30)
    UI.drawText("Mana: " .. player.mana, 600, 50)
    UI.drawText("Points to Win: " .. maxPoints, 600, 70)



    love.graphics.setColor(1, 1, 1) -- reset draw color
end

function love.mousepressed(x, y, button)
    if button == 1 and hoveredIndex then
        draggingCard = player.hand[hoveredIndex]
        selectedCard = draggingCard
        dragOffsetY = y - (30 + (hoveredIndex - 1) * 60)
    end

    -- Check if clicking Submit button
    if gamePhase == "play" and x >= submitButton.x and x <= submitButton.x + submitButton.w and
        y >= submitButton.y and y <= submitButton.y + submitButton.h then
        gamePhase = "resolving"

        -- AI randomly plays cards
        for i = 1, 3 do
            if #aiPlayer.hand > 0 and #locations[i].ai ~= 4 then
                local cardIndex = love.math.random(#aiPlayer.hand)
                local card = table.remove(aiPlayer.hand, cardIndex)
                table.insert(locations[i].ai, card)
            end
        end

        -- Score locations
        for i, loc in ipairs(locations) do
            local pPower, aPower = 0, 0
            for _, c in ipairs(loc.cards) do pPower = pPower + c.power end
            for _, c in ipairs(loc.ai) do aPower = aPower + c.power end

            if pPower > aPower then
                playerScore = playerScore + (pPower - aPower)
            elseif aPower > pPower then
                aiScore = aiScore + (aPower - pPower)
            end
        end

        -- Check win
        if playerScore >= maxPoints or aiScore >= maxPoints then
            gamePhase = "gameover"
        else
            -- Next turn
            turn = turn + 1
            player.mana = turn
            aiPlayer.mana = turn

            player:drawCard()
            aiPlayer:drawCard()

            -- Clear boards
            for _, loc in ipairs(locations) do
                loc.cards = {}
                loc.ai = {}
            end

            gamePhase = "play"
        end

        return
    end
end

function love.mousereleased(x, y, button)
    if button == 1 and draggingCard then
        for i, loc in ipairs(locations) do
            local lx = 50 + (i - 1) * (LOCATION_WIDTH + 20)
            local ly = LOCATION_Y
            if x >= lx and x <= lx + LOCATION_WIDTH and y >= ly and y <= ly + LOCATION_HEIGHT then
                if #loc.cards < 4 then
                    -- Add card to location and remove from hand
                    table.insert(loc.cards, draggingCard)
                    for h = #player.hand, 1, -1 do
                        if player.hand[h] == draggingCard then
                            table.remove(player.hand, h)
                            break
                        end
                    end
                end
            end
        end
        draggingCard = nil
    end
end
