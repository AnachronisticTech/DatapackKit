protocol ExecuteConditional: ExecuteInstruction {
    var mode: Minecraft.Commands.Execute.ConditionalMode { get }

    var variant: Minecraft.Commands.Execute.ConditionalVariant { get }
    var instruction: ExecuteInstruction { get }

    init(
        _ variant: Minecraft.Commands.Execute.ConditionalVariant,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    )
}

extension Minecraft.Commands.Execute {
    enum ConditionalMode: String {
        case `if`, unless
    }

    enum ConditionalVariant {
        case block(Vector3, String)
        case blocks(Vector3, Vector3, Vector3, ScanMode)
        case dataBlock(Vector3, String)
        case dataEntity(EntitySelector, String)
        case dataStorage(String, String)
        case entity([EntitySelector])
        case predicate(String)
        case score(EntitySelector, String, ScoreComparator, EntitySelector, String)
        case scoreMatchesInt(EntitySelector, String, Int)
        case scoreMatchesRange(EntitySelector, String, ClosedRange<Int>)
    }

    public enum ScanMode: String {
        case all, masked
    }

    public enum ScoreComparator: String {
        case lessThan = "<"
        case lessThanOrEqualTo = "<="
        case equalTo = "="
        case greaterThan = ">"
        case greaterThanOrEqualTo = ">="
    }
}

extension ExecuteConditional {
    public var description: String {
        var command = "\(mode) "
        switch variant {
            case let .block(position, predicate):
                command += "block \(position) \(predicate)"
            case let .blocks(start, end, destination, scanMode):
                command += "blocks \(start) \(end) \(destination) \(scanMode)"
            case let .dataBlock(position, path):
                command += "data block \(position) \(path)"
            case let .dataEntity(target, path):
                command += "data entity \(target) \(path)"
            case let .dataStorage(source, path):
                command += "data storage \(source) \(path)"
            case let .entity(targets):
                command += "entity \(targets.targetsToString())"
            case let .predicate(predicate):
                command += "predicate \(predicate)"
            case let .score(target, targetObjective, comparator, source, sourceObjective):
                command += "score \(target) \(targetObjective) \(comparator) \(source) \(sourceObjective)"
            case let .scoreMatchesInt(target, objective, value):
                command += "score \(target) \(objective) matches \(value)"
            case let .scoreMatchesRange(target, objective, range):
                command += "score \(target) \(objective) matches \(range)"
                    .replacingOccurrences(of: "...", with: "..")
        }
        return "\(command) \(instruction)"
    }
}
