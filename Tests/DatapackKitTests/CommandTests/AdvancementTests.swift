import XCTest
@testable import DatapackKit

final class AdvancementTests: XCTestCase {
    let allPlayers = EntitySelector.allPlayers()
    let advancement = "minecraft:story/mine_stone"
    let criterion = "minecraft:impossible"

    func testGrantEverything() throws {
        let command = Minecraft.Advancement(grantEverythingTo: allPlayers)
        XCTAssertEqual("\(command)", "advancement grant \(allPlayers) everything")
    }

    func testRevokeEverything() throws {
        let command = Minecraft.Advancement(revokeEverythingFrom: allPlayers)
        XCTAssertEqual("\(command)", "advancement revoke \(allPlayers) everything")
    }

    func testGrantOnly() throws {
        let command = Minecraft.Advancement(grantOnly: advancement, toTargets: allPlayers)
        XCTAssertEqual("\(command)", "advancement grant \(allPlayers) only \(advancement)")
    }

    func testRevokeOnly() throws {
        let command = Minecraft.Advancement(revokeOnly: advancement, fromTargets: allPlayers)
        XCTAssertEqual("\(command)", "advancement revoke \(allPlayers) only \(advancement)")
    }

    func testGrantOnlyWithCriterion() throws {
        let command = Minecraft.Advancement(
            grantOnly: advancement,
            criterion: criterion,
            toTargets: allPlayers
        )
        XCTAssertEqual("\(command)", "advancement grant \(allPlayers) only \(advancement) \(criterion)")
    }

    func testRevokeOnlyWithCriterion() throws {
        let command = Minecraft.Advancement(
            revokeOnly: advancement,
            criterion: criterion,
            fromTargets: allPlayers
        )
        XCTAssertEqual("\(command)", "advancement revoke \(allPlayers) only \(advancement) \(criterion)")
    }

    func testGrantFrom() throws {
        let command = Minecraft.Advancement(grantFrom: advancement, toTargets: allPlayers)
        XCTAssertEqual("\(command)", "advancement grant \(allPlayers) from \(advancement)")
    }

    func testRevokeFrom() throws {
        let command = Minecraft.Advancement(revokeFrom: advancement, fromTargets: allPlayers)
        XCTAssertEqual("\(command)", "advancement revoke \(allPlayers) from \(advancement)")
    }

    func testGrantThrough() throws {
        let command = Minecraft.Advancement(grantThrough: advancement, toTargets: allPlayers)
        XCTAssertEqual("\(command)", "advancement grant \(allPlayers) through \(advancement)")
    }

    func testRevokeThrough() throws {
        let command = Minecraft.Advancement(revokeThrough: advancement, fromTargets: allPlayers)
        XCTAssertEqual("\(command)", "advancement revoke \(allPlayers) through \(advancement)")
    }

    func testGrantUntil() throws {
        let command = Minecraft.Advancement(grantUntil: advancement, toTargets: allPlayers)
        XCTAssertEqual("\(command)", "advancement grant \(allPlayers) until \(advancement)")
    }

    func testRevokeUntil() throws {
        let command = Minecraft.Advancement(revokeUntil: advancement, fromTargets: allPlayers)
        XCTAssertEqual("\(command)", "advancement revoke \(allPlayers) until \(advancement)")
    }
}
