//
//  LandmarkRepository.swift
//  Landmarks
//
//  Created by Md. Rayhan Nabi on 28/6/24.
//

import Foundation

// MARK: - LandmarkRepository

struct LandmarkRepository {
  func load() async throws -> [Landmark] {
    guard let jsonFile = Bundle.main.url(forResource: "landmarkData", withExtension: "json") else {
      throw LandmarkError()
    }
    let (jsonData, _) = try await URLSession.shared.data(from: jsonFile)
    let data = isValidJSONData(jsonData) ? jsonData : try attemptJSONCorrection(with: jsonData)
    return try JSONDecoder().decode([Landmark].self, from: data)
  }
  
  private func isValidJSONData(_ data: Data) -> Bool {
    guard let jsonObject = try? JSONSerialization.jsonObject(with: data) else {
      return false
    }
    return JSONSerialization.isValidJSONObject(jsonObject)
  }
  
  private func attemptJSONCorrection(with data: Data) throws -> Data {
    guard let json = String(data: data, encoding: .utf8) else {
      throw LandmarkError()
    }
    
    let isJSONBrackets: (Character) -> Bool = { char in
      char.isWhitespace ||
      char.isNewline ||
      char == "{" ||
      char == "}" ||
      char == "[" ||
      char == "]"
    }
    // single comma insertion
    for index in json.indices where !isJSONBrackets(json[index]) {
      var temp = json
      temp.insert(",", at: index)
      guard let tempData = temp.data(using: .utf8) else { throw LandmarkError() }
      if isValidJSONData(tempData) {
        return tempData
      }
    }
    return data
  }
}

// MARK: - LandmarkError

struct LandmarkError: Error {}
