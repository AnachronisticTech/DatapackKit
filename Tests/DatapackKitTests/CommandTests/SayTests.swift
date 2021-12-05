import XCTest
import class Foundation.Bundle
@testable import DatapackKit

final class SayTests: XCTestCase {
    func testSayEmptyMessage() throws {
        let command = Minecraft.Say("")
        XCTAssertEqual("\(command)", "say ")
    }

    func testSayMessage() throws {
        let command = Minecraft.Say("Hello world!")
        XCTAssertEqual("\(command)", "say Hello world!")
    }
}
