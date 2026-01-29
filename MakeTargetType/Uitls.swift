//
//  Uitls.swift
//  MakeTargetType
//
//  Created by Gab on 1/28/26.
//

import Foundation

func today() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    return formatter.string(from: Date())
}

func thisYear() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter.string(from: Date())
}

func lowercasedFirst(_ str: String) -> String {
    guard let first = str.first else { return str }
    return String(first).lowercased() + str.dropFirst()
}

func uppercasedFirst(_ str: String) -> String {
    guard let first = str.first else { return str }
    return String(first).uppercased() + str.dropFirst()
}
