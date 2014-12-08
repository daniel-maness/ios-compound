//
//  DataAccess.swift
//  Compound
//
//  Created by Daniel Maness on 11/14/14.
//  Copyright (c) 2014 Daniel Maness. All rights reserved.
//

import Foundation

class DataAccess {
    func getAllWords() -> [Word] {
        var streamReader = StreamReader(fileName: "keywords")
        var rawList: Array<NSString> = streamReader.getWords()
        
        var words = [Word]()
        var id = 1
        for word in rawList {
            words.append(Word(id: id, name: String(word)))
            id++
        }
        //words.append(Word(id: 1, name: "bird"))
        //words.append(Word(id: 2, name: "boat"))
        //words.append(Word(id: 3, name: "craft"))
        //words.append(Word(id: 4, name: "house"))
        //words.append(Word(id: 5, name: "water"))
        
        return words
    }
    
    func getAllWordPairs(keyword: Word) -> [WordPair] {
        var streamReader = StreamReader(fileName: "combinations")
        var rawList: Array<NSString> = streamReader.getWords()
        
        var wordPairs = [WordPair]()
        for word in rawList {
            if word.length >= countElements(keyword.Name) {
                var left = word.substringToIndex(countElements(keyword.Name))
                var right = word.substringFromIndex(countElements(keyword.Name))
                
                if left == keyword.Name || right == keyword.Name {
                    var pair = WordPair(keyword: keyword, leftWord: Word(id: 1, name: left), rightWord: Word(id: 2, name: right))
                    wordPairs.append(pair)
                }
            }
        }
        
        //wordPairs.append(WordPair(keyword: keyword, leftWord: Word(id: 1, name: "bird"), rightWord: Word(id: 4, name: "house")))
        //wordPairs.append(WordPair(keyword: keyword, leftWord: Word(id: 2, name: "boat"), rightWord: Word(id: 4, name: "house")))
        //wordPairs.append(WordPair(keyword: keyword, leftWord: Word(id: 4, name: "house"), rightWord: Word(id: 3, name: "craft")))
        
        return wordPairs
    }
    
    func getChallenge() -> Challenge {
        var challenge = Challenge()
        
        return challenge
    }
    
    func getChallenge(id: Int) -> Challenge {
        var challenge = Challenge()
        
        return challenge
    }
    
    func saveChallenge() {
        
    }
    
    func deleteChallenge(id: Int) {
        
    }
    
    func getUser() {
        
    }
    
    func addUser() {
        
    }
    
    func updateUser(id: Int) {
        
    }
    
    func deleteUser(id: Int) {
        
    }
    
    func populateWordTable() {
        var streamReader = StreamReader(fileName: "keywords")
        var rawList: Array<NSString> = streamReader.getWords()

    }
    
    func populateCombinationTable() {
        
    }
}
