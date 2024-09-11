//
//  OSLog.swift
//  PokemonDex-MVVM
//
//  Created by Jeong Deokho on 9/10/24.
//

import Foundation
import OSLog

// MARK: - OSLog Properties

extension OSLog {
    static let subsystem = Bundle.main.bundleIdentifier ?? ""
}

// MARK: - Log Level

enum Log {
    enum Level: String {
        case network = "🔵 NETWORK"
        case debug = "🟡 DEBUG"
        case error = "🔴 ERROR"
    }
}

// MARK: - Log Function

extension Log {
    /// Logs a debug message with file and line information.
    static func debug(
        _ message: Any,
        _ arguments: Any...,
        file: String = #file,
        line: Int = #line
    ) {
        log(message, arguments, level: .debug, file: file, line: line)
    }

    /// Logs a network message with file and line information.
    static func network(
        _ message: Any,
        _ arguments: Any...,
        file: String = #file,
        line: Int = #line
    ) {
        log(message, arguments, level: .network, file: file, line: line)
    }

    /// Logs an error message with file and line information.
    static func error(
        _ message: Any,
        _ arguments: Any...,
        file: String = #file,
        line: Int = #line
    ) {
        log(message, arguments, level: .error, file: file, line: line)
    }
}


// MARK: - Log Helper Function

extension Log {
    /// Logs a message with the specified level, file, and line information.
    static private func log(
        _ message: Any,
        _ arguments: [Any],
        level: Level,
        file: String,
        line: Int
    ) {
        #if DEBUG
        var logMessage = getLogMessageBody(message,
                                       arguments)
        logMessage.insert(
            contentsOf: getLogMessageHeader(level: level, file: file, line: line),
            at: logMessage.startIndex
        )
        handleLoggingForLevel(logMessage: logMessage, level: level)
        #endif
    }
    
    /// Constructs the log message header string that includes file and line details.
    static private func getLogMessageHeader(
        level: Level,
        file: String,
        line: Int
    ) -> String {
        guard level != .network else { return "" }
        let fileName = file.split(separator: "/").last ?? ""
        let fileMessage = "\nFile: \(fileName)"
        let lineMessage = "\nLine: \(line)"
        return fileMessage + lineMessage
    }

    /// Constructs the log message body string from the given message and arguments.
    static private func getLogMessageBody(_ message: Any, _ arguments: [Any]) -> String {
        let argumentsMessage = arguments
            .map { String(describing: $0) }
            .joined(separator: "\n")
        let mainMessage = "\nMessage: \(message)\n"
        let extraMessage = "\(argumentsMessage)"
        return mainMessage + extraMessage
    }

    /// Handles logging based on the specified log level.
    static private func handleLoggingForLevel(logMessage: String, level: Level) {
        let logger = Logger(subsystem: OSLog.subsystem, category: level.rawValue)
        switch level {
        case .network:
            logger.log("\(level.rawValue)\(logMessage, privacy: .public)")
        case .debug:
            logger.debug("\(level.rawValue)\(logMessage, privacy: .public)")
        case .error:
            logger.error("\(level.rawValue)\(logMessage, privacy: .public)")
        }
    }
}
