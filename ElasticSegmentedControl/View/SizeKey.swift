//
//  SizeKey.swift
//  ElasticSegmentedControl
//
//  Created by Mohammed Rokon Uddin on 10/7/24.
//

import SwiftUI

struct SizeKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}
