import XCTest
@testable import DatapackKit

final class BanTests: XCTestCase {
    func testBanPlayer() throws {
        let command = Minecraft.Commands.Ban(.namedPlayer("Alex"))
        XCTAssertEqual("\(command)", "ban Alex")
    }

    func testBanPlayerForReason() throws {
        let command = Minecraft.Commands.Ban(.namedPlayer("Alex"), reason: "You have been banned by an administrator")
        XCTAssertEqual("\(command)", "ban Alex You have been banned by an administrator")
    }

    func testBanAllPlayers() throws {
        let command = Minecraft.Commands.Ban(.allPlayers())
        XCTAssertEqual("\(command)", "ban @a")
    }

    func testBanAllPlayersForReason() throws {
        let command = Minecraft.Commands.Ban(.allPlayers(), reason: "You have been banned by an administrator")
        XCTAssertEqual("\(command)", "ban @a You have been banned by an administrator")
    }

    func testBanSomePlayers() throws {
        let command = Minecraft.Commands.Ban(.namedPlayer("Alex"), .namedPlayer("Steve"))
        XCTAssertEqual("\(command)", "ban Alex Steve")
    }

    func testBanSomePlayersForReason() throws {
        let command = Minecraft.Commands.Ban(.namedPlayer("Alex"), .namedPlayer("Steve"), reason: "You have been banned by an administrator")
        XCTAssertEqual("\(command)", "ban Alex Steve You have been banned by an administrator")
    }
}
