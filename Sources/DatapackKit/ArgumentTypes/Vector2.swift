public struct Vector2: Vector {
    let x: ScalarDistance
    let z: ScalarDistance

    public init(
        x: ScalarDistance,
        z: ScalarDistance
    ) {
        let fixedCount = [x, z]
            .filter { $0 == .local() }
            .count

        guard fixedCount == 0 || fixedCount == 2 else {
            fatalError("[ERROR] You cannot combine local coordinates with relative or absolute coordinates.")
        }

        self.x = x
        self.z = z
    }

    public var description: String { "\(x) \(z)" }
}
