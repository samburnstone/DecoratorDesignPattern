protocol HealthHaving {
    var hitPoints: Int { get }
}

protocol CharacterAddOns: HealthHaving {
    var character: HealthHaving { get }
}

struct Character: HealthHaving {
    let hitPoints = 10
}

struct CharacterWithShield: CharacterAddOns {
    let character: HealthHaving
    private let shieldBonus = 10

    var hitPoints: Int {
        return character.hitPoints + shieldBonus
    }
}

struct CharacterWithHelmet: CharacterAddOns {
    let character: HealthHaving
    private let helmetBonus = 5

    var hitPoints: Int {
        return character.hitPoints + helmetBonus
    }
}

let sam = Character()
let helmetCharacter = CharacterWithHelmet(character: sam)
helmetCharacter.hitPoints

let shieldCharacter = CharacterWithShield(character: sam)
shieldCharacter.hitPoints

let characterWithShieldAndHelmet = CharacterWithHelmet(character: shieldCharacter)
characterWithShieldAndHelmet.hitPoints
