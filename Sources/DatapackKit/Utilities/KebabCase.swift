import Foundation

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
        let range = NSRange(location: 0, length: self.utf16.count)
        /// Pattern courtesy of:
        /// https://www.30secondsofcode.org/js/s/to-kebab-case
        let regex = try! NSRegularExpression(pattern: "/[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+/g")
        return regex
            .matches(in: self, options: [], range: range)
            .map { String(self[Range($0.range, in: self)!]).lowercased() }
            .joined(separator: "-")
    }
}
