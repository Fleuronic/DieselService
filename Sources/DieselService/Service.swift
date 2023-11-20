// Copyright © Fleuronic LLC. All rights reserved.

import InitMacro
import PersistDB

import protocol Catenary.API
import protocol Catenoid.Database

@Init public struct Service<
	API: Catenary.API,
	Database: Catenoid.Database,
	EventListFields: EventFields,
	EventDetailsFields: EventFields,
	SlotListFields: SlotFields
> where Database.Store == Store<ReadWrite> {
	let api: API
	let database: Database
}

// MARK: -
public extension Service {
	typealias APIResult<Resource> = API.Result<Resource>
	typealias DatabaseResult<Resource> = Database.Result<Resource>
}
