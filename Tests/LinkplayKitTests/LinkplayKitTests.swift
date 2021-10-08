import XCTest
@testable import LinkplayKit

final class LinkplayKitTests: XCTestCase {
    func testExample() throws {

        func testVersion() throws {
            XCTAssertEqual(Linkplay.version, "0.1.0")
        }

    }
}
