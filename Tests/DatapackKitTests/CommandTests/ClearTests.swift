import XCTest
@testable import DatapackKit

final class ClearTests: XCTestCase {
    let item = "minecraft:cobblestone"
    let count = 10

    func testClearAll() throws {
        let command = Minecraft.Clear()
        XCTAssertEqual("\(command)", "clear")
    }

    func testClearAllFromPlayer() throws {
        let command = Minecraft.Clear(.namedPlayer("Alex"))
        XCTAssertEqual("\(command)", "clear Alex")
    }

    func testClearAllFromPlayers() throws {
        let command = Minecraft.Clear(.namedPlayer("Alex"), .namedPlayer("Steve"))
        XCTAssertEqual("\(command)", "clear Alex Steve")
    }

    func testClearItem() throws {
        let command = Minecraft.Clear(item: item)
        XCTAssertEqual("\(command)", "clear \(item)")
    }

    func testClearItemFromPlayer() throws {
        let command = Minecraft.Clear(.namedPlayer("Alex"), item: item)
        XCTAssertEqual("\(command)", "clear Alex \(item)")
    }

    func testClearItemFromPlayers() throws {
        let command = Minecraft.Clear(
            .namedPlayer("Alex"), .namedPlayer("Steve"),
            item: item
        )
        XCTAssertEqual("\(command)", "clear Alex Steve \(item)")
    }

    func testClearItemWithCount() throws {
        let command = Minecraft.Clear(item: item, count: count)
        XCTAssertEqual("\(command)", "clear \(item) \(count)")
    }

    func testClearItemFromPlayerWithCount() throws {
        let command = Minecraft.Clear(
            .namedPlayer("Alex"),
            item: item,
            count: count
        )
        XCTAssertEqual("\(command)", "clear Alex \(item) \(count)")
    }

    func testClearItemFromPlayersWithCount() throws {
        let command = Minecraft.Clear(
            .namedPlayer("Alex"), .namedPlayer("Steve"),
            item: item,
            count: count
        )
        XCTAssertEqual("\(command)", "clear Alex Steve \(item) \(count)")
    }
}
