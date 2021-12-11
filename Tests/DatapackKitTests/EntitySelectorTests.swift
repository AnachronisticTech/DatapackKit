import XCTest
import class Foundation.Bundle
import struct Foundation.UUID
@testable import DatapackKit

final class EntitySelectorTests: XCTestCase {
    func testNearestPlayerOutput() throws {
        let selector = EntitySelector.nearestPlayer()
        XCTAssertEqual("\(selector)", "@p")
    }

    func testRandomPlayerOutput() throws {
        let selector = EntitySelector.randomPlayer()
        XCTAssertEqual("\(selector)", "@r")
    }

    func testAllPlayersOutput() throws {
        let selector = EntitySelector.allPlayers()
        XCTAssertEqual("\(selector)", "@a")
    }

    func testAllEntitiesOutput() throws {
        let selector = EntitySelector.allEntities()
        XCTAssertEqual("\(selector)", "@e")
    }

    func testExecutorOutput() throws {
        let selector = EntitySelector.executor()
        XCTAssertEqual("\(selector)", "@s")
    }

    func testNamedPlayerOutput() throws {
        let name = "Steve"
        let selector = EntitySelector.namedPlayer(name)
        XCTAssertEqual("\(selector)", name)
    }

    func testUUIDOutput() throws {
        let uuid = UUID()
        let selector = EntitySelector.uuid(uuid)
        XCTAssertEqual("\(selector)", "\(uuid)")
    }
}
