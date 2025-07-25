-- card_data.lua

local cardData = {
    {name = "Wooden Cow", cost = 1, power = 1, text = ""},
    {name = "Pegasus", cost = 3, power = 5, text = ""},
    {name = "Minotaur", cost = 5, power = 9, text = ""},
    {name = "Titan", cost = 6, power = 12, text = ""},
    {name = "Zeus", cost = 5, power = 7, text = "When Revealed: Lower the power of each card in your opponent's hand by 1."},
    {name = "Ares", cost = 4, power = 4, text = "When Revealed: Gain +2 power for each enemy card here."},
    {name = "Medusa", cost = 3, power = 3, text = "When ANY other card is played here, lower that card's power by 1."},
    {name = "Cyclops", cost = 4, power = 5, text = "When Revealed: Discard your other cards here, gain +2 power for each discarded."},
    {name = "Poseidon", cost = 4, power = 6, text = "When Revealed: Move away an enemy card here with the lowest power."},
    {name = "Artemis", cost = 3, power = 4, text = "When Revealed: Gain +5 power if there is exactly one enemy card here."},
    {name = "Hera", cost = 3, power = 3, text = "When Revealed: Give cards in your hand +1 power."},
    {name = "Demeter", cost = 2, power = 3, text = "When Revealed: Both players draw a card."},
    {name = "Hades", cost = 4, power = 5, text = "When Revealed: Gain +2 power for each card in your discard pile."},
    {name = "Hercules", cost = 5, power = 6, text = "When Revealed: Doubles its power if it's the strongest card here."},
    {name = "Dionysus", cost = 3, power = 2, text = "When Revealed: Gain +2 power for each of your other cards here."},
    {name = "Hermes", cost = 2, power = 3, text = "When Revealed: Moves to another location."},
    {name = "Hydra", cost = 4, power = 4, text = "Add two copies to your hand when this card is discarded."},
    {name = "Ship of Theseus", cost = 3, power = 3, text = "When Revealed: Add a copy with +1 power to your hand."},
    {name = "Sword of Damocles", cost = 2, power = 5, text = "End of Turn: Loses 1 power if not winning this location."},
    {name = "Midas", cost = 4, power = 4, text = "When Revealed: Set ALL cards here to 3 power."},
    {name = "Aphrodite", cost = 2, power = 3, text = "When Revealed: Lower the power of each enemy card here by 1."},
    {name = "Athena", cost = 3, power = 3, text = "Gain +1 power when you play another card here."},
    {name = "Apollo", cost = 2, power = 3, text = "When Revealed: Gain +1 mana next turn."},
    {name = "Hephaestus", cost = 3, power = 4, text = "When Revealed: Lower the cost of 2 cards in your hand by 1."},
    {name = "Persephone", cost = 2, power = 4, text = "When Revealed: Discard the lowest power card in your hand."},
    {name = "Prometheus", cost = 3, power = 4, text = "When Revealed: Draw a card from your opponent's deck."},
    {name = "Pandora", cost = 2, power = 6, text = "When Revealed: If no ally cards are here, lower this card's power by 5."},
    {name = "Icarus", cost = 2, power = 2, text = "End of Turn: Gains +1 power, but is discarded when its power > 7."},
    {name = "Iris", cost = 2, power = 3, text = "End of Turn: Give your cards at each other location +1 power if they have unique powers."},
    {name = "Nyx", cost = 4, power = 4, text = "When Revealed: Discards your other cards here, add their power to this card."},
    {name = "Altas", cost = 3, power = 6, text = "End of Turn: Loses 1 power if your side of this location is full."},
    {name = "Daedalus", cost = 2, power = 3, text = "When Revealed: Add a Wooden Cow to each other location."},
    {name = "Helios", cost = 5, power = 7, text = "End of Turn: Discard this."},
    {name = "Mnemosyne", cost = 2, power = 3, text = "When Revealed: Add a copy of the last card you played to your hand."}
}

return cardData