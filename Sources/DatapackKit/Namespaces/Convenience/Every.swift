import struct Foundation.URL
import struct Foundation.Data

extension Convenience {
    public struct Every: Command {
        let time: String
        let name: String
        let function: Function
        let namespaceName: String

        init(time: String, @FunctionBuilder _ commands: () -> [Command]) {
            self.time = time
            let hash = commands()
                .map { "\($0)" }
                .joined(separator: "\n")
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .utf8
                .md5
                .description
                .kebabCase()
            self.name = "schedule-function-\(hash)"
            self.namespaceName = "datapack-kit-scheduled-functions"
            self.function = Function(name) { _ in commands() }
        }

        public init(
            hours time: Int,
            @FunctionBuilder _ commands: () -> [Command]
        ) {
            self.init(time: "\(time * 3)d", commands)
        }

        public init(
            seconds time: Int,
            @FunctionBuilder _ commands: () -> [Command]
        ) {
            self.init(time: "\(time)s", commands)
        }

        public init(
            ticks time: Int,
            @FunctionBuilder _ commands: () -> [Command]
        ) {
            self.init(time: "\(time)t", commands)
        }

        public init(
            inGameDays time: Int,
            @FunctionBuilder _ commands: () -> [Command]
        ) {
            self.init(time: "\(time)d", commands)
        }

        public var description: String {
            "schedule function \(namespaceName):\(name) \(time)"
        }

        public var availability: Int { 4 }

        public func build(at url: URL) throws {
            try function.build(at: url.appendingPathComponent(namespaceName))
        }
    }
}
