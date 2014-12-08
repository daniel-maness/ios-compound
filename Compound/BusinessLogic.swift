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
        var keywords = dataAccess.getAllWords()
        
        var keyword: Word
        
        var allWordPairs = [WordPair]()
            
        do {
            let randomIndex = Int(arc4random_uniform(UInt32(keywords.count)))
            keyword = keywords[randomIndex]
            
            allWordPairs = dataAccess.getAllWordPairs(keyword)
        } while allWordPairs.count < 3
        
        var wordPairs = [WordPair]()
        for i in 0..<3 {
            let randomIndex = Int(arc4random_uniform(UInt32(allWordPairs.count)))
            wordPairs.append(allWordPairs[randomIndex])
            allWordPairs.removeAtIndex(randomIndex)
        }
        
        var challenge = Challenge()
        challenge.keyword = keyword
        challenge.wordPairs = wordPairs
        
        return challenge
    }
    
    func getExistingChallenge(id: Int) {
        
    }
    
    func checkAnswer(answer: String, challenge: Challenge) -> (Success: Bool, Challenge) {
        challenge.guesses.append(answer)
        
        if answer == challenge.keyword.Name {
            challenge.totalPoints = calculatePoints(challenge.guesses.count)
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