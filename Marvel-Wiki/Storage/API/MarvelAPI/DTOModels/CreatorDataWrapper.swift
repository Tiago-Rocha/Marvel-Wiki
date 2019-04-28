//
// CreatorDataWrapper.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct CreatorDataWrapper: Codable {

    /** The HTTP status code of the returned result. */
    public var code: Int?
    /** A string description of the call status. */
    public var status: String?
    /** The copyright notice for the returned result. */
    public var copyright: String?
    /** The attribution notice for this result.  Please display either this notice or the contents of the attributionHTML field on all screens which contain data from the Marvel Comics API. */
    public var attributionText: String?
    /** An HTML representation of the attribution notice for this result.  Please display either this notice or the contents of the attributionText field on all screens which contain data from the Marvel Comics API. */
    public var attributionHTML: String?
    /** The results returned by the call. */
    public var data: CreatorDataContainer?
    /** A digest value of the content returned by the call. */
    public var etag: String?

    public init(code: Int?, status: String?, copyright: String?, attributionText: String?, attributionHTML: String?, data: CreatorDataContainer?, etag: String?) {
        self.code = code
        self.status = status
        self.copyright = copyright
        self.attributionText = attributionText
        self.attributionHTML = attributionHTML
        self.data = data
        self.etag = etag
    }


}

