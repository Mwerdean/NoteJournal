//
//  Notes.swift
//  Unit 1 Challenge
//
//  Created by Matthew Werdean on 2/28/20.
//  Copyright © 2020 Matthew Werdean. All rights reserved.
//

import Foundation

class Note: Codable {
    var noteTitle: String
    var noteText: String
    var timestamp: Date
    
    init(noteTitle: String, noteText: String, timestamp: Date = Date()) {
        self.noteTitle = noteTitle
        self.noteText = noteText
        self.timestamp = timestamp
    }

} // End of class

// Extending the class `Note` to conform to the Equatable protocol
extension Note: Equatable {
    static func  == (lhs: Note, rhs: Note) -> Bool {
        return
            // Compare properties to find the correct note
            lhs.noteTitle == rhs.noteTitle &&
            lhs.noteText == rhs.noteText &&
            lhs.timestamp == rhs.timestamp
            
    }
}
