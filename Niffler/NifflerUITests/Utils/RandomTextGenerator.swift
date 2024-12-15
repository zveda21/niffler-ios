//
//  RandomTextGenerator.swift
//  Niffler
//
//  Created by Mac Zi_Yan on 15.12.24.
//

class RandomTextGenerator {
    func generateRandomString(length: Int = 6) -> String {
        let characters =
            "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in characters.randomElement()! })
    }
}
