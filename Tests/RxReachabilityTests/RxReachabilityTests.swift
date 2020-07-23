import XCTest
import Reachability
import RxBlocking
import RxSwift
@testable import RxReachability

final class RxReachabilityTests: XCTestCase {
    
    let reachability: Reachability! = try? Reachability()
    let disposeBag = DisposeBag()
    
    override func setUp() {
        XCTAssertNoThrow(try reachability.startNotifier())
    }
    
    override func tearDown() {
        reachability.stopNotifier()
    }
    
    func test_reachabilityChanged() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

//        let reachabilityChanged = try reachability.rx.reachabilityChanged.toBlocking(timeout: 1).first()
        // TODO: Add observable test
    }
    
    func test_isReachable() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        let isReachable = try reachability.rx.isReachable.toBlocking(timeout: 1).first()
        XCTAssertNotNil(isReachable)
        XCTAssertTrue(isReachable!)
    }
    
    func test_status() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let status = try reachability.rx.status.toBlocking(timeout: 1).first()
        XCTAssertNotNil(status)
        XCTAssertNotEqual(status!, .unavailable)
        }
    
    func test_isConnected() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
//        let isConnected = try reachability.rx.isConnected.toBlocking(timeout: 1).first()
//        XCTAssertNotNil(isConnected)
//        XCTAssertTrue(isConnected!)
    }
    
    func test_isDisconnected() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
//        let isDisonnected = try reachability.rx.isDisonnected.toBlocking(timeout: 1).first()
//        XCTAssertNotNil(isDisonnected)
//        XCTAssertTrue(isDisonnected!)
    }

    static var allTests = [
        ("test_reachabilityChanged", test_reachabilityChanged),
        ("test_isReachable", test_isReachable),
        ("test_status", test_status),
        ("test_isConnected", test_isConnected),
        ("test_isDisconnected", test_isDisconnected)
    ]
}
