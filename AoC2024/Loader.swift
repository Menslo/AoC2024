//
//  Loader.swift
//  AoC2024
//
//  Created by Simon Zwicker on 01.12.24.
//

import Foundation

struct Loader {
    
    enum LoaderError: Error {
        case fileNotFound
        case cannotReadFile
    }
    
    static func readInput(from fileName: String, type: String = "txt") throws(LoaderError) -> [String] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: type) else {
            throw .fileNotFound
        }
        
        do {
            let content = try String(contentsOfFile: path, encoding: .utf8)
            let lines = content.components(separatedBy: .newlines)
            return lines.filter { !$0.isEmpty }
        } catch {
            throw .cannotReadFile
        }
    }
}
