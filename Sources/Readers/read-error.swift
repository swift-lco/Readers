import Foundation
import IO

public enum TextReadError: Error, Sendable, Hashable {
    case fileNotFound(URL)
    case undecodable(URL, attemptedEncodingNames: [String])
    /// The filesystem refused; IO's error is kept as the cause.
    case filesystem(URL, FileSystemError)
    case io(URL, message: String)
}

public enum DataReadError: Error, Sendable, Hashable {
    case fileNotFound(URL)
    /// The filesystem refused; IO's error is kept as the cause.
    case filesystem(URL, FileSystemError)
    case io(URL, message: String)
}
