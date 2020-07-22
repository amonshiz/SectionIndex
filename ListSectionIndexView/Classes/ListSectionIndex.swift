//
//  ListSectionIndex.swift
//  ListSectionIndexView
//
//  Created by Andrew Monshizadeh on 7/21/20.
//

import SwiftUI

public struct ListSectionIndex<T: Hashable & CustomStringConvertible>: View {
  private let sectionIndices: [T]

  public typealias SectionSelectionAction = (T) -> ()
  private let sectionAction: SectionSelectionAction

  public init(_ indices: [T], action: @escaping SectionSelectionAction) {
    self.sectionIndices = indices
    self.sectionAction = action
  }

  public var body: some View {
    HStack {
      Spacer()
      VStack {
        ForEach(sectionIndices, id: \.hashValue) { index in
          Text("\(index.description)")
            .padding([.leading, .trailing], 6)
        }
      }
      .background(
        GeometryReader { geoProxy in
          Color.clear
            .contentShape(Rectangle())
            .frame(width: geoProxy.size.width, height: geoProxy.size.height, alignment: .center)
            .gesture(
              DragGesture(minimumDistance: 0, coordinateSpace: CoordinateSpace.local)
                .onChanged{ info in
                  let indexSize = geoProxy.size.height / CGFloat(sectionIndices.count)
                  let currentIndex = min(max(Int(info.location.y / indexSize), 0), sectionIndices.count - 1)
                  sectionAction(sectionIndices[currentIndex])
                }
            )
        }
      )
    }
    .foregroundColor(.blue)
  }
}

struct ListSectionIndex_Previews: PreviewProvider {
  static var previews: some View {
    ListSectionIndex(["A", "B", "C"]) { _ in }
  }
}