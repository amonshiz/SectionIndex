import XCTest
@testable import SectionIndex

final class SectionIndexTests: XCTestCase {
  func test_SectionIndexIsInDescription() {
    let indices = ["A", "B", "C"]
    let index = SectionIndex(indices) { _ in }

    let indexMirror = Mirror(reflecting: index)
    XCTAssert(indexMirror.description.contains("SectionIndex<String>"))
  }
  func test_BodyContainsExpectedContent() {
    let indices = ["A", "B", "C"]
    let index = SectionIndex(indices) { _ in }
    let body = index.body

    let bodyMirror = Mirror(reflecting: body)
    let innerData = bodyMirror.descendant(
      "content"   // SwiftUI.HStack
      , "_tree"   // SwiftUI._VariadicView.Tree
      , "content" // SwiftUI.TupleView
      , "value"   // (2 elements)
      , ".1"      // SwiftUI.ModifiedContent
      , "content" // SwiftUI.VStack
      , "_tree"   // SwiftUI._VariadicView.Tree
      , "content" // SwiftUI.ForEach
      , "data"    // 3 elements
    )

    XCTAssertEqual(innerData as! [String], indices)
  }

  static var allTests = [
    ("test_SectionIndexIsInDescription", test_SectionIndexIsInDescription),
    ("test_BodyContainsExpectedContent", test_BodyContainsExpectedContent)
  ]
}
