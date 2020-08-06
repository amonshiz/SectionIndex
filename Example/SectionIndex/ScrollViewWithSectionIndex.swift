//
//  ScrollViewWithSectionIndex.swift
//  SectionIndex_Example
//
//  Created by Andrew Monshizadeh on 7/22/20.
//  Copyright © 2020 Andrew Monshizadeh. All rights reserved.
//

import SwiftUI
import SectionIndex

@available (iOS 14.0, *)
struct ScrollViewWithSectionIndex: View {
  let contactMap: [String: [Contact]]
  let contactSections: [String]

  init(_ contactMap: [String: [Contact]]) {
    self.contactMap = contactMap
    self.contactSections = contactMap.keys.sorted()
  }

  @State private var selectedSection: String?

  var body: some View {
    ScrollViewReader { scrollViewProxy in
      List {
        ForEach(contactSections, id: \.self) { section in
          Section(header: Text(section)) {
            ForEach(contactMap[section]!, id: \.self) { contact in
              (Text(contact.first) + Text(" ") + Text(contact.last))
                .padding([.top, .bottom], 2)
            }
          }
        }
        .onChange(of: selectedSection) { section in
          scrollViewProxy.scrollTo(selectedSection, anchor: UnitPoint.top)
        }
      }
    }
    .overlay(
      SectionIndex(contactSections) { section in
        selectedSection = section
      }
    )
  }
}

struct ScrollViewWithSectionIndex_Previews: PreviewProvider {
  static var previews: some View {
    if #available(iOS 14.0, *) {
      ScrollViewWithSectionIndex([
        "S": [
          Contact(title: "", first: "Andrew", last: "Someone")
        ],
      ])
    } else {
      EmptyView()
    }
  }
}
