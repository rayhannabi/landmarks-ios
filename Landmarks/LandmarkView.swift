//
//  LandmarkView.swift
//  Landmarks
//
//  Created by Md. Rayhan Nabi on 28/6/24.
//

import SwiftUI

struct LandmarkView: View {
  @State var viewModel = LandmarkViewModel()
  
  var body: some View {
    NavigationStack {
      Group {
        if viewModel.errorMessage != nil || viewModel.landmarks.isEmpty {
          ContentUnavailableView(
            "No Landmarks Found",
            systemImage: "exclamationmark.triangle",
            description: Text(viewModel.errorMessage ?? "")
          )
        } else {
          List {
            ForEach(viewModel.landmarks) {
              LandmarkRow(landmark: $0)
            }
          }
          .navigationTitle("Landmarks")
        }
      }
    }
    .onAppear {
      Task {
        await viewModel.loadLandmarks()
      }
    }
  }
}

struct LandmarkRow: View {
  var landmark: Landmark
  
  var body: some View {
    HStack {
      AsyncImage(url: Bundle.main.url(forResource: landmark.imageName + "@2x", withExtension: "jpg")) { image in
        image
          .resizable()
          .scaledToFit()
          .frame(height: 48)
          .clipShape(.rect(cornerRadius: 8))
      } placeholder: {
        ProgressView()
      }
      VStack(alignment: .leading) {
        Text(landmark.name)
        Text(landmark.subtitle)
          .font(.caption)
          .foregroundStyle(.secondary)
      }
    }
  }
}

#Preview {
  LandmarkView()
}
