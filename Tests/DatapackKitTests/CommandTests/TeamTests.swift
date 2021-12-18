import XCTest
@testable import DatapackKit

final class TeamTests: XCTestCase {
    func testListAllTeams() throws {
        let command = Minecraft.Team()
        XCTAssertEqual("\(command)", "team list")
    }

    func testListSpecificTeam() throws {
        let command = Minecraft.Team(team: "myTeam")
        XCTAssertEqual("\(command)", "team list myTeam")
    }

    func testAddNewTeam() throws {
        let command = Minecraft.Team(add: "myTeam")
        XCTAssertEqual("\(command)", "team add myTeam")
    }

    func testAddNewTeamWithDisplayName() throws {
        let command = Minecraft.Team(add: "myTeam", displayName: "MyTeam")
        XCTAssertEqual("\(command)", "team add myTeam MyTeam")
    }

    func testRemoveTeam() throws {
        let command = Minecraft.Team(remove: "myTeam")
        XCTAssertEqual("\(command)", "team remove myTeam")
    }

    func testEmptyTeam() throws {
        let command = Minecraft.Team(empty: "myTeam")
        XCTAssertEqual("\(command)", "team empty myTeam")
    }

    func testAssignExecutorTeam() throws {
        let command = Minecraft.Team(join: "myTeam")
        XCTAssertEqual("\(command)", "team join myTeam")
    }

    func testAssignPlayersTeam() throws {
        let command = Minecraft.Team(join: "myTeam", players: .namedPlayer("Alex"), .namedPlayer("Steve"))
        XCTAssertEqual("\(command)", "team join myTeam Alex Steve")
    }

    func testPlayersLeaveTeam() throws {
        let command = Minecraft.Team(leave: .namedPlayer("Alex"), .namedPlayer("Steve"))
        XCTAssertEqual("\(command)", "team leave Alex Steve")
    }

    func testModifyTeamSingleOption() throws {
        let command = Minecraft.Team(modify: "myTeam", .friendlyFire())
        XCTAssertEqual("\(command)", "team modify myTeam friendlyFire true")
    }

    func testModifyTeamMultipleOptions() throws {
        let command = Minecraft.Team(modify: "myTeam", .friendlyFire(), .color(.blue))
        XCTAssertEqual("\(command)", "team modify myTeam friendlyFire true\nteam modify myTeam color blue")
    }
}
