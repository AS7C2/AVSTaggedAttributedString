//
//  AVSTaggedAttributedStringTests.swift
//  AVSTaggedAttributedString
//
//  Created by Andrei Sherstniuk on 8/8/16.
//
//

import XCTest

import AVSTaggedAttributedString

class AVSTaggedAttributedStringTests: XCTestCase {

#if os(OSX)
    let redColor = NSColor.redColor()
    let blueColor = NSColor.blueColor()
#else
    let redColor = UIColor.redColor()
    let blueColor = UIColor.blueColor()
#endif

    func testEmpty() {
        let s = ""
        let mas = NSMutableAttributedString(string: s)
        mas.avs_addAttributes([NSFontAttributeName: redColor], tag: "tag1")
        XCTAssertEqual(NSAttributedString(string: s), (mas.copy() as! NSAttributedString))
    }

    func testWithoutTags() {
        let s = "string"
        let mas = NSMutableAttributedString(string: s)
        mas.avs_addAttributes([NSForegroundColorAttributeName: redColor], tag: "tag1")
        XCTAssertEqual(NSAttributedString(string: s), (mas.copy() as! NSAttributedString))
    }

    func testEmptyWithTagRemove() {
        let s = "<tag1></tag1>"
        let mas = NSMutableAttributedString(string: s)
        mas.avs_addAttributes([NSForegroundColorAttributeName: redColor], tag: "tag1")
        XCTAssertEqual(NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: redColor]), (mas.copy() as! NSAttributedString))
    }

    func testNoEmptyWithSwitchedOpenAndCloseTagRemove() {
        let s = "</tag1>string<tag1>"
        let mas = NSMutableAttributedString(string: s)
        mas.avs_addAttributes([NSForegroundColorAttributeName: redColor], tag: "tag1")
        let expected = NSAttributedString(string: s)
        XCTAssertEqual(expected, (mas.copy() as! NSAttributedString))
    }

    func testNoEmptyWithTwoTagsRemove() {
        let s = "<tag1>string</tag1><tag2>text</tag2>"
        let mas = NSMutableAttributedString(string: s)
        mas.avs_addAttributes([NSForegroundColorAttributeName: redColor], tag: "tag1")
        mas.avs_addAttributes([NSForegroundColorAttributeName: blueColor], tag: "tag2")
        let expected = NSMutableAttributedString(string: "stringtext")
        expected.addAttributes([NSForegroundColorAttributeName: redColor], range: NSRange(location:0, length: 6))
        expected.addAttributes([NSForegroundColorAttributeName: blueColor], range: NSRange(location:6, length: 4))
        XCTAssertEqual((expected.copy() as! NSAttributedString), (mas.copy() as! NSAttributedString))
    }

    func testWithTwoConsequentSameTagsRemove() {
        let s = "<tag1>string</tag1> <tag1>text</tag1>"
        let mas = NSMutableAttributedString(string: s)
        mas.avs_addAttributes([NSForegroundColorAttributeName: redColor], tag: "tag1")
        let expected = NSMutableAttributedString(string: "string text")
        expected.addAttributes([NSForegroundColorAttributeName: redColor], range: NSRange(location:0, length: 6))
        expected.addAttributes([NSForegroundColorAttributeName: redColor], range: NSRange(location:7, length: 4))
        XCTAssertEqual((expected.copy() as! NSAttributedString), (mas.copy() as! NSAttributedString))
    }
}

