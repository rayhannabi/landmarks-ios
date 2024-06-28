//
//  LandmarkViewModel.swift
//  Landmarks
//
//  Created by Md. Rayhan Nabi on 28/6/24.
//

import Foundation

@Observable
class LandmarkViewModel {
  var landmarks: [Landmark] = []
  var errorMessage: String?
  
  private let repository = LandmarkRepository()
  
  func loadLandmarks() async {
    do {
      landmarks = try await repository.load()
    } catch {
      errorMessage = error.localizedDescription
    }
  }
}
