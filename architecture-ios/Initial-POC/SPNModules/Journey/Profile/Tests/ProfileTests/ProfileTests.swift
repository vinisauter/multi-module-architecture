import XCTest
@testable import Profile

final class ProfileTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Profile().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
