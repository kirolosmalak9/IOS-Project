//
//  Sport.swift
//  Sports
//
//  Created by Kirolos Malak on 2/28/21.
//

import Foundation


class Sport {
    
    public var idSport: String?
    public var strSport: String?
    public var strFormat: String?
    public var strSportThumb: String?
    public var strSportDescription: String?
    
    init(idSport: String, strSport: String, strFormat: String, strSportThumb: String, strSportDescription: String) {

        self.idSport = idSport
        self.strSport = strSport
        self.strFormat = strFormat
        self.strSportThumb = strSportThumb
        self.strSportDescription = strSportDescription
    }
}

