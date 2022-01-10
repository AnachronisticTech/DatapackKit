import XCTest
@testable import DatapackKit

final class TitleTests: XCTestCase {
    let text = "MyTitle"
    let fadeIn = 5
    let stay = 3
    let fadeOut = 9

    func testClearTitleFromPlayers() throws {
        let command = Minecraft.Title(clearFrom: .namedPlayer("Alex"), .namedPlayer("Steve"))
        XCTAssertEqual("\(command)", "title Alex Steve clear")
    }

    func testResetTitleForPlayers() throws {
        let command = Minecraft.Title(resetFor: .namedPlayer("Alex"), .namedPlayer("Steve"))
        XCTAssertEqual("\(command)", "title Alex Steve reset")
    }

    func testSetTitleForPlayers() throws {
        let command = Minecraft.Title(
            setTitle: text,
            for: .namedPlayer("Alex"), .namedPlayer("Steve")
        )
        XCTAssertEqual("\(command)", "title Alex Steve title \"\(text)\"")
    }

    func testSetSubtitleForPlayers() throws {
        let command = Minecraft.Title(
            setSubtitle: text,
            for: .namedPlayer("Alex"), .namedPlayer("Steve")
        )
        XCTAssertEqual("\(command)", "title Alex Steve subtitle \"\(text)\"")
    }

    func testSetActionBarTextForPlayers() throws {
        let command = Minecraft.Title(
            setActionBarText: text,
            for: .namedPlayer("Alex"), .namedPlayer("Steve")
        )
        XCTAssertEqual("\(command)", "title Alex Steve actionbar \"\(text)\"")
    }

    func testSetTitleTimingsForPlayers() throws {
        let command = Minecraft.Title(
            fadeIn: fadeIn,
            stay: stay,
            fadeOut: fadeOut,
            for: .namedPlayer("Alex"), .namedPlayer("Steve")
        )
        XCTAssertEqual("\(command)", "title Alex Steve times \(fadeIn) \(stay) \(fadeOut)")
    }
}
