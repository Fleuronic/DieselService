// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Diesel.Division
import struct Diesel.Placement
import struct Foundation.UUID
import protocol Catena.Model
import protocol Identity.Identifiable

public struct IdentifiedPlacement {
	public let id: ID
	public let value: Placement
	public let division: Division.Identified
}

// MARK: -
public extension Placement {
	typealias ID = Identified.ID
	typealias Identified = IdentifiedPlacement

	func identified(
		id: ID? = nil,
		division: Division.Identified
	) -> Identified {
		.init(
			id: id ?? .random,
			value: self,
			division: division
		)
	}
}

// MARK: -
extension Placement.Identified: Model {
	// MARK: Identifiable
	public typealias RawIdentifier = UUID

	// MARK: Model
	public static let schema = Schema(
		Self.init..."placements",
		\.id * "id",
		\.value.rank * "rank",
		\.value.score * "score",
		\.division --> "division"
	)
	
	// MARK: Model
	public static let relationships: Relationships = [
		\.division.id: \.division
	]

	// MARK: Model
	public var valueSet: ValueSet<Self> {
		[
			\.value.rank == value.rank,
			\.value.score == value.score,
			\.division.id == division.id
		]
	}
}

// MARK: -
private extension Placement.Identified {
	init(
		id: ID,
		rank: Int,
		score: Double,
		division: Division.Identified
	) {
		self.id = id
		self.division = division
		
		value = .init(
			rank: rank,
			score: score
		)
	}
}

// MARK: -
public extension [Placement] {
	var rank: [Int] { map(\.rank) }
	var score: [Double] { map(\.score) }
}

// MARK: -
public extension [Placement.Identified] {
	var id: [Placement.ID] { map(\.id) }
	var value: [Placement] { map(\.value) }
	var division: [Division.Identified] { map(\.division) }
}
