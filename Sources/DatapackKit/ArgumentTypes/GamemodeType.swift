public enum GamemodeType: String, RawRepresentable {
    case creative
    case survival
    case adventure
    case spectator

    public var description: String { self.rawValue }
}
