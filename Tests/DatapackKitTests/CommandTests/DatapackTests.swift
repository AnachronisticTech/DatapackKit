import XCTest
@testable import DatapackKit

final class DatapackTests: XCTestCase {
    func testDatapackDisable() throws {
        let command = Minecraft.Commands.Datapack(disable: "myPack")
        XCTAssertEqual("\(command)", "datapack disable myPack")
    }

    func testDatapackListAvailable() throws {
        let command = Minecraft.Commands.Datapack(list: .available)
        XCTAssertEqual("\(command)", "datapack list available")
    }

    func testDatapackListEnabled() throws {
        let command = Minecraft.Commands.Datapack(list: .enabled)
        XCTAssertEqual("\(command)", "datapack list enabled")
    }

    func testDatapackEnable() throws {
        let command = Minecraft.Commands.Datapack(enable: "myPack")
        XCTAssertEqual("\(command)", "datapack enable myPack")
    }

    func testDatapackEnableFirst() throws {
        let command = Minecraft.Commands.Datapack(enable: "myPack", priority: .first)
        XCTAssertEqual("\(command)", "datapack enable myPack first")
    }

    func testDatapackEnableLast() throws {
        let command = Minecraft.Commands.Datapack(enable: "myPack", priority: .last)
        XCTAssertEqual("\(command)", "datapack enable myPack last")
    }

    func testDatapackEnableBefore() throws {
        let command = Minecraft.Commands.Datapack(enable: "myPack", priority: .before("myOtherPack"))
        XCTAssertEqual("\(command)", "datapack enable myPack before myOtherPack")
    }

    func testDatapackEnableAfter() throws {
        let command = Minecraft.Commands.Datapack(enable: "myPack", priority: .after("myOtherPack"))
        XCTAssertEqual("\(command)", "datapack enable myPack after myOtherPack")
    }
}
