import Errors
import Foundation

extension TextReadError: SemanticError, ErrorNamespaced, ErrorDispositionProviding {
    public static let errorNamespace = "readers.text"

    public var errorCode: String {
        switch self {
        case .fileNotFound: return "file_not_found"
        case .undecodable: return "undecodable"
        case .filesystem: return "filesystem"
        case .io: return "io"
        }
    }

    public var errorPresentation: ErrorPresentation {
        switch self {
        case .fileNotFound(let url):
            return .init(
                message: "File not found: \(url.path).",
                messageSensitivity: .potentially_sensitive
            )
        case .undecodable(let url, let encodings):
            return .init(
                message: "Could not decode \(url.path) as text.",
                reason: "Tried \(encodings.joined(separator: ", ")).",
                recoverySuggestion: "Read it as data, or name its encoding.",
                messageSensitivity: .potentially_sensitive
            )
        case .filesystem(let url, _):
            return .init(
                message: "Reading \(url.path) failed.",
                messageSensitivity: .potentially_sensitive
            )
        case .io(let url, let message):
            return .init(
                message: "Reading \(url.path) failed.",
                reason: message,
                messageSensitivity: .potentially_sensitive,
                reasonSensitivity: .potentially_sensitive
            )
        }
    }

    public var errorDiagnosticFields: [ErrorDiagnosticField] {
        switch self {
        case .fileNotFound(let url), .filesystem(let url, _), .io(let url, _):
            return [.init(key: .path, value: .string(url.path), sensitivity: .potentially_sensitive)]
        case .undecodable(let url, let encodings):
            return [
                .init(key: .path, value: .string(url.path), sensitivity: .potentially_sensitive),
                .init(key: "readers.encodings", value: .array(encodings.map { .string($0) })),
            ]
        }
    }

    public var errorDisposition: ErrorDisposition? {
        switch self {
        case .fileNotFound, .undecodable: return .invalid_input
        // The kept FileSystemError says (permission, space, …).
        case .filesystem, .io: return nil
        }
    }
}

extension DataReadError: SemanticError, ErrorNamespaced, ErrorDispositionProviding {
    public static let errorNamespace = "readers.data"

    public var errorCode: String {
        switch self {
        case .fileNotFound: return "file_not_found"
        case .filesystem: return "filesystem"
        case .io: return "io"
        }
    }

    public var errorPresentation: ErrorPresentation {
        switch self {
        case .fileNotFound(let url):
            return .init(
                message: "File not found: \(url.path).",
                messageSensitivity: .potentially_sensitive
            )
        case .filesystem(let url, _):
            return .init(
                message: "Reading \(url.path) failed.",
                messageSensitivity: .potentially_sensitive
            )
        case .io(let url, let message):
            return .init(
                message: "Reading \(url.path) failed.",
                reason: message,
                messageSensitivity: .potentially_sensitive,
                reasonSensitivity: .potentially_sensitive
            )
        }
    }

    public var errorDiagnosticFields: [ErrorDiagnosticField] {
        switch self {
        case .fileNotFound(let url), .filesystem(let url, _), .io(let url, _):
            return [.init(key: .path, value: .string(url.path), sensitivity: .potentially_sensitive)]
        }
    }

    public var errorDisposition: ErrorDisposition? {
        switch self {
        case .fileNotFound: return .invalid_input
        case .filesystem, .io: return nil
        }
    }
}
