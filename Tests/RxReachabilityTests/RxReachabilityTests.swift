import XCTest
@testable import RxReachability

final class RxReachabilityTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RxReachability().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
