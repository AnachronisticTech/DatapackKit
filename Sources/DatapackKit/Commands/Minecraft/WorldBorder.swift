extension Minecraft {
    /// Commands to control the world border.
    public struct WorldBorder: Command {
        let variant: Variant

        /// Increase the world border diameter by `increment` over `time` seconds.
        public init(increaseDiameter increment: Double, over time: Int? = nil) {
            variant = .add(increment, time)
        }

        /// Decrease the world border diameter by `decrement` over `time` seconds.
        public init(decreaseDiameter decrement: Double, over time: Int? = nil) {
            variant = .add(-decrement, time)
        }

        /// Re-center the world boundary.
        public init(center: Vector2) {
            variant = .center(center)
        }

        /// Set the world border damage amount to the specified value. Any player outside the world border buffer takes this amount of damage per second per block past the world border buffer distance.
        public init(damageAmount amount: Float) {
            variant = .damageAmount(amount)
        }

        /// Set the world border buffer distance to the specified value. Players won't take damage until they move past this distance from the world border.
        public init(damageBuffer amount: Double) {
            variant = .damageBuffer(amount)
        }

        /// Get the current world border diameter.
        public init() {
            variant = .get
        }

        /// Set the world border diameter at `time` in seconds.
        public init(setDiameter diameter: Double, at time: Int? = nil) {
            variant = .set(diameter, time)
        }

        /// Set the world border warning distance.
        public init(warningDistance distance: Int) {
            variant = .warningDistance(distance)
        }

        /// Set the world border warning time in seconds.
        public init(warningTime time: Int) {
            variant = .warningTime(time)
        }

        public var description: String {
            var command = "worldborder "
            switch variant {
                case let .add(distance, time):
                    command += "add \(distance)"
                    if let time = time {
                        command += " \(time)"
                    }
                case let .center(center):
                    command += "center \(center)"
                case let .damageAmount(amount):
                    command += "damage amount \(amount)"
                case let .damageBuffer(amount):
                    command += "damage buffer \(amount)"
                case .get: command += "get"
                case let .set(distance, time):
                    command += "set \(distance)"
                    if let time = time {
                        command += " \(time)"
                    }
                case let .warningDistance(distance):
                    command += "warning distance \(distance)"
                case let .warningTime(time):
                    command += "warning time \(time)"
            }
            return command
        }

        public var availability: Int { 4 }

        enum Variant {
            case add(Double, Int? = nil)
            case center(Vector2)
            case damageAmount(Float)
            case damageBuffer(Double)
            case get
            case set(Double, Int? = nil)
            case warningDistance(Int)
            case warningTime(Int)
        }
    }
}
