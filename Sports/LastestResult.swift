//
//  LastestResult.swift
//  Sports
//
//  Created by Kirolos Malak on 3/6/21.
//

import Foundation

class LastestResult {
    
    var homeTeam: String?
    var secondTeam: String?
    var homeScore: String?
    var secondScore: String?
    var time: String?
    var date: String?
    
    
    init(homeTeam: String, secondTeam: String, homeScore: String, secondScore: String, time: String, date: String) {

        self.homeTeam = homeTeam
        self.secondTeam = secondTeam
        self.homeScore = homeScore
        self.secondScore = secondScore
        self.time = time
        self.date = date

    }
}
