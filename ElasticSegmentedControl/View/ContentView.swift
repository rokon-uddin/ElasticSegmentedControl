//
//  ContentView.swift
//  ElasticSegmentedControl
//
//  Created by Mohammed Rokon Uddin on 10/7/24.
//

import SwiftUI

struct ContentView: View {
  @State private var activeTab: SegmentedTab = .home
  @State private var secondType = false
  var body: some View {
    NavigationStack {
      VStack(spacing: 16) {
        SegmentedControl(
          tabs: SegmentedTab.allCases,
          activeTab: $activeTab,
          height: 36,
          displayText: false,
          font: .body,
          activeTint: secondType ? .white : .primary,
          inactiveTint: .gray.opacity(0.5)
        ) { size in
          RoundedRectangle(cornerRadius: secondType ? 32 : 0)
            .fill(.blue)
            .frame(height: secondType ? size.height : 4)
            .padding(.horizontal, secondType ? 0 : 10)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .padding(secondType ? 0 : 10)
        .background {
          RoundedRectangle(cornerRadius: secondType ? 32 : 0)
            .fill(.ultraThinMaterial)
            .ignoresSafeArea()
        }
        .padding(.vertical, secondType ? 16 : 0)

        Toggle("Segmented Control Type - 2", isOn: $secondType)
          .padding(16)
          .background(.regularMaterial, in: .rect(cornerRadius: 10))
          .padding(16)
        Spacer(minLength: 0)
      }
      .padding(.vertical, secondType ? 16 : 0)
      .animation(.snappy, value: secondType)
      .navigationTitle("Segmented Control")
      .toolbarBackground(.hidden, for: .navigationBar)
    }
  }
}

#Preview {
  ContentView()
    .preferredColorScheme(.dark)
}
