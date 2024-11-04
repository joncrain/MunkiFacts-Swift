import XCTest
@testable import FactPlugin

final class FactPluginTests: XCTestCase {
    var factPlugin: FactPlugin!
    
    override func setUp() {
        super.setUp()
        factPlugin = FactPlugin()
    }
    
    override func tearDown() {
        factPlugin = nil
        super.tearDown()
    }
    
    func testAddAndGetStringFact() {
        // Given
        let key = "testString"
        let value = "Hello, World!"
        
        // When
        factPlugin.addFact(key: key, value: value)
        
        // Then
        XCTAssertEqual(factPlugin.getType(key: key), "String")
        XCTAssertEqual(factPlugin.getValue<String>(key: key), value)
        
        let fact = factPlugin.getFact(key: key)
        XCTAssertEqual(fact?.type, "String")
        XCTAssertEqual(fact?.value as? String, value)
    }
    
    func testAddAndGetIntFact() {
        // Given
        let key = "testInt"
        let value = 42
        
        // When
        factPlugin.addFact(key: key, value: value)
        
        // Then
        XCTAssertEqual(factPlugin.getType(key: key), "Int")
        XCTAssertEqual(factPlugin.getValue<Int>(key: key), value)
    }
    
    func testAddAndGetArrayFact() {
        // Given
        let key = "testArray"
        let value = [1, 2, 3]
        
        // When
        factPlugin.addFact(key: key, value: value)
        
        // Then
        XCTAssertEqual(factPlugin.getType(key: key), "Array<Int>")
        XCTAssertEqual(factPlugin.getValue<[Int]>(key: key), value)
    }
    
    func testGetNonExistentFact() {
        // Given
        let key = "nonExistent"
        
        // Then
        XCTAssertNil(factPlugin.getFact(key: key), "getFact should return nil for non-existent key")
        XCTAssertNil(factPlugin.getType(key: key), "getType should return nil for non-existent key")
        let value: String? = factPlugin.getValue<String>(key: key)
        XCTAssertNil(value, "getValue should return nil for non-existent key")
    }
    
    func testTypeConversion() {
        // Given
        let key = "number"
        let value = 42
        
        // When
        factPlugin.addFact(key: key, value: value)
        
        // Then
        // Test successful type conversion
        let intValue: Int? = factPlugin.getValue<Int>(key: key)
        XCTAssertEqual(intValue, 42, "Should successfully convert to Int")
        
        // Test failed type conversion
        let stringValue: String? = factPlugin.getValue<String>(key: key)
        XCTAssertNil(stringValue, "Should fail to convert Int to String")
        
        // Test that the type is stored correctly
        XCTAssertEqual(factPlugin.getType(key: key), "Int", "Type should be stored as Int")
    }
    
    func testOverwriteExistingFact() {
        // Given
        let key = "test"
        
        // When
        factPlugin.addFact(key: key, value: "First")
        factPlugin.addFact(key: key, value: 42)
        
        // Then
        XCTAssertEqual(factPlugin.getType(key: key), "Int")
        XCTAssertEqual(factPlugin.getValue<Int>(key: key), 42)
    }
    
    func testWriteMethodDoesntCrash() {
        // Given
        factPlugin.addFact(key: "string", value: "Test")
        factPlugin.addFact(key: "number", value: 42)
        
        // Then
        XCTAssertNoThrow(factPlugin.write())
    }
    
    func testPrintFactsDoesntCrash() {
        // Given
        factPlugin.addFact(key: "string", value: "Test")
        factPlugin.addFact(key: "number", value: 42)
        
        // Then
        XCTAssertNoThrow(factPlugin.printFacts())
    }
}