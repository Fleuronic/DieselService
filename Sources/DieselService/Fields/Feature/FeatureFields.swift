// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Feature
import protocol Catena.Fields
import protocol Schemata.ModelProjection

public protocol FeatureFields: Fields where Model == Feature.Identified {}
