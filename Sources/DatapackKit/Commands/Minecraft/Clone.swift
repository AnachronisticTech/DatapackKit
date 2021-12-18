extension Minecraft {
    public struct Clone: Command {
        let begin: Vector3
        let end: Vector3
        let destination: Vector3
        let maskMode: MaskMode?
        let cloneMode: CloneMode?

        public init(
            begin: Vector3,
            end: Vector3,
            destination: Vector3,
            maskMode: MaskMode? = nil,
            cloneMode: CloneMode? = nil
        ) {
            self.begin = begin
            self.end = end
            self.destination = destination
            self.maskMode = maskMode
            self.cloneMode = cloneMode
        }

        public var description: String {
            var command = "clone \(begin) \(end) \(destination)"
            if let maskMode = maskMode {
                command += " \(maskMode)"
            }
            if let cloneMode = cloneMode {
                command += " \(cloneMode)"
            }
            return command
        }

        public var availability: Int { 4 }

        public enum MaskMode: CustomStringConvertible {
            case replace, masked
            case filter(String)

            public var description: String {
                switch self {
                    case .replace: return "replace"
                    case .masked: return "masked"
                    case let .filter(filter): return "filtered \(filter)"
                }
            }
        }

        public enum CloneMode: String, RawRepresentable, CustomStringConvertible {
            case force, move, normal

            public var description: String { rawValue }
        }
    }
}
