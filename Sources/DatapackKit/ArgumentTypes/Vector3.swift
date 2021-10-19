public struct Vector3: Vector {
    let x: ScalarDistance
    let y: ScalarDistance
    let z: ScalarDistance

    public init(
        x: ScalarDistance,
        y: ScalarDistance,
        z: ScalarDistance
    ) {
        let fixedCount = [x, y, z]
            .filter { $0 == .local() }
            .count

        guard fixedCount == 0 || fixedCount == 3 else {
            fatalError("[ERROR] You cannot combine local coordinates with relative or absolute coordinates.")
        }

        self.x = x
        self.y = y
        self.z = z
    }

    public var description: String { "\(x) \(y) \(z)" }
}
