//
//  ViewController.swift
//  ListSectionIndexView
//
//  Created by Andrew Monshizadeh on 07/22/2020.
//  Copyright (c) 2020 Andrew Monshizadeh. All rights reserved.
//

import UIKit
import SwiftUI
import ListSectionIndexView

class ViewController: UIViewController {

  private let contactSections: [String]
  private let contactMap: [String: [Contact]]
  private var tableView: UITableView?

  init(contactMap: [String: [Contact]]) {
    self.contactMap = contactMap
    self.contactSections = contactMap.keys.sorted()
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    let controller =
      UIHostingController(
        rootView:
          ListSectionIndex<String>(contactSections) { [weak self] section in
            guard let index = self?.contactSections.firstIndex(of: section) else { return }
            self?.tableView?.scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: false)
          })
    setupWith(hostingController: controller)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupWith(hostingController: UIViewController) {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.rowHeight = UITableView.automaticDimension
    tableView.dataSource = self

    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
    self.tableView = tableView

    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    hostingController.view.backgroundColor = .clear

    addChild(hostingController)
    view.addSubview(hostingController.view)
    hostingController.didMove(toParent: self)

    NSLayoutConstraint.activate([
      hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      hostingController.view.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
    ])
  }
}

extension ViewController: UITableViewDataSource {
  private func contactsFor(_ section: Int) -> [Contact]? {
    guard section < contactSections.count else { return nil }

    let sectionKey = contactSections[section]
    return contactMap[sectionKey]
  }

  private func contactFor(_ indexPath: IndexPath) -> Contact? {
    guard let contacts = contactsFor(indexPath.section) else { return nil }
    guard indexPath.row < contacts.count else { return nil }

    return contacts[indexPath.row]
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    contactSections.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (contactsFor(section) ?? []).count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
    if let contact = contactFor(indexPath) {
      cell.textLabel?.text = "\(contact.first) \(contact.last)"
    }

    return cell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard section < contactSections.count else { return nil }
    return contactSections[section]
  }
}

