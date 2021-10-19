@propertyWrapper struct KebabCase {
    var wrappedValue: String {
        didSet {
            wrappedValue = wrappedValue.kebabCase()
        }
    }

    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.kebabCase()
    }
}

extension String {
    func kebabCase() -> String {
        self.replacingOccurrences(
                of: "([A-Z])",
                with: "-$1",
                options: .regularExpression
            )
            .lowercased()
    }
}
