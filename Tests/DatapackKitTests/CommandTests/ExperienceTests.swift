import XCTest
@testable import DatapackKit

final class ExperienceTests: XCTestCase {
    func testAddXPPointsToPlayer() throws {
        let command = Minecraft.Experience(addPoints: 10, to: .namedPlayer("Alex"))
        XCTAssertEqual("\(command)", "experience add Alex 10 points")
    }

    func testAddXPPointsToPlayers() throws {
        let command = Minecraft.Experience(addPoints: 10, to: .namedPlayer("Alex"), .namedPlayer("Steve"))
        XCTAssertEqual("\(command)", "experience add Alex Steve 10 points")
    }

    func testAddXPLevelsToPlayer() throws {
        let command = Minecraft.Experience(addLevels: 10, to: .namedPlayer("Alex"))
        XCTAssertEqual("\(command)", "experience add Alex 10 levels")
    }

    func testAddXPLevelsToPlayers() throws {
        let command = Minecraft.Experience(addLevels: 10, to: .namedPlayer("Alex"), .namedPlayer("Steve"))
        XCTAssertEqual("\(command)", "experience add Alex Steve 10 levels")
    }

    func testSetXPPointsToPlayer() throws {
        let command = Minecraft.Experience(setPoints: 10, to: .namedPlayer("Alex"))
        XCTAssertEqual("\(command)", "experience set Alex 10 points")
    }

    func testSetXPPointsToPlayers() throws {
        let command = Minecraft.Experience(setPoints: 10, to: .namedPlayer("Alex"), .namedPlayer("Steve"))
        XCTAssertEqual("\(command)", "experience set Alex Steve 10 points")
    }

    func testSetXPLevelsToPlayer() throws {
        let command = Minecraft.Experience(setLevels: 10, to: .namedPlayer("Alex"))
        XCTAssertEqual("\(command)", "experience set Alex 10 levels")
    }

    func testSetXPLevelsToPlayers() throws {
        let command = Minecraft.Experience(setLevels: 10, to: .namedPlayer("Alex"), .namedPlayer("Steve"))
        XCTAssertEqual("\(command)", "experience set Alex Steve 10 levels")
    }

    func testQueryXPPointsToPlayer() throws {
        let command = Minecraft.Experience(queryPointsOf: .namedPlayer("Alex"))
        XCTAssertEqual("\(command)", "experience query Alex points")
    }

    func testQueryXPPointsToPlayers() throws {
        let command = Minecraft.Experience(queryPointsOf: .namedPlayer("Alex"), .namedPlayer("Steve"))
        XCTAssertEqual("\(command)", "experience query Alex Steve points")
    }

    func testQueryXPLevelsToPlayer() throws {
        let command = Minecraft.Experience(queryLevelsOf: .namedPlayer("Alex"))
        XCTAssertEqual("\(command)", "experience query Alex levels")
    }

    func testQueryXPLevelsToPlayers() throws {
        let command = Minecraft.Experience(queryLevelsOf: .namedPlayer("Alex"), .namedPlayer("Steve"))
        XCTAssertEqual("\(command)", "experience query Alex Steve levels")
    }
}
