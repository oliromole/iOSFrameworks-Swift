//
//  RWSQLiteStatement.swift
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

import Foundation
import SQLite3

class RWSQLiteStatement
{
    private var mSqlite3_stmt: OpaquePointer?
    
    // MARK: - Initializing and Creating a RWSQLiteStatement
    
    public init()
    {
        mSqlite3_stmt = nil
    }
    
    public convenience init(sqlite3_stmt: OpaquePointer?)
    {
        self.init()
        
        self.sqlite3_stmt = sqlite3_stmt;
    }
    
    // MARK: Deinitializer
    
    deinit
    {
        if mSqlite3_stmt != nil
        {
            let resultCode = RWSQLiteResultCode(sqlite3_finalize(mSqlite3_stmt))
            
            if resultCode != RWSQLiteResultCode.ok
            {
                fatalError("Can not finalize SQLite statement.")
            }
            
            mSqlite3_stmt = nil
        }
    }
    
    // MARK: - Managing the sqlite3_stmt
    
    public var sqlite3_stmt: OpaquePointer?
    {
        get
        {
            return mSqlite3_stmt
        }
        set
        {
            if mSqlite3_stmt != newValue
            {
                mSqlite3_stmt = newValue
            }
        }
    }
    
    // MARK: - Retrieving Statement SQL
    
    public func getCommand() throws -> String?
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        guard let cCommand: UnsafePointer<Int8> = sqlite3_sql(sqlite3_stmt) else
        {
            return nil;
        }
        
        let command = String(cString: cCommand)
        
