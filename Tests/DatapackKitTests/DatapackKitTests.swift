import XCTest
import class Foundation.Bundle
@testable import DatapackKit

final class DataPackKitTests: XCTestCase {
    func testPackMCMetaGeneration() throws {
        let pack = Datapack(
            description: "Build-Jam Datapack", 
            packFormat: 7
        )

        let encoder = JSONEncoder()
        let data = try encoder.encode(pack)
        let decoder = JSONDecoder()
        let decodedPack = try decoder.decode(Datapack.self, from: data)
        XCTAssertEqual(pack, decodedPack)
    }

    // func testExample() throws {
    //     // This is an example of a functional test case.
    //     // Use XCTAssert and related functions to verify your tests produce the correct
    //     // results.

    //     // Some of the APIs that we use below are available in macOS 10.13 and above.
    //     guard #available(macOS 10.13, *) else {
    //         return
    //     }

    //     // Mac Catalyst won't have `Process`, but it is supported for executables.
    //     #if !targetEnvironment(macCatalyst)

    //     let fooBinary = productsDirectory.appendingPathComponent("DataPackKit")

    //     let process = Process()
    //     process.executableURL = fooBinary

    //     let pipe = Pipe()
    //     process.standardOutput = pipe

    //     try process.run()
    //     process.waitUntilExit()

    //     let data = pipe.fileHandleForReading.readDataToEndOfFile()
    //     let output = String(data: data, encoding: .utf8)

    //     XCTAssertEqual(output, "Hello, world!\n")
    //     #endif
    // }

    // /// Returns path to the built products directory.
    // var productsDirectory: URL {
    //   #if os(macOS)
    //     for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
    //         return bundle.bundleURL.deletingLastPathComponent()
    //     }
    //     fatalError("couldn't find the products directory")
    //   #else
    //     return Bundle.main.bundleURL
    //   #endif
    // }
}
