import XCTest
@testable import CoreDB

final class CoreDBTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CoreDB().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
