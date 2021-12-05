import XCTest
import class Foundation.Bundle
@testable import DatapackKit

final class TeleportCommandTests: XCTestCase {
    let location = Vector3(
        x: .relative(),
        y: .relative(2),
        z: .relative(-5)
    )

    func testTeleportToDestinationOutput() throws {
        let command = Minecraft.Teleport(to: .randomPlayer())
        XCTAssertEqual("\(command)", "tp @r")
    }

    func testTeleportTargetToDestinationOutput() throws {
        let command = Minecraft.Teleport(.executor(), to: .randomPlayer())
        XCTAssertEqual("\(command)", "tp @s @r")
    }

    func testTeleportToLocationOutput() throws {
        let command = Minecraft.Teleport(to: location)
        XCTAssertEqual("\(command)", "tp ~ ~2 ~-5")
    }

    func testTeleportTargetToLocationOutput() throws {
        let command = Minecraft.Teleport(.executor(), to: location)
        XCTAssertEqual("\(command)", "tp @s ~ ~2 ~-5")
    }

    func testTeleportTargetToLocationRotationOutput() throws {
        let command = Minecraft.Teleport(
            .executor(),
            to: location,
            withRotation: Vector2(
                x: .absolute(0),
                z: .absolute(0)
            )
        )
        XCTAssertEqual("\(command)", "tp @s ~ ~2 ~-5 0 0")
    }

    func testTeleportTargetToLocationFacingOutput() throws {
        let command = Minecraft.Teleport(
            .executor(),
            to: location,
            facing: Vector3(
                x: .absolute(0),
                y: .absolute(0),
                z: .absolute(0)
            )
        )
        XCTAssertEqual("\(command)", "tp @s ~ ~2 ~-5 facing 0 0 0")
    }

    func testTeleportTargetToLocationFacingEntityOutput() throws {
        let command = Minecraft.Teleport(.executor(), to: location, facing: .randomPlayer())
        XCTAssertEqual("\(command)", "tp @s ~ ~2 ~-5 facing entity @r")
    }
}
