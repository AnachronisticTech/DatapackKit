@propertyWrapper struct KebabCase {
    var wrappedValue: String {
        didSet {
            wrappedValue = wrappedValue
                .replacingOccurrences(
                    of: "([A-Z])",
                    with: "-$1",
                    options: .regularExpression
                )
                .lowercased()
        }
    }

    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
            .replacingOccurrences(
                of: "([A-Z])",
                with: "-$1",
                options: .regularExpression
            )
            .lowercased()
    }
}
