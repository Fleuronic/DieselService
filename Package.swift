// swift-tools-version:5.9
import PackageDescription

let package = Package(
	name: "DieselService",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.tvOS(.v13),
		.watchOS(.v6)
	],
	products: [
		.library(
			name: "DieselService",
			targets: ["DieselService"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/Fleuronic/Diesel", branch: "main"),
		.package(url: "https://github.com/Fleuronic/Catenary", branch: "main"),
		.package(url: "https://github.com/Fleuronic/Catenoid", branch: "main"),
		.package(url: "https://github.com/JohnSundell/Identity", from: "0.1.0")
	],
	targets: [
		.target(
			name: "DieselService",
			dependencies: [
				"Diesel",
				"Identity",
				"Catenary",
				"Catenoid"
			]
		)
	]
)
