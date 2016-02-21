//
//  PreviewBattleScene.swift
//  KittyWarz
//
//  Created by Sahaj Bhatt on 2/20/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation

class PreviewBattleScene: CCNode {

    weak var you : CCNode!
    weak var opponent : CCNode!
    weak var yourLevel : CCLabelTTF!
    weak var oppLevel : CCLabelTTF!
    weak var yourHP : CCLabelTTF!
    weak var oppHP : CCLabelTTF!
    weak var ranged : CCButton!
    weak var melee : CCButton!
    weak var defense : CCButton!
    weak var scroll : CCNode!
    weak var menu : CCNode!
    var spriteHero : CCSprite!
    var spriteEnemy : CCSprite!
    
    func didLoadFromCCB() {
        print("add child")
        spriteHero = hero.sprite
        spriteEnemy = enemy.sprite
        if (enemy.kittyType == "Ninja") {
            (spriteEnemy.getChildByName("NinjaKitty", recursively: false) as! CCSprite).flipX = true
        } else {
            (spriteEnemy.getChildByName("PirateKitty", recursively: false) as! CCSprite).flipX = true
        }
        //(spriteEnemy.getChildByName("NinjaKitty", recursively: false).getChildByName("katana", recursively: false) as! CCSprite).flipX = true
        spriteHero.scale = 0.002 * Float(self.contentSize.height)
        spriteEnemy.scale = 0.002 * Float(self.contentSize.height)
        you.addChild(spriteHero)
        opponent.addChild(spriteEnemy)
        yourLevel.string = String(hero.level)
        oppLevel.string = String(enemy.level)
        yourHP.string = String(hero.baseHP)
        oppHP.string = String(enemy.baseHP)
        
        
        print("hi")
    }
    
    //spriteHero.runAnimationSequenceNamed...
    func useAbility(sender: CCButton!) {
        print(sender)
        var map = hero.displayAbilities()
        let rand = Int(arc4random_uniform(UInt32(2)))
        var ended = false
        var enemyAbility = Ability()
        var heroAbility = Ability()
        if (rand == 0) {
            enemyAbility = enemy.enemyPerformAbility(hero)
            switch (enemyAbility.abilityType) {
            case "Melee":
                if (enemy.kittyType == "Ninja") {
                    spriteEnemy.animationManager.runAnimationsForSequenceNamed("katanaAttack");
                } else {
                    spriteEnemy.animationManager.runAnimationsForSequenceNamed("CutlassAttack")
                }
                break
            case "Ranged":
                if (enemy.kittyType == "Ninja") {
                    spriteEnemy.animationManager.runAnimationsForSequenceNamed("shurikenAttack");
                } else {
                    spriteEnemy.animationManager.runAnimationsForSequenceNamed("gunAttack")
                }
                break
            default :
                break
            }
            print(enemy.name + " used " + enemyAbility.name)
            if (hero.currentHP <= 0) {
                yourHP.string = String(0)
                print("YOU LOSE")
                ended = true
            } else {
                yourHP.string = String(hero.currentHP)
                oppHP.string = String(enemy.currentHP)
                heroAbility = hero.performAbility(map[sender.title]!, enemy: enemy)
                switch (heroAbility.abilityType) {
                case "Melee":
                    if (hero.kittyType == "Ninja") {
                        spriteHero.animationManager.runAnimationsForSequenceNamed("katanaAttack");
                    } else {
                        spriteHero.animationManager.runAnimationsForSequenceNamed("CutlassAttack")
                    }
                    break
                case "Ranged":
                    if (hero.kittyType == "Ninja") {
                        spriteHero.animationManager.runAnimationsForSequenceNamed("shurikenAttack");
                    } else {
                        spriteHero.animationManager.runAnimationsForSequenceNamed("gunAttack")
                    }
                    break
                default :
                    break
                }

                print(hero.name + " used " + heroAbility.name)
                yourHP.string = String(hero.currentHP)
                if (enemy.currentHP <= 0) {
                    oppHP.string = String(0)
                    print("YOU WON")
                    ended = true
                } else {
                    oppHP.string = String(enemy.currentHP)
                }
            }
        } else {
            heroAbility = hero.performAbility(map[sender.title]!, enemy: enemy)
            switch (heroAbility.abilityType) {
            case "Melee":
                if (hero.kittyType == "Ninja") {
                    spriteHero.animationManager.runAnimationsForSequenceNamed("katanaAttack");
                } else {
                    spriteHero.animationManager.runAnimationsForSequenceNamed("CutlassAttack")
                }
                break
            case "Ranged":
                if (hero.kittyType == "Ninja") {
                    spriteHero.animationManager.runAnimationsForSequenceNamed("shurikenAttack");
                } else {
                    spriteHero.animationManager.runAnimationsForSequenceNamed("gunAttack")
                }
                break
            default :
                break
            }
            print(hero.name + " used " + heroAbility.name)
            if (enemy.currentHP <= 0) {
                oppHP.string = String(0)
                print("YOU WON")
                ended = true
            } else {
                oppHP.string = String(enemy.currentHP)
                yourHP.string = String(hero.currentHP)
                enemyAbility = enemy.enemyPerformAbility(hero)
                switch (enemyAbility.abilityType) {
                case "Melee":
                    if (enemy.kittyType == "Ninja") {
                        spriteEnemy.animationManager.runAnimationsForSequenceNamed("katanaAttack");
                    } else {
                        spriteEnemy.animationManager.runAnimationsForSequenceNamed("CutlassAttack")
                    }
                    break
                case "Ranged":
                    if (enemy.kittyType == "Ninja") {
                        spriteEnemy.animationManager.runAnimationsForSequenceNamed("shurikenAttack");
                    } else {
                        spriteEnemy.animationManager.runAnimationsForSequenceNamed("gunAttack")
                    }
                    break
                default :
                    break
                }
                print(enemy.name + " used " + enemyAbility.name)
                oppHP.string = String(enemy.currentHP)
                if (hero.currentHP <= 0) {
                    yourHP.string = String(0)
                    print("YOU LOSE")
                    ended = true
                } else {
                    yourHP.string = String(hero.currentHP)
                }
            }
            
        }
        if (ended) {
            
        }
        
    }
    
