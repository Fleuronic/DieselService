// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Fields
import struct Diesel.Division
import protocol Schemata.ModelProjection

public protocol DivisionFields: Fields where Model == Division.Identified {}
