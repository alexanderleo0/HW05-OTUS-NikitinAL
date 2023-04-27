//
//  SuffixSequence.swift
//  HW05-OTUS-NikitinAL
//
//  Created by Александр Никитин on 27.04.2023.
//

import Foundation

struct SuffixSequence: Sequence, IteratorProtocol, Identifiable {

    let id = UUID().uuidString
    private var fullWord: String
    private var currentIndex: String.Index
    
    init(forWord fullWord: String) {
        self.fullWord = fullWord
        self.currentIndex = fullWord.startIndex
    }

    mutating func next() -> String? {
        defer{
            if currentIndex != fullWord.endIndex{
                currentIndex = fullWord.index(after: currentIndex)
            }
        }
        guard currentIndex < fullWord.endIndex else { return nil }
        return String(fullWord.suffix(from: currentIndex))
    }
    
}
