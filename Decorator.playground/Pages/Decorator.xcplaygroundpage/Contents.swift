//: [Previous](@previous)

let shieldBonus = 10
let helmetBonus = 5

class Character {
    var hitPoints: Int {
        return 10
    }
}

class CharacterWithShield: Character {
    override var hitPoints: Int {
        return super.hitPoints + shieldBonus
    }
}

class CharacterWithHelmet: Character {
    override var hitPoints: Int {
        return super.hitPoints + helmetBonus
    }
}

let helmetCharacter = CharacterWithHelmet()
helmetCharacter.hitPoints

let shieldedCharacter = CharacterWithShield()
shieldedCharacter.hitPoints

class CharacterWithShieldAndHelmet: CharacterWithShield {
    override var hitPoints: Int {
        return super.hitPoints + helmetBonus
    }
}

let shieldAndHelmetBearingCharacter = CharacterWithShieldAndHelmet()
shieldAndHelmetBearingCharacter.hitPoints

//: [Next](@next)
