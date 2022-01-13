import XCTest
@testable import DatapackKit

final class FunctionTests: XCTestCase {
    func testFunction() throws {
        let command = Minecraft.Commands
                               .Function("myFunction", inNamespace: "myNamespace")
        XCTAssertEqual("\(command)", "function my-namespace:my-function")
    }
}
