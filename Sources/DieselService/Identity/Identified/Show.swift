// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Diesel.Show
import struct Foundation.UUID
import protocol Catena.Model
import protocol Identity.Identifiable

public struct IdentifiedShow {
	public let id: ID
	public let value: Show
}

// MARK: -
public extension Show {
	typealias ID = Identified.ID
	typealias Identified = IdentifiedShow

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
extension Show.Identified {
	init(fields: ShowBaseFields) {
		id = fields.id
		value = .init(name: fields.name)
	}
}

// MARK: -
extension Show.Identified: Model {
	// MARK: Identifiable
	public typealias RawIdentifier = UUID

	// MARK: Model
	public static let schema = Schema(
		Self.init..."shows",
		\.id * "id",
		\.value.name * "name"
	)

	public var valueSet: ValueSet<Self> {
		[\.value.name == value.name]
	}
}

// MARK: -
private extension Show.Identified {
	init(
		id: ID,
		name: String
	) {
		self.id = id
		
		value = .init(name: name)
	}
}

// MARK: -
public extension [Show] {
	var name: [String] { map(\.name) }
}

// MARK: -
public extension [Show.Identified] {
	var id: [Show.ID] { map(\.id) }
	var value: [Show] { map(\.value) }
}
