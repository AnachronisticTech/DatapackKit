import XCTest
@testable import DatapackKit

final class CloneTests: XCTestCase {
    let begin = Vector3(x: 1, y: 2, z: 3)
    let end = Vector3(x: 9, y: 8, z: 7)
    let destination = Vector3(x: 12, y: 0, z: 3)
    let filter = "minecraft:cobblestone"

    func testClone() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination)")
    }

    func testCloneForce() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            cloneMode: .force
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) force")
    }

    func testCloneMove() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            cloneMode: .move
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) move")
    }

    func testCloneNormal() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            cloneMode: .normal
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) normal")
    }

    func testCloneReplace() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            maskMode: .replace
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) replace")
    }

    func testCloneReplaceForce() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            maskMode: .replace,
            cloneMode: .force
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) replace force")
    }

    func testCloneReplaceMove() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            maskMode: .replace,
            cloneMode: .move
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) replace move")
    }

    func testCloneReplaceNormal() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            maskMode: .replace,
            cloneMode: .normal
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) replace normal")
    }

    func testCloneMasked() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            maskMode: .masked
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) masked")
    }

    func testCloneMaskedForce() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            maskMode: .masked,
            cloneMode: .force
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) masked force")
    }

    func testCloneMaskedMove() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            maskMode: .masked,
            cloneMode: .move
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) masked move")
    }

    func testCloneMaskedNormal() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            maskMode: .masked,
            cloneMode: .normal
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) masked normal")
    }

    func testCloneFiltered() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            maskMode: .filter(filter)
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) filtered \(filter)")
    }

    func testCloneFilteredForce() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            maskMode: .filter(filter),
            cloneMode: .force
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) filtered \(filter) force")
    }

    func testCloneFilteredMove() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            maskMode: .filter(filter),
            cloneMode: .move
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) filtered \(filter) move")
    }

    func testCloneFilteredNormal() throws {
        let command = Minecraft.Clone(
            begin: begin,
            end: end,
            destination: destination,
            maskMode: .filter(filter),
            cloneMode: .normal
        )
        XCTAssertEqual("\(command)", "clone \(begin) \(end) \(destination) filtered \(filter) normal")
    }
}
