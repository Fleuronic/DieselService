// Copyright © Fleuronic LLC. All rights reserved.

import Identity
import Schemata
import PersistDB

import struct Diesel.Location
import struct Foundation.UUID
import protocol Catena.Model

public struct IdentifiedLocation {
	public let id: Self.ID
	
    let value: Location
}

// MARK: -
public extension Location {
    typealias ID = Identified.ID
	typealias Identified = IdentifiedLocation

	func identified(id: ID? = nil) -> Identified {
		.init(
			id: id ?? .random,
			value: self
		)
	}
    
    var matches: Predicate<Identified> {
        \.value.city == city &&
		\.value.state == state
    }
}

// MARK: -
public extension Location.Identified {
	init(fields: LocationBaseFields) {
		id = fields.id
		value = .init(
			city: fields.city,
			state: fields.state
		)
	}
}

// MARK: -
extension Location.Identified: Identifiable {
	public typealias RawIdentifier = UUID
}

extension Location.Identified: Catena.Model {
	// MARK: Model
	public static let schema = Schema(
		Self.init ~ "locations",
		\.id ~ "id",
		\.value.city ~ "city",
		\.value.state ~ "state"
	)

	public var valueSet: ValueSet<Self> {
		[
			\.value.city == value.city,
			\.value.state == value.state
		]
	}
}

// MARK: -
private extension Location.Identified {
	init(
		id: ID,
		city: String,
		state: String
	) {
		self.id = id

		value = .init(
			city: city,
			state: state
		)
	}
}

// MARK: -
extension [Location] {
	var city: [String] { map(\.city) }
	var state: [String] { map(\.state) }
}

// MARK: -
extension [Location.Identified] {
	var id: [Location.ID] { map(\.id) }
	var value: [Location] { map(\.value) }
}
