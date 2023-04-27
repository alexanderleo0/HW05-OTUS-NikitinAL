//
//  ViewModel.swift
//  HW05-OTUS-NikitinAL
//
//  Created by Александр Никитин on 27.04.2023.
//

import Foundation
import SwiftUI
import Combine

class ViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var sortedSuffixes : Array<(key: String, value: Int)> = .init()
    @Published var topSuffix : Array<(key: String, value: Int)> = .init()
    
    private var suffixSortBy: suffixSort = .ASC
    private var cancellable: AnyCancellable?
    private var suffixs : [String : Int] = .init()
    
    init() {
        cancellable = $text
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self else { return }
                let words = text.split(separator: #/\s+/#)
                let suffixArray = words.flatMap{ SuffixSequence(forWord: String($0)).map { $0 } }
                self.suffixs = suffixArray.reduce(into: [:]) { partialResult, str in
                    partialResult[str, default: 0] += 1
                }
                self.sortSuffixes(by: self.suffixSortBy)
                
                self.topSuffix = self.sortedSuffixes
                    .filter { $0.key.count == 3 }
                    .sorted {$0.value > $1.value}
            }
    }
    
    func sortSuffixes(by suffixSortType: suffixSort) {
        self.suffixSortBy = suffixSortType
        switch suffixSortType {
            case .ASC:
                self.sortedSuffixes = self.suffixs.sorted(by: <)
            case .DESC:
                self.sortedSuffixes = self.suffixs.sorted(by: >)
        }
    }
}

enum suffixSort {
    case ASC
    case DESC
}
