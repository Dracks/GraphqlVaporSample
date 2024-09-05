// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-graphql-sample",
   	platforms: [
		.macOS(.v13)
	],
    dependencies: [
  		.package(url: "https://github.com/vapor/vapor.git", from: "4.83.1"),

		// 🗄 An ORM for Swift
		.package(url: "https://github.com/vapor/fluent.git", from: "4.8.0"),
		.package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0"),

		// 🚀 A GraphQL server library for Swift
		.package(url: "https://github.com/alexsteinerde/graphql-kit.git", from: "3.0.0"),
		.package(url: "https://github.com/alexsteinerde/graphiql-vapor.git", from: "2.0.0"),
    ],

    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "swift-graphql-sample",
            dependencies: [
				.product(name: "Vapor", package: "vapor"),
				.product(name: "Fluent", package: "fluent"),
				.product(
					name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
				.product(name: "GraphQLKit", package: "graphql-kit"),
				.product(name: "GraphiQLVapor", package: "graphiql-vapor"),
			]
            ),
        .testTarget(
            name: "swift-graphqlTests",
            dependencies: [
            "swift-graphql-sample",
            .product(name: "XCTVapor", package: "vapor"),
            ]),
    ]
)