        return command
    }
    
    // MARK: - Determining if an SQL Statement Writes the Database
    
    public func getIsReadonly() throws -> Bool
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let isReadonly: Bool = (sqlite3_stmt_readonly(sqlite3_stmt) != 0)
        
        return isReadonly;
    }
    
    // MARK: - Binding Values To Prepared Statements
    
    public func bindData(data: Data, atIndex: Int) throws -> Void
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let dataCount : Int = data.count
        
        var resultCode : RWSQLiteResultCode = RWSQLiteResultCode.ok
        
        data.withUnsafeBytes { (byteCArray: UnsafeRawBufferPointer) in
            if MemoryLayout.size(ofValue: dataCount) == MemoryLayout.size(ofValue: Int32(0))
            {
                resultCode = RWSQLiteResultCode(sqlite3_bind_blob(sqlite3_stmt,
                                                                  Int32(atIndex + 1),
                                                                  byteCArray.baseAddress,
                                                                  Int32(data.count),
                                                                  RWSQLiteDestructorType.transient.rawValue))
            }
            else
            {
                resultCode = RWSQLiteResultCode(sqlite3_bind_blob64(sqlite3_stmt,
                                                                    Int32(atIndex + 1),
                                                                    byteCArray.baseAddress,
                                                                    UInt64(data.count),
                                                                    RWSQLiteDestructorType.transient.rawValue))
            }
        }
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let sqlite3: OpaquePointer? = sqlite3_db_handle(sqlite3_stmt)
            
            let error = RWSQLiteErrorCreate(sqlite3: sqlite3, resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
    }
    
    public func bindData(data: Data, forName: String) throws -> Void
    {
        let atIndex = try self.bindIndexForName(forName)
        
        try self.bindData(data: data, atIndex: atIndex)
    }
    
    public func bindDouble(value: Double, atIndex: Int) throws -> Void
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let resultCode = RWSQLiteResultCode(sqlite3_bind_double(sqlite3_stmt,
                                                                Int32(atIndex + 1),
                                                                value))
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let sqlite3: OpaquePointer? = sqlite3_db_handle(sqlite3_stmt)
            
            let error = RWSQLiteErrorCreate(sqlite3: sqlite3, resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
    }
    
    public func bindDouble(value: Double, forName: String) throws -> Void
    {
        let atIndex = try self.bindIndexForName(forName)
        
        try self.bindDouble(value: value, atIndex: atIndex)
    }
    
    public func bindInt(value: Int, atIndex: Int) throws -> Void
    {
        if MemoryLayout.size(ofValue: Int(0)) == MemoryLayout.size(ofValue: Int32(0))
        {
            try self.bindInt32(value: Int32(value), atIndex: atIndex)
        }
        else
        {
            try self.bindInt32(value: Int32(value), atIndex: atIndex)
        }
    }
    
    public func bindInt(value: Int, forName: String) throws -> Void
    {
        if MemoryLayout.size(ofValue: Int(0)) == MemoryLayout.size(ofValue: Int32(0))
        {
            try self.bindInt32(value: Int32(value), forName: forName)
        }
        else
        {
            try self.bindInt32(value: Int32(value), forName: forName)
        }
    }
    
    public func bindInt32(value: Int32, atIndex: Int) throws -> Void
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let resultCode = RWSQLiteResultCode(sqlite3_bind_int(sqlite3_stmt,
                                                             Int32(atIndex + 1),
                                                             value))
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let sqlite3: OpaquePointer? = sqlite3_db_handle(sqlite3_stmt)
            
            let error = RWSQLiteErrorCreate(sqlite3: sqlite3, resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
    }
    
    public func bindInt32(value: Int32, forName: String) throws -> Void
    {
        let atIndex = try self.bindIndexForName(forName)
        
        try self.bindInt32(value: value, atIndex: atIndex)
    }
    
    public func bindInt64(value: Int64, atIndex: Int) throws -> Void
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let resultCode = RWSQLiteResultCode(sqlite3_bind_int64(sqlite3_stmt,
                                                               Int32(atIndex + 1),
                                                               value))
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let sqlite3: OpaquePointer? = sqlite3_db_handle(sqlite3_stmt)
            
            let error = RWSQLiteErrorCreate(sqlite3: sqlite3, resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
    }
    
    public func bindInt64(value: Int64, forName: String) throws -> Void
    {
        let atIndex = try self.bindIndexForName(forName)
        
        try self.bindInt64(value: value, atIndex: atIndex)
    }
    
    public func bindNil(atIndex: Int) throws -> Void
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let resultCode = RWSQLiteResultCode(sqlite3_bind_null(sqlite3_stmt,
                                                              Int32(atIndex + 1)))
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let sqlite3: OpaquePointer? = sqlite3_db_handle(sqlite3_stmt)
            
            let error = RWSQLiteErrorCreate(sqlite3: sqlite3, resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
    }
    
    public func bindNil(forName: String) throws -> Void
    {
        let atIndex = try self.bindIndexForName(forName)
        
        try self.bindNil(atIndex: atIndex)
    }
    
    public func bindString(value: String?, atIndex: Int) throws -> Void
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let resultCode = RWSQLiteResultCode(sqlite3_bind_text(sqlite3_stmt,
                                                              Int32(atIndex + 1),
                                                              value,
                                                              -1,
                                                              RWSQLiteDestructorType.transient.rawValue))
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let sqlite3: OpaquePointer? = sqlite3_db_handle(sqlite3_stmt)
            
            let error = RWSQLiteErrorCreate(sqlite3: sqlite3, resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
    }
    
    public func bindString(value: String, forName: String) throws -> Void
    {
        let atIndex = try self.bindIndexForName(forName)
        
        try self.bindString(value: value, atIndex: atIndex)
    }
    
    public func bindZeroData(length: Int, atIndex: Int) throws -> Void
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let resultCode = RWSQLiteResultCode(sqlite3_bind_zeroblob(sqlite3_stmt,
                                                                  Int32(atIndex + 1),
                                                                  Int32(length)))
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let sqlite3: OpaquePointer? = sqlite3_db_handle(sqlite3_stmt)
            
            let error = RWSQLiteErrorCreate(sqlite3: sqlite3, resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
    }
    
    public func bindZeroData(length: Int, forName: String) throws -> Void
    {
        let atIndex = try self.bindIndexForName(forName)
        
        try self.bindZeroData(length: length, atIndex: atIndex)
    }
    
    // MARK: - Getting Data Binding
    
    // MARK: Getting a Number of SQL Parameters
    
    public func getBindCount() throws -> Int
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let bindCount = Int(sqlite3_bind_parameter_count(sqlite3_stmt))
        
        return bindCount
    }
    
    // MARK: Name of a Host Parameter
    
    public func bindNameAtIndex(_ bindIndex: Int) throws -> String?
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        guard let cBindName: UnsafePointer<Int8> = sqlite3_bind_parameter_name(sqlite3_stmt, Int32(bindIndex)) else
        {
            return nil
        }
        
        let bindName = String(cString: cBindName)
        
        return bindName
    }
    
    // MARK: Getting Index of a Parameter with a Given Name
    
    public func bindIndexForName(_ bindName: String) throws -> Int
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let bindIndex = Int(sqlite3_bind_parameter_index(sqlite3_stmt, bindName))
        
        return bindIndex
    }
    
    // MARK: - Resetting All Bindings on a Prepared Statement
    
    public func clearBindings() throws -> Void
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let resultCode = RWSQLiteResultCode(sqlite3_clear_bindings(sqlite3_stmt))
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let sqlite3: OpaquePointer? = sqlite3_db_handle(sqlite3_stmt)
            
            let error = RWSQLiteErrorCreate(sqlite3: sqlite3, resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
    }
    
    // MARK: - Getting Result Data
    
    // MARK Getting Number of Columns in a Result Set
    
    public func getCollumCount() throws -> Int
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let collumCount = Int(sqlite3_column_count(sqlite3_stmt))
        
        return collumCount
    }
    
    // MARK: - Getting Column Names in a Result Set
    
    public func getColumnNameAtIndex(_ columnIndex: Int) throws -> String?
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        guard let cColumnName: UnsafePointer<Int8> = sqlite3_column_name(sqlite3_stmt, Int32(columnIndex)) else
        {
            return nil;
        }
        
        let columnName = String(cString: cColumnName)
        
        return columnName
    }
    
    // MARK: - Getting Declared Datatype of a Query Result
    
    public func getColumnDecltypeNameAtIndex(_ columnIndex: Int) throws -> String?
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        guard let cColumnDecltypeName: UnsafePointer<Int8> = sqlite3_column_decltype(sqlite3_stmt, Int32(columnIndex)) else
        {
            return nil;
        }
        
        let columnDecltypeName = String(cString: cColumnDecltypeName)
        
        return columnDecltypeName
    }
    
    // MARK: - Evaluating An SQL Statement
    
    public func step() throws -> Bool
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let resultCode = RWSQLiteResultCode(sqlite3_step(sqlite3_stmt))
        
        let isCompleted: Bool
        
        if resultCode == RWSQLiteResultCode.ok
        {
            isCompleted = true
        }
        else if resultCode == RWSQLiteResultCode.row
        {
            isCompleted = false
        }
        else if resultCode == RWSQLiteResultCode.done
        {
            isCompleted = true
        }
        else
        {
            let sqlite3: OpaquePointer? = sqlite3_db_handle(sqlite3_stmt)
            
            let error = RWSQLiteErrorCreate(sqlite3: sqlite3, resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
        
        return isCompleted
    }
    
    // MARK: - Getting Number of Columns in a Result Set in the Current Row
    
    public func dataCount() throws -> Int
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let dataCount = Int(sqlite3_data_count(sqlite3_stmt))
        
        return dataCount
    }
    
    // MARK: - Destroying a Prepared Statement Object
    
    public func finalize() throws -> Void
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let resultCode = RWSQLiteResultCode(sqlite3_finalize(mSqlite3_stmt))
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let sqlite3: OpaquePointer? = sqlite3_db_handle(sqlite3_stmt)
            
            let error = RWSQLiteErrorCreate(sqlite3: sqlite3, resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
        
        mSqlite3_stmt = nil
    }
    
    // MARK: - Resetting a Prepared Statement Object
    
    public func reset() throws -> Void
    {
        guard let sqlite3_stmt = mSqlite3_stmt else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let resultCode = RWSQLiteResultCode(sqlite3_reset(mSqlite3_stmt))
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let sqlite3: OpaquePointer? = sqlite3_db_handle(sqlite3_stmt)
            
            let error = RWSQLiteErrorCreate(sqlite3: sqlite3, resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
    }
}
