extension Minecraft.Commands {
    public struct Schedule: Command {
        let variant: Variant
        let function: Minecraft.Commands.Function

        init(
            variant: Variant,
            _ function: Minecraft.Commands.Function
        ) {
            self.variant = variant
            self.function = function
        }

        public init(
            _ function: Minecraft.Commands.Function,
            inTicks time: Int
        ) {
            self.init(variant: .normal("\(time)t"), function)
        }

        public init(
            _ function: Minecraft.Commands.Function,
            inSeconds time: Int
        ) {
            self.init(variant: .normal("\(time)s"), function)
        }

        public init(
            _ function: Minecraft.Commands.Function,
            inInGameDays time: Int
        ) {
            self.init(variant: .normal("\(time)d"), function)
        }

        public init(
            append function: Minecraft.Commands.Function,
            inTicks time: Int
        ) {
            self.init(variant: .append("\(time)t"), function)
        }

        public init(
            append function: Minecraft.Commands.Function,
            inSeconds time: Int
        ) {
            self.init(variant: .append("\(time)s"), function)
        }

        public init(
            append function: Minecraft.Commands.Function,
            inInGameDays time: Int
        ) {
            self.init(variant: .append("\(time)d"), function)
        }

        public init(
            replace function: Minecraft.Commands.Function,
            inTicks time: Int
        ) {
            self.init(variant: .replace("\(time)t"), function)
        }

        public init(
            replace function: Minecraft.Commands.Function,
            inSeconds time: Int
        ) {
            self.init(variant: .replace("\(time)s"), function)
        }

        public init(
            replace function: Minecraft.Commands.Function,
            inInGameDays time: Int
        ) {
            self.init(variant: .replace("\(time)d"), function)
        }

        public init(clear function: Minecraft.Commands.Function) {
            self.init(variant: .clear, function)
        }

        public var description: String {
            switch variant {
                case let .normal(time):
                    return "schedule function \(function.identifier) \(time)"
                case let .append(time):
                    return "schedule function \(function.identifier) \(time) append"
                case let .replace(time):
                    return "schedule function \(function.identifier) \(time) replace"
                case .clear:
                    return "schedule clear \(function.identifier)"
            }
        }

        public var availability: Int { 4 }

        enum Variant {
            case normal(String)
            case append(String)
            case replace(String)
            case clear
        }
    }
}
