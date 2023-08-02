// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Event
import protocol Catena.Fields
import protocol Schemata.ModelProjection

public protocol EventFields: Fields where Model == Event.Identified {}
