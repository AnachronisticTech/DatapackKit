import Foundation

public protocol Command: CustomStringConvertible {
    var availability: Int { get }
}

public enum Minecraft {}

public enum Convenience {}
