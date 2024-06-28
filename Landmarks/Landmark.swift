//
//  Landmark.swift
//  Landmarks
//
//  Created by Md. Rayhan Nabi on 28/6/24.
//

import Foundation

struct Landmark: Decodable, Identifiable {
  var id: Int
  var name: String
  var subtitle: String
  var imageName: String
}
