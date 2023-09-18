// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Fields
import struct Diesel.Show
import protocol Schemata.ModelProjection

public protocol ShowFields: Fields where Model == Show.Identified {}
