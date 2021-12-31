extension Array where Element == EntitySelector {
    func targetsToString() -> String {
        self.map({ "\($0)" }).joined(separator: " ")
    }
}
