//
//  Challenge.swift
//  Compound
//
//  Created by Daniel Maness on 11/13/14.
//  Copyright (c) 2014 Daniel Maness. All rights reserved.
//

import Foundation

class Challenge {
    var combinations = [Combination]()
    var keyword: Word = Word(id: 0, name: "")
    var guesses: [String] = [String]()
    var hintsUsed: Int = 0
    var points: Int = 0
    var ended: Bool = false
}