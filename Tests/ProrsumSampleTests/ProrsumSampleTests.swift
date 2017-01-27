import XCTest
@testable import ProrsumSample

class ProrsumSampleTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(ProrsumSample().text, "Hello, World!")
    }


    static var allTests : [(String, (ProrsumSampleTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
