//
//  league.swift
//  Sports
//
//  Created by Kirolos Malak on 3/1/21.
//

import Foundation

class League {
    
    var idLeague: String?
    var strLeague: String?
    var strSport: String?
    var strLeagueAlternate: String?
    
    var strYoutube: String = ""
    var strBadge: String = ""
    
    init(idLeague: String, strLeague: String, strSport: String, strLeagueAlternate: String) {

        self.idLeague = idLeague
        self.strLeague = strLeague
        self.strSport = strSport
        self.strLeagueAlternate = strLeagueAlternate
    }
    
    init(idLeague: String, strLeague: String, strSport: String, strLeagueAlternate: String, strYoutube: String, strBadge: String) {

        self.idLeague = idLeague
        self.strLeague = strLeague
        self.strSport = strSport
        self.strLeagueAlternate = strLeagueAlternate
        
        self.strYoutube = strYoutube
        self.strBadge = strBadge
    }
}
