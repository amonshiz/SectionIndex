//
//  Models.swift
//  ListSectionIndexView_Example
//
//  Created by Andrew Monshizadeh on 7/22/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

struct ContactList: Decodable {
  let results: [Contact]
}

struct Contact: Decodable {
  let title: String
  let first: String
  let last: String

  private enum NameCodingKeys: String, CodingKey {
    case name
  }

  enum InnerCodingKeys: String, CodingKey {
    case title
    case first
    case last
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: NameCodingKeys.self)

    let innerContainer = try container.nestedContainer(keyedBy: InnerCodingKeys.self, forKey: NameCodingKeys.name)

    let title = try innerContainer.decode(String.self, forKey: InnerCodingKeys.title)
    let first = try innerContainer.decode(String.self, forKey: InnerCodingKeys.first)
    let last = try innerContainer.decode(String.self, forKey: InnerCodingKeys.last)

    self.title = title
    self.first = first
    self.last = last
  }
}
