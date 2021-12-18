import XCTest
@testable import DatapackKit

final class WorldBorderTests: XCTestCase {
    func testWorldBorderIncreaseDiameter() throws {
        let command = Minecraft.WorldBorder(increaseDiameter: 10)
        XCTAssertEqual("\(command)", "worldborder add 10.0")
    }
    func testWorldBorderIncreaseDiameterOverTime() throws {
        let command = Minecraft.WorldBorder(increaseDiameter: 10, over: 1000)
        XCTAssertEqual("\(command)", "worldborder add 10.0 1000")
    }

    func testWorldBorderDecreaseDiameter() throws {
        let command = Minecraft.WorldBorder(decreaseDiameter: 10)
        XCTAssertEqual("\(command)", "worldborder add -10.0")
    }

    func testWorldBorderDecreaseDiameterOverTime() throws {
        let command = Minecraft.WorldBorder(decreaseDiameter: 10, over: 1000)
        XCTAssertEqual("\(command)", "worldborder add -10.0 1000")
    }

    func testWorldBorderSetCenter() throws {
        let command = Minecraft.WorldBorder(center: Vector2(x: 5, z: 5))
        XCTAssertEqual("\(command)", "worldborder center 5 5")
    }

    func testWorldBorderSetDamageAmount() throws {
        let command = Minecraft.WorldBorder(damageAmount: 20)
        XCTAssertEqual("\(command)", "worldborder damage amount 20.0")
    }

    func testWorldBorderSetDamageBuffer() throws {
        let command = Minecraft.WorldBorder(damageBuffer: 20)
        XCTAssertEqual("\(command)", "worldborder damage buffer 20.0")
    }

    func testWorldBorderGetDiameter() throws {
        let command = Minecraft.WorldBorder()
        XCTAssertEqual("\(command)", "worldborder get")
    }

    func testWorldBorderSetDiameter() throws {
        let command = Minecraft.WorldBorder(setDiameter: 10)
        XCTAssertEqual("\(command)", "worldborder set 10.0")
    }

    func testWorldBorderSetDiameterAtTime() throws {
        let command = Minecraft.WorldBorder(setDiameter: 10, at: 1000)
        XCTAssertEqual("\(command)", "worldborder set 10.0 1000")
    }

    func testWorldBorderSetWarningDistance() throws {
        let command = Minecraft.WorldBorder(warningDistance: 10)
        XCTAssertEqual("\(command)", "worldborder warning distance 10")
    }

    func testWorldBorderSetWarningTime() throws {
        let command = Minecraft.WorldBorder(warningTime: 10)
        XCTAssertEqual("\(command)", "worldborder warning time 10")
    }
}
