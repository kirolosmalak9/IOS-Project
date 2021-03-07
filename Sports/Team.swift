//
//  Team.swift
//  Sports
//
//  Created by Kirolos Malak on 3/6/21.
//

import Foundation

class Team {
    var image: String?

    var teamName: String?
    var sportName: String?
    var established : String?
    var stadiumLoc : String?
    var stadium : String?
    var subNames : String?
    
    init(image: String, teamName: String, sportName: String, established: String, stadiumLoc: String, stadium: String, subNames: String) {

        self.image = image
        self.teamName = teamName
        self.sportName = sportName
        self.established = established
        self.stadiumLoc = stadiumLoc
        self.stadium = stadium
        self.subNames = subNames

    }
    
}
