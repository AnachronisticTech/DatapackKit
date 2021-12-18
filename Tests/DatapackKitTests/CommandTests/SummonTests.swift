import XCTest
@testable import DatapackKit

final class SummonTests: XCTestCase {
    let entity = "minecraft:pig"
    let position = Vector3(x: 5, y: 3, z: 9)
    let nbt = "{}"

    func testSummonEntity() throws {
        let command = Minecraft.Summon(entity)
        XCTAssertEqual("\(command)", "summon \(entity)")
    }

    func testSummonEntityAtPosition() throws {
        let command = Minecraft.Summon(entity, position: position)
        XCTAssertEqual("\(command)", "summon \(entity) \(position)")
    }

    func testSummonEntityAtPositionWithNBT() throws {
        let command = Minecraft.Summon(entity, position: position, nbt: nbt)
        XCTAssertEqual("\(command)", "summon \(entity) \(position) \(nbt)")
    }
}
