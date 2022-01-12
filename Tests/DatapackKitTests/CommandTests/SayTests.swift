import XCTest
@testable import DatapackKit

final class SayTests: XCTestCase {
    func testSayEmptyMessage() throws {
        let command = Minecraft.Commands.Say("")
        XCTAssertEqual("\(command)", "say ")
    }

    func testSayMessage() throws {
        let command = Minecraft.Commands.Say("Hello world!")
        XCTAssertEqual("\(command)", "say Hello world!")
    }
}
