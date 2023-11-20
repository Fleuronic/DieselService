// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Fields
import struct Diesel.Corps
import protocol Schemata.ModelProjection

public protocol CorpsFields: Fields where Model == Corps.Identified {}
