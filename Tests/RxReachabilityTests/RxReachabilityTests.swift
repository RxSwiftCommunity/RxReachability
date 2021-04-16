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
        let _ = XCTAssertNoThrow(try reachability.rx.reachabilityChanged.toBlocking(timeout: 1).first())
    }
    
    func test_isReachable() throws {
        let isReachable = try reachability.rx.isReachable.toBlocking(timeout: 1).first()
        XCTAssertNotNil(isReachable)
        XCTAssertTrue(isReachable!)
    }
    
    func test_status() throws {
        let status = try reachability.rx.status.toBlocking(timeout: 1).first()
        XCTAssertNotNil(status)
        XCTAssertNotEqual(status!, .unavailable)
    }
    
    func test_isConnected() throws {
        XCTAssertNoThrow(try reachability.rx.isConnected.toBlocking(timeout: 1).first())
    }
    
    func test_isDisconnected() throws {
        let _ = reachability.rx.isDisconnected.single()
    }

    static var allTests = [
        ("test_reachabilityChanged", test_reachabilityChanged),
        ("test_isReachable", test_isReachable),
        ("test_status", test_status),
        ("test_isConnected", test_isConnected),
        ("test_isDisconnected", test_isDisconnected)
    ]
}