    func getRanged() {
        print("map")
        let map = hero.displayRangedAbilities()
        var index = 0.0
        for ability in map.values {
            let button = CCButton(title: ability.name)
            button.name = ability.name
            button.positionType = CCPositionTypeNormalized
            button.position.x = 0.50
            button.position.y = CGFloat(Float(0.90 - (0.20 * index)))
            button.setTarget(self, selector: "useAbility:")
            scroll.addChild(button)
            index = index + 1.0
        }

        print("done")
    }
    
    func getMelee() {
        print("map")
        let map = hero.displayMeleeAbilities()
        var index = 0.0
        for ability in map.values {
            let button = CCButton(title: ability.name)
            button.positionType = CCPositionTypeNormalized
            button.position.x = 0.50
            button.position.y = CGFloat(Float(0.90 - (0.20 * index)))
            button.setTarget(self, selector: "useAbility:")
            scroll.addChild(button)
            index = index + 1.0
        }
//        scroll.removeFromParent()
//        let scrollView = CCScrollView(contentNode: scroll)
//        print("scrollview positioin stuff")
//        //scrollView.positionType = CCPositionTypeNormalized
//        scrollView.position.x = 20
//        scrollView.position.y = 4
//        //scrollView.contentSize.width = 0.79 //* menu.contentSize.width
//        //scrollView.contentSize.height = 0.92 //* menu.contentSize.height
//        print("add scrollview to menu")
//        menu.addChild(scrollView)
//        print(scrollView.position)
        print("done")
    }
    
    func getDefense() {
        print("map")
        let map = hero.displayDefenseAbilities()
        var index = 0.0
        for ability in map.values {
            let button = CCButton(title: ability.name)
            button.positionType = CCPositionTypeNormalized
            button.position.x = 0.50
            button.position.y = CGFloat(Float(0.90 - (0.20 * index)))
            button.setTarget(self, selector: "useAbility:")
            scroll.addChild(button)
            index = index + 1.0
        }
        print("done")
    }
}
