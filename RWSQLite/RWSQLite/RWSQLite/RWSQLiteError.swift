//
//  RWSQLiteError.swift
//  RWSQLite
//  https://github.com/oliromole/iOSFrameworks-Swift.git
//
//  Created by Roman Oliichuk on 2019.10.17.
//  Copyright (c) 2012-2019 Roman Oliichuk. All rights reserved.
//

/*
 Copyright (C) 2012-2019 Roman Oliichuk. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors
 may be used to endorse or promote products derived from this
 software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import SQLite3

struct RWSQLiteError: Error
{
    public let errorMessage: String?
    public let extendedResultCode: RWSQLiteResultCode
    public let resultCode: RWSQLiteResultCode
    
    // MARK: - Initializers
    
    public init(resultCode: RWSQLiteResultCode, extendedResultCode: RWSQLiteResultCode, errorMessage: String?)
    {
        self.errorMessage = errorMessage
        self.extendedResultCode = extendedResultCode
        self.resultCode = resultCode
    }
}

func RWSQLiteErrorCreate(sqlite3:OpaquePointer?) -> RWSQLiteError
{
    let resultCodeOrExtendedResultCode: RWSQLiteResultCode
    
    if (sqlite3 == nil)
    {
        resultCodeOrExtendedResultCode = RWSQLiteResultCode.ok
    }
    else
    {
        resultCodeOrExtendedResultCode = RWSQLiteResultCode(sqlite3_extended_errcode(sqlite3))
    }
    
    let extendedResultCode: RWSQLiteResultCode = resultCodeOrExtendedResultCode
    
    let resultCode: RWSQLiteResultCode = RWSQLiteResultCode(extendedResultCode.rawValue & 0xFF)
    
    let cErrorMessage: UnsafePointer<Int8>? = sqlite3_errstr(Int32(extendedResultCode.rawValue))
    
    var errorMessage: String?
    
    if let cErrorMessage = cErrorMessage
    {
        errorMessage = String(cString: cErrorMessage)
    }
    
    let error = RWSQLiteError(resultCode: resultCode,
                              extendedResultCode: extendedResultCode,
                              errorMessage: errorMessage);
    
    return error
}

func RWSQLiteErrorCreate(sqlite3:OpaquePointer?, resultCodeOrExtendedResultCode: RWSQLiteResultCode) -> RWSQLiteError
{
    var extendedResultCode: RWSQLiteResultCode = resultCodeOrExtendedResultCode
    
    let resultCode: RWSQLiteResultCode = RWSQLiteResultCode(extendedResultCode.rawValue & 0xFF)
    
    if (extendedResultCode == resultCode) && (sqlite3 != nil)
    {
        let extendedResultCode2 = RWSQLiteResultCode(sqlite3_extended_errcode(sqlite3))
        
        if (extendedResultCode2.rawValue & 0xFF) == resultCode.rawValue
        {
            extendedResultCode = extendedResultCode2
        }
    }
    
    let cErrorMessage: UnsafePointer<Int8>? = sqlite3_errstr(Int32(extendedResultCode.rawValue))
    
    var errorMessage: String?
    
    if let cErrorMessage = cErrorMessage
    {
        errorMessage = String(cString: cErrorMessage)
    }
    
    let error = RWSQLiteError(resultCode: resultCode,
                              extendedResultCode: extendedResultCode,
                              errorMessage: errorMessage);
    
    return error
}

func RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode) -> RWSQLiteError
{
    let extendedResultCode: RWSQLiteResultCode = resultCodeOrExtendedResultCode
    
    let resultCode: RWSQLiteResultCode = RWSQLiteResultCode(extendedResultCode.rawValue & 0xFF)
    
    let cErrorMessage: UnsafePointer<Int8>? = sqlite3_errstr(Int32(extendedResultCode.rawValue))
    
    var errorMessage: String?
    
    if let cErrorMessage = cErrorMessage
    {
        errorMessage = String(cString: cErrorMessage)
    }
    
    let error = RWSQLiteError(resultCode: resultCode,
                              extendedResultCode: extendedResultCode,
                              errorMessage: errorMessage);
    
    return error
}
