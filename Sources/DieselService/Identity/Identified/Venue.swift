// Copyright © Fleuronic LLC. All rights reserved.

import Identity
import Schemata
import PersistDB

import struct Diesel.Venue
import struct Diesel.Address
import struct Foundation.UUID
import protocol Catena.Model

public struct IdentifiedVenue {
    public let id: Self.ID

    let value: Venue
    let address: Address.Identified
}

// MARK: -
public extension Venue {
    typealias ID = Identified.ID
    typealias Identified = IdentifiedVenue

    func identified(
		id: ID? = nil,
		address: Address.Identified
    ) -> Identified {
        .init(
            id: id ?? .random,
            value: self,
			address: address
        )
    }
    
    var matches: Predicate<Identified> {
        \.value.name == name
    }
}

// MARK: -
public extension Venue.Identified {
	init(
		fields: VenueBaseFields,
		address: Address.Identified
	) {
		self.init(
			id: fields.id,
			name: fields.name,
			address: address
		)
	}
}

// MARK: -
extension Venue.Identified {
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case address
	}
}

// MARK: -
extension Venue.Identified: Identifiable {
    public typealias RawIdentifier = UUID
}

extension Venue.Identified: Model {
    // MARK: Model
    public static let schema = Schema(
        Self.init ~ "venues",
        \.id ~ "id",
        \.value.name ~ "name",
        \.address ~ "address"
    )

    public var valueSet: ValueSet<Self> {
        [
            \.value.name == value.name,
            \.address.id == address.id
        ]
    }
    
    public static var foreignKeys: ForeignKeys {
        [
            \.address.id: \.address
        ]
    }
}

// MARK: -
private extension Venue.Identified {
	init(
		id: ID,
		name: String,
		address: Address.Identified
	) {
		self.id = id
		self.address = address

		value = .init(
			name: name
		)
	}
}
