// Copyright © Fleuronic LLC. All rights reserved.

import Identity
import Schemata
import PersistDB

import struct Diesel.Division
import struct Foundation.UUID
import protocol Catena.Model

public struct IdentifiedDivision {
    public let id: Self.ID
    
    let value: Division
}

// MARK: -
public extension Division {
    typealias ID = Identified.ID
    typealias Identified = IdentifiedDivision

    func identified(id: ID? = nil) -> Identified {
        .init(
            id: id ?? .random,
            value: self
        )
    }
    
    var matches: Predicate<Identified> {
        \.value.name == name
    }
}

// MARK: -
extension Division.Identified: Identifiable {
    public typealias RawIdentifier = UUID
}

extension Division.Identified: Catena.Model {
    // MARK: Model
    public static let schema = Schema(
        Self.init ~ "divisions",
        \.id ~ "id",
        \.value.name ~ "name"
    )

    public var valueSet: ValueSet<Self> {
        [
            \.value.name == value.name
        ]
    }
}

// MARK: -
private extension Division.Identified {
    init(
        id: ID,
        name: String
    ) {
        self.id = id

        value = .init(
            name: name
        )
    }
}

// MARK: -
extension [Division] {
	var name: [String] { map(\.name) }
}

// MARK: -
extension [Division.Identified] {
	var id: [Division.ID] { map(\.id) }
	var value: [Division] { map(\.value) }
}
