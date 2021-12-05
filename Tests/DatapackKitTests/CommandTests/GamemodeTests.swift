import XCTest
import class Foundation.Bundle
@testable import DatapackKit

final class GamemodeTests: XCTestCase {
    func testSetGamemodeCreative() throws {
        let command = Minecraft.Gamemode(.creative)
        XCTAssertEqual("\(command)", "gamemode creative")
    }

    func testSetGamemodeSurvival() throws {
        let command = Minecraft.Gamemode(.survival)
        XCTAssertEqual("\(command)", "gamemode survival")
    }

    func testSetGamemodeAdventure() throws {
        let command = Minecraft.Gamemode(.adventure)
        XCTAssertEqual("\(command)", "gamemode adventure")
    }

    func testSetGamemodeSpectator() throws {
        let command = Minecraft.Gamemode(.spectator)
        XCTAssertEqual("\(command)", "gamemode spectator")
    }

    func testSetGamemodeCreativeAllPlayers() throws {
        let command = Minecraft.Gamemode(.creative, .allPlayers())
        XCTAssertEqual("\(command)", "gamemode creative @a")
    }
}
