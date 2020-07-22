//
//  ScrollViewWithSectionIndex.swift
//  ListSectionIndex_Example
//
//  Created by Andrew Monshizadeh on 7/22/20.
//  Copyright © 2020 Andrew Monshizadeh. All rights reserved.
//

import SwiftUI
import ListSectionIndex

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
    ScrollView {
      ScrollViewReader { scrollViewProxy in
        ForEach(contactSections, id: \.self) { section in
          SectionHeader(sectionTitle: section)
          ForEach(contactMap[section]!, id: \.self) { contact in
            ContactRow(contact: contact)
              .padding([.leading])
              .padding([.top, .bottom], 5)
          }
        }
        .onChange(of: selectedSection) { section in
          scrollViewProxy.scrollTo(selectedSection, anchor: UnitPoint.top)
        }
      }
    }
    .overlay(
      ListSectionIndex(contactSections) { section in
        selectedSection = section
      }
    )
  }
}

struct SectionHeader: View {
  let sectionTitle: String

  var body: some View {
    HStack {
      Text(sectionTitle)
        .padding([.leading])
      Spacer()
    }
    .id(sectionTitle)
    .padding([.top, .bottom], 5)
    .background(
      Color(UIColor.secondarySystemFill)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    )
  }
}

struct ContactRow: View {
  let contact: Contact

  var body: some View {
    HStack {
      Text(contact.first) + Text(" ") + Text(contact.last)
      Spacer()
    }
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
