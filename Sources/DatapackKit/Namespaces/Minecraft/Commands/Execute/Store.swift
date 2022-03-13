public struct Store: ExecuteInstruction {
    let variant: Variant
    let instruction: ExecuteInstruction

    init(
        _ variant: Variant,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.variant = variant
        self.instruction = instruction()
    }

    public init(
        resultInBlockAtPosition position: Vector3,
        atNBTPath path: String,
        dataType: DataType,
        multiplier: Double,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.block(.result, position, path, dataType, multiplier), instruction)
    }

    public init(
        successInBlockAtPosition position: Vector3,
        atNBTPath path: String,
        dataType: DataType,
        multiplier: Double,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.block(.success, position, path, dataType, multiplier), instruction)
    }

    public init(
        resultForTargets targets: EntitySelector...,
        inScoreboardObjective objective: String,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.score(.result, targets, objective), instruction)
    }

    public init(
        successForTargets targets: EntitySelector...,
        inScoreboardObjective objective: String,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.score(.success, targets, objective), instruction)
    }

    public init(
        resultInEntity entity: String,
        atNBTPath path: String,
        dataType: DataType,
        multiplier: Double,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.entity(.result, entity, path, dataType, multiplier), instruction)
    }

    public init(
        successInEntity entity: String,
        atNBTPath path: String,
        dataType: DataType,
        multiplier: Double,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.entity(.success, entity, path, dataType, multiplier), instruction)
    }

    public init(
        resultInBossbarWithId id: String,
        as value: BossbarValue,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.bossbar(.result, id, value), instruction)
    }

    public init(
        successInBossbarWithId id: String,
        as value: BossbarValue,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.bossbar(.success, id, value), instruction)
    }

    public init(
        resultInStorage target: String,
        atNBTPath path: String,
        dataType: DataType,
        multiplier: Double,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.storage(.result, target, path, dataType, multiplier), instruction)
    }

    public init(
        successInStorage target: String,
        atNBTPath path: String,
        dataType: DataType,
        multiplier: Double,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.storage(.success, target, path, dataType, multiplier), instruction)
    }

    public var description: String {
        var command = "store "
        switch variant {
            case let .block(mode, position, path, type, scale):
                command += "\(mode) block \(position) \(path) \(type) \(scale)"
            case let .bossbar(mode, id, value):
                command += "\(mode) bossbar \(id) \(value)"
            case let .entity(mode, entity, path, type, scale):
                command += "\(mode) entity \(entity) \(path) \(type) \(scale)"
            case let .score(mode, targets, objective):
                command += "\(mode) score \(targets.targetsToString()) \(objective)"
            case let .storage(mode, target, path, type, scale):
                command += "\(mode) storage \(target) \(path) \(type) \(scale)"
        }
        return "\(command) \(instruction)"
    }

    public enum DataType {
        case byte, short, int, long, float, double
    }

    enum StoreMode {
        case result, success
    }

    public enum BossbarValue {
        case currentValue, maxValue
    }

    enum Variant {
        case block(StoreMode, Vector3, String, DataType, Double)
        case bossbar(StoreMode, String, BossbarValue)
        case entity(StoreMode, String, String, DataType, Double)
        case score(StoreMode, [EntitySelector], String)
        case storage(StoreMode, String, String, DataType, Double)
    }
}
