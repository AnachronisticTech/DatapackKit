import XCTest
@testable import DatapackKit

final class TeleportTests: XCTestCase {
    let location = Vector3(
        x: .relative(),
        y: .relative(2),
        z: .relative(-5)
    )

    func testTeleportToDestinationOutput() throws {
        let command = Minecraft.Commands.Teleport(to: .randomPlayer())
        XCTAssertEqual("\(command)", "teleport @r")
    }

    func testTeleportTargetToDestinationOutput() throws {
        let command = Minecraft.Commands.Teleport(.executor(), to: .randomPlayer())
        XCTAssertEqual("\(command)", "teleport @s @r")
    }

    func testTeleportToLocationOutput() throws {
        let command = Minecraft.Commands.Teleport(to: location)
        XCTAssertEqual("\(command)", "teleport ~ ~2 ~-5")
    }

    func testTeleportTargetToLocationOutput() throws {
        let command = Minecraft.Commands.Teleport(.executor(), to: location)
        XCTAssertEqual("\(command)", "teleport @s ~ ~2 ~-5")
    }

    func testTeleportTargetToLocationRotationOutput() throws {
        let command = Minecraft.Commands.Teleport(
            .executor(),
            to: location,
            withRotation: Vector2(
                x: .absolute(0),
                z: .absolute(0)
            )
        )
        XCTAssertEqual("\(command)", "teleport @s ~ ~2 ~-5 0 0")
    }

    func testTeleportTargetToLocationFacingOutput() throws {
        let command = Minecraft.Commands.Teleport(
            .executor(),
            to: location,
            facing: Vector3(
                x: .absolute(0),
                y: .absolute(0),
                z: .absolute(0)
            )
        )
        XCTAssertEqual("\(command)", "teleport @s ~ ~2 ~-5 facing 0 0 0")
    }

    func testTeleportTargetToLocationFacingEntityOutput() throws {
        let command = Minecraft.Commands.Teleport(.executor(), to: location, facing: .randomPlayer())
        XCTAssertEqual("\(command)", "teleport @s ~ ~2 ~-5 facing entity @r")
    }
}
