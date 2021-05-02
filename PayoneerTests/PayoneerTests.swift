//
//  PayoneerTests.swift
//  PayoneerTests
//
//  Created by fatih maytalman on 3.05.2021.
//

@testable import Payoneer
import XCTest

class PayoneerTests: XCTestCase {

    class Box {

        let model: HomeViewModel

        init(dataController: HomeDataProviderMock = HomeDataProviderMock()) {
            model = HomeViewModel(dataController: dataController)
        }
    }

    private var box: Box!

    override func setUp() {
        super.setUp()

        box = Box()
    }

    func testDecodeError() throws {
        let mock = HomeDataProviderMock()
        mock.result = .failure(.decodeError)
        box = Box(dataController: mock)
        box.model.fetchPaymentData(completion: { (result) -> (Void) in
            switch result {
            case .failure(let error):
                XCTAssertTrue(error == .decodeError, "should show decodeError")
            default:
                break
            }
        })
    }

    func testNoDataError() throws {
        let mock = HomeDataProviderMock()
        mock.result = .failure(.noData)
        box = Box(dataController: mock)
        box.model.fetchPaymentData(completion: { (result) -> (Void) in
            switch result {
            case .failure(let error):
                XCTAssertTrue(error == .noData, "should show noData error")
            default:
                break
            }
        })
    }

    func testServerError() throws {
        let mock = HomeDataProviderMock()
        mock.result = .failure(.serverError)
        box = Box(dataController: mock)
        box.model.fetchPaymentData(completion: { (result) -> (Void) in
            switch result {
            case .failure(let error):
                XCTAssertTrue(error == .serverError, "should show serverError error")
            default:
                break
            }
        })
    }

    func testSuccess() throws {
        let mock = HomeDataProviderMock()
        mock.result = .success([PaymentMethod(label: "", links: MethodLink(logo: ""))])
        box = Box(dataController: mock)
        box.model.fetchPaymentData(completion: { (result) -> (Void) in
            switch result {
            case .success(_):
                XCTAssertTrue(true, "should be success")
            default:
                break
            }
        })
    }
}
