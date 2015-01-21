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
        let db = SQLiteDB.sharedInstance()
        let data = db.query("SELECT * FROM Word")
        
        var words = [Word]()
        for row in data {
            let id = row["Id"]?.asInt()
            let name = row["Name"]?.asString()
            words.append(Word(id: id!, name: name!))
        }
        
        return words
    }
    
    func getAllWordPairs(keyword: Word) -> [WordPair] {
        let db = SQLiteDB.sharedInstance()
        let data = db.query("SELECT * FROM WordPair wp WHERE wp.FirstId = " + String(keyword.Id) + " OR wp.SecondId = " + String(keyword.Id))
        var wordPairs = [WordPair]()
        
        for row in data {
            let first = Word(id: row["FirstId"]!.asInt(), name: row["FirstName"]!.asString())
            let second = Word(id: row["SecondId"]!.asInt(), name: row["SecondName"]!.asString())
            wordPairs.append(WordPair(keyword: keyword, leftWord: first, rightWord: second))
        }
        
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
    
    
    /********** Database Functions **********/
    
    func populateWordTable() {
        var streamReader = StreamReader(fileName: "keywords")
        var rawList: Array<NSString> = streamReader.getWords()
        
        for word in rawList {
            insertWord(word)
        }
    }
    
    func populateCombinationTable() {
        var words = getAllWords()

        var streamReader = StreamReader(fileName: "combinations")
        var rawList: Array<NSString> = streamReader.getWords()
        
        
        
        for combo in rawList {
            for word in words {
                if (combo.containsString(word.Name)) {
                    var firstWord = combo.substringToIndex(countElements(word.Name))
                    if firstWord == word.Name {
                        var secondWord = combo.substringFromIndex(countElements(firstWord))
                        if getCombinationId(firstWord, secondWord: secondWord) == 0 {
                                insertCombination(firstWord, secondWord: secondWord)
                        }
                    } else {
                        firstWord = combo.substringToIndex(combo.length - countElements(word.Name))
                        var secondWord = combo.substringFromIndex(combo.length - countElements(word.Name))
                        
                        if secondWord == word.Name && getCombinationId(firstWord, secondWord: secondWord) == 0 {
                            insertCombination(firstWord, secondWord: secondWord)
                        }
                    }
                }
            }
        }
    }
    
    func getWord(name: String) -> Word {
        let db = SQLiteDB.sharedInstance()
        let data = db.query("SELECT * FROM Word WHERE Name = '" + name + "'")
        
        if (data.count == 0) {
            return Word(id: 0, name: "")
        }
        
        return Word(id: data[0]["Id"]!.asInt(), name: data[0]["Name"]!.asString())
    }
    
    func getCombinationId(firstWord: String, secondWord: String) -> Int {
        let db = SQLiteDB.sharedInstance()
        let first = getWord(firstWord)
        let second = getWord(secondWord)
        
        if (first.Id > 0 && second.Id > 0) {
            let data = db.query("SELECT Id FROM Combination WHERE fk_FirstWordId = " + String(first.Id) + " AND fk_SecondWordId = " + String(second.Id))
            
            if (data.count > 0) {
                return data[0]["Id"]!.asInt()
            }
            
            return 0
        }
        
        return -1
    }
    
    func insertWord(name: String) {
        let db = SQLiteDB.sharedInstance()
        let result = db.execute("INSERT INTO Word (Name) VALUES ('" + name + "')")
    }
    
    func insertCombination(firstWord: String, secondWord: String) {
        let db = SQLiteDB.sharedInstance()
        let first = db.query("SELECT Id FROM Word WHERE Name = '" + firstWord + "'")
        let second = db.query("SELECT Id FROM Word WHERE Name = '" + secondWord + "'")
        
        let firstId = first[0]["Id"]?.asString()
        let secondId = second[0]["Id"]?.asString()
        
        let result = db.execute("INSERT INTO Combination (fk_FirstWordId, fk_SecondWordId) VALUES (" + firstId! + ", " + secondId! + ")")
    }
}
