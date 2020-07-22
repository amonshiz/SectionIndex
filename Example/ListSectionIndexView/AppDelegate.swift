//
//  AppDelegate.swift
//  ListSectionIndexView
//
//  Created by Andrew Monshizadeh on 07/22/2020.
//  Copyright (c) 2020 Andrew Monshizadeh. All rights reserved.
//

import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  private func rootSwiftUIView(with contactMap: [String: [Contact]]) -> some View {
    return Group {
      if #available(iOS 14.0, *) {
        ScrollViewWithSectionIndex(contactMap)
      } else {
        Text("Only available in iOS 14+")
      }
    }
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    let url = Bundle.main.url(forResource: "contacts", withExtension: "json")
    let contacts: ContactList
    do {
      let data = try Data(contentsOf: url!)
      let decoder = JSONDecoder()
      contacts = try decoder.decode(ContactList.self, from: data)
    } catch {
      fatalError()
    }

    let contactMap: [String: [Contact]] =
      contacts.results.reduce(into: [:]) { acc, c in
        let firstLetter = String(c.last.first ?? "_")
        var cList = acc[firstLetter, default: []]
        cList.append(c)
        acc[firstLetter] = cList
      }

    let window = UIWindow()
    let tabVC = UITabBarController()
    let iOS13VC = ViewController(contactMap: contactMap)
    iOS13VC.tabBarItem = UITabBarItem(title: "iOS 13-", image: UIImage(systemName: "gobackward.minus"), tag: 0)

    let iOS14VC = UIHostingController(rootView: rootSwiftUIView(with: contactMap))
    iOS14VC.tabBarItem = UITabBarItem(title: "iOS 14", image: UIImage(systemName: "hand.thumbsup.fill"), tag: 1)

    tabVC.setViewControllers([iOS13VC, iOS14VC], animated: false)
    window.rootViewController = tabVC
    self.window = window

    window.makeKeyAndVisible()

    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

