// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Division
import protocol Catena.Fields
import protocol Schemata.ModelProjection

public protocol DivisionFields: Fields where Model == Division.Identified {}
