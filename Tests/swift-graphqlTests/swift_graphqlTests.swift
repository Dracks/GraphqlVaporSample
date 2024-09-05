import XCTest
import Vapor
import GraphQL
import XCTVapor

@testable import swift_graphql_sample

extension Application {
	func queryGql(
		_ query: GraphQLRequest,
		headers immutableHeaders: HTTPHeaders = [:],
		file: StaticString = #file,
		line: UInt = #line,
		beforeRequest: (inout XCTHTTPRequest) async throws -> Void = { _ in }
	) async throws -> XCTHTTPResponse {
		var headers = immutableHeaders
		headers.add(name: "content-type", value: "application/json")
		return try await self.sendRequest(
			.POST, "/graphql", headers: headers,
			body: ByteBuffer(data: try JSONEncoder().encode(query)),
			file: file, line: line,
			beforeRequest: beforeRequest
		)
	}
}

class SampleError: Error {}

final class swift_graphqlTests: XCTestCase {
    var app: Application?

    override func setUp() async throws {
        let app = try await Application.make(.testing)
        try await configure(app)
        self.app = app
    }
    func testWithErrorExample() async throws {
        guard let app = app else {
            throw SampleError()
        }
    	let query = """
     	query {
          users {
                name
                groups {
                    name
             }
          }
      }
     """
    	let response = try await app.queryGql(
			GraphQLRequest(query: query)
		)

		let data = try JSONDecoder().decode(GraphQLResult.self, from: response.body)

		XCTAssertEqual(data.errors, [])
    }
    
    func testExample() async throws {
        guard let app = app else {
            throw SampleError()
        }
        let query = """
         query {
          users {
                name
                
          }
      }
     """
        let response = try await app.queryGql(
            GraphQLRequest(query: query)
        )

        let data = try JSONDecoder().decode(GraphQLResult.self, from: response.body)

        XCTAssertEqual(data.errors, [])
    }
}
