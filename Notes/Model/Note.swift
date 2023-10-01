//
//  Note.swift
//  Notes
//
//  Created by Ricardo Rosales Romero on 22/09/23.
//

import Foundation

struct Note : Codable{
    var title : String
    var content: String
    var date: Date
    var fontSize: Double
    var fontFamily: String
    var fontFamilyRow: Int
}
