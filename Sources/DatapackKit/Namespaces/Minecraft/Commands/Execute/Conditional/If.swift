public struct If: ExecuteConditional {
    let mode: Minecraft.Commands.Execute.ConditionalMode = .if

    var variant: Minecraft.Commands.Execute.ConditionalVariant
    var instruction: ExecuteInstruction

    init(
        _ variant: Minecraft.Commands.Execute.ConditionalVariant,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.variant = variant
        self.instruction = instruction()
    }

    public init(
        blockAtPosition position: Vector3,
        matches predicate: String,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.block(position, predicate), instruction)
    }

    public init(
        blocksInVolumeFrom start: Vector3,
        to end: Vector3,
        comparingVolumeAt destination: Vector3,
        inMode mode: Minecraft.Commands.Execute.ScanMode,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.blocks(start, end, destination, mode), instruction)
    }

    public init(
        blockAtPosition position: Vector3,
        hasDataAtPath path: String,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.dataBlock(position, path), instruction)
    }

    public init(
        entity target: EntitySelector,
        hasDataAtPath path: String,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.dataEntity(target, path), instruction)
    }

    public init(
        storageResource source: String,
        hasDataAtPath path: String,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.dataStorage(source, path), instruction)
    }

    public init(
        targetsExist targets: [EntitySelector],
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.entity(targets), instruction)
    }

    public init(
        predicate: String,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(.predicate(predicate), instruction)
    }

    public init(
        scoreOf target: EntitySelector,
        inObjective targetObjective: String,
        is comparator: Minecraft.Commands.Execute.ScoreComparator,
        toScoreOf source: EntitySelector,
        inObjective sourceObjective: String,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.init(
            .score(target, targetObjective, comparator, source, sourceObjective),
            instruction
        )
    }

    public init(
        scoreOf target: EntitySelector,
        inObjective targetObjective: String,
        matchesRange value: Int,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        guard target.singlePlayerType else {
            fatalError("[ERROR] Subcommand may only be used with singleplayer entity selectors.")
        }
        self.init(.scoreMatchesInt(target, targetObjective, value), instruction)
    }

    public init(
        scoreOf target: EntitySelector,
        inObjective targetObjective: String,
        matchesRange range: ClosedRange<Int>,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        guard target.singlePlayerType else {
            fatalError("[ERROR] Subcommand may only be used with singleplayer entity selectors.")
        }
        self.init(.scoreMatchesRange(target, targetObjective, range), instruction)
    }
}
