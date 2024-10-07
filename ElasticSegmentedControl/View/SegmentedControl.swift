//
//  SegmentedControl.swift
//  ElasticSegmentedControl
//
//  Created by Mohammed Rokon Uddin on 10/7/24.
//

import SwiftUI

struct SegmentedControl<Indicator: View>: View {
  var tabs: [SegmentedTab]
  @Binding var activeTab: SegmentedTab
  var height: CGFloat = 46

  let displayText: Bool
  let font: Font
  let activeTint: Color
  let inactiveTint: Color

  @ViewBuilder var indicatorView: (CGSize) -> Indicator
  @State private var minX: CGFloat = .zero
  @State private var excessTabWidth: CGFloat = .zero

  var body: some View {
    GeometryReader {
      let size = $0.size
      let containerWidthForEachTab = size.width / CGFloat(tabs.count)

      HStack(spacing: 0) {
        ForEach(tabs, id: \.rawValue) { tab in
          Group {
            if displayText {
              Text(tab.rawValue)
            } else {
              Image(systemName: tab.rawValue)
            }
          }
          .font(font)
          .foregroundStyle(activeTab == tab ? activeTint : inactiveTint)
          .animation(.snappy, value: activeTab)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .contentShape(.rect)
          .onTapGesture {
            if let index = tabs.firstIndex(of: tab), let activeIndex = tabs.firstIndex(of: activeTab) {
              activeTab = tab
              withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                excessTabWidth = containerWidthForEachTab * CGFloat(index - activeIndex)
              } completion: {
                withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                  minX = containerWidthForEachTab * CGFloat(index)
                  excessTabWidth = 0
                }
              }
            }
          }
          .background(alignment: .leading) {
            if tabs.first == tab {
              GeometryReader {
                let size = $0.size
                indicatorView(size)
                  .frame(width: size.width + abs(excessTabWidth), height: size.height)
                  .frame(width: size.width, alignment: excessTabWidth < 0 ? .trailing : .leading)
                  .offset(x: minX)
              }
            }
          }
        }
      }
      .preference(key: SizeKey.self, value: size)
      .onPreferenceChange(SizeKey.self) { size in
        if let index = tabs.firstIndex(of: activeTab) {
          minX = containerWidthForEachTab * CGFloat(index)
          excessTabWidth = 0
        }
      }
    }
    .frame(height: height)
  }
}
