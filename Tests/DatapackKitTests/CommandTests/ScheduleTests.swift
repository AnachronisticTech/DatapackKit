import XCTest
@testable import DatapackKit

final class ScheduleTests: XCTestCase {
    let myFunction = Minecraft.Commands.Function("myFunction", inNamespace: "myNamespace")
    let time = 1

    func testScheduleFunctionInTicks() throws {
        let command = Minecraft.Commands.Schedule(myFunction, inTicks: time)
        XCTAssertEqual("\(command)", "schedule function my-namespace:my-function \(time)t")
    }

    func testScheduleFunctionInSeconds() throws {
        let command = Minecraft.Commands.Schedule(myFunction, inSeconds: time)
        XCTAssertEqual("\(command)", "schedule function my-namespace:my-function \(time)s")
    }

    func testScheduleFunctionInInGameDays() throws {
        let command = Minecraft.Commands.Schedule(myFunction, inInGameDays: time)
        XCTAssertEqual("\(command)", "schedule function my-namespace:my-function \(time)d")
    }

    func testScheduleFunctionAppendInTicks() throws {
        let command = Minecraft.Commands.Schedule(append: myFunction, inTicks: time)
        XCTAssertEqual("\(command)", "schedule function my-namespace:my-function \(time)t append")
    }

    func testScheduleFunctionAppendInSeconds() throws {
        let command = Minecraft.Commands.Schedule(append: myFunction, inSeconds: time)
        XCTAssertEqual("\(command)", "schedule function my-namespace:my-function \(time)s append")
    }

    func testScheduleFunctionAppendInInGameDays() throws {
        let command = Minecraft.Commands.Schedule(append: myFunction, inInGameDays: time)
        XCTAssertEqual("\(command)", "schedule function my-namespace:my-function \(time)d append")
    }

    func testScheduleFunctionReplaceInTicks() throws {
        let command = Minecraft.Commands.Schedule(replace: myFunction, inTicks: time)
        XCTAssertEqual("\(command)", "schedule function my-namespace:my-function \(time)t replace")
    }

    func testScheduleFunctionReplaceInSeconds() throws {
        let command = Minecraft.Commands.Schedule(replace: myFunction, inSeconds: time)
        XCTAssertEqual("\(command)", "schedule function my-namespace:my-function \(time)s replace")
    }

    func testScheduleFunctionReplaceInInGameDays() throws {
        let command = Minecraft.Commands.Schedule(replace: myFunction, inInGameDays: time)
        XCTAssertEqual("\(command)", "schedule function my-namespace:my-function \(time)d replace")
    }

    func testScheduleClear() throws {
        let command = Minecraft.Commands.Schedule(clear: myFunction)
        XCTAssertEqual("\(command)", "schedule clear my-namespace:my-function")
    }
}
