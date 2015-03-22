//
//  BusinessLogic.swift
//  Compound
//
//  Created by Daniel Maness on 11/14/14.
//  Copyright (c) 2014 Daniel Maness. All rights reserved.
//

import Foundation

class BusinessLogic {
    var dataAccess = DataAccess()
    
    func getNewChallenge() -> Challenge {
        //dataAccess.populateWordTable()
        //dataAccess.populateWordPairTable()
        var keywords = dataAccess.getAllWords()
        
        var keyword: Word
        
        var allCombinations = [Combination]()
            
        do {
            let randomIndex = Int(arc4random_uniform(UInt32(keywords.count)))
            keyword = keywords[randomIndex]
            
            allCombinations = dataAccess.getAllCombinations(keyword)
        } while allCombinations.count < 3
        
        var combinations = [Combination]()
        for i in 0..<3 {
            let randomIndex = Int(arc4random_uniform(UInt32(allCombinations.count)))
            combinations.append(allCombinations[randomIndex])
            allCombinations.removeAtIndex(randomIndex)
        }
        
        var challenge = Challenge()
        challenge.keyword = keyword
        challenge.combinations = combinations
        
        return challenge
    }
    
    func getExistingChallenge(id: Int) {
        
    }
    
    func useHint(challenge: Challenge) -> (Hint: String, Challenge: Challenge) {
        if challenge.hintsUsed < 3 {
            challenge.hintsUsed++
        }
        
        var hint = ""
        if challenge.hintsUsed == 1 {
            hint = "___"
        } else if challenge.hintsUsed == 2 {
            for i in 0..<countElements(challenge.keyword.Name) {
                hint += "_ "
            }
        } else if challenge.hintsUsed == 3 {
            hint = challenge.keyword.Name.subStringTo(1)
            for i in 1..<countElements(challenge.keyword.Name) {
                hint += "_ "
            }
        }
        
        return (hint, challenge)
    }
    
    func checkAnswer(answer: String, challenge: Challenge) -> (Success: Bool, Challenge: Challenge) {
        challenge.guesses.append(answer)
        
        if answer == challenge.keyword.Name {
            return (true, challenge)
        } else {
            return (false, challenge)
        }
    }
    
    func calculatePoints (numGuesses: Int) -> Int {
        switch numGuesses
        {
        case 1:
            return 13
        case 2:
            return 8
        case 3:
            return 5
        case 4:
            return 3
        case 5:
            return 2
        default:
            return 1
        }
    }
}