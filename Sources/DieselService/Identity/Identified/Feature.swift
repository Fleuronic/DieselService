// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB
import Schemata

import protocol Catena.Model
import struct Diesel.Corps
import struct Diesel.Event
import struct Diesel.Feature
import struct Diesel.Location
import struct Diesel.Venue
import struct Foundation.UUID
import protocol Identity.Identifiable

public struct IdentifiedFeature {
	public let id: ID
	public let value: Feature
	public let corps: Corps.Identified!
}

// MARK: -
public extension Feature {
	typealias ID = Identified.ID
	typealias Identified = IdentifiedFeature

	func identified(
		id: ID? = nil,
		corps: Corps.Identified?
	) -> Identified {
		.init(
			id: id ?? .random,
			value: self,
			corps: corps
		)
	}

	func matches(with corps: Corps.Identified?) -> Predicate<Identified> {
		\.value.name == name && (corps?.id).map { \.corps.id == $0 } ?? !\.corps
	}
}

// MARK: -
extension Feature.Identified: Model {
	// MARK: Identifiable
	public typealias RawIdentifier = UUID

	// MARK: Model
	public static let schema = Schema(
		Self.init..."features",
		\.id * "id",
		\.value.name * "name",
		\.corps -->? "corps"
	)

	public var valueSet: ValueSet<Self> {
		[
			\.value.name == value.name,
			\.corps.id == corps?.id
		]
	}

	public static var relationships: Relationships {
		[
			\.corps.id: \.corps!
		]
	}
}

// MARK: -
private extension Feature.Identified {
	init(
		id: ID,
		name: String,
		corps: Corps.Identified?
	) {
		self.id = id
		self.corps = corps
		
		value = .init(
			name: name
		)
	}
}

// MARK: -
public extension [Feature] {
	var name: [String] { map(\.name) }
}

// MARK: -
public extension [Feature.Identified] {
	var id: [Feature.ID] { map(\.id) }
	var value: [Feature] { map(\.value) }
	var corps: [Corps.Identified] { map(\.corps) }
}
