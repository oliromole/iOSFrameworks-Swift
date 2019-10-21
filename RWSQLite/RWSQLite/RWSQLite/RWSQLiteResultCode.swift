//
//  RWSQLiteResultCode.swift
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

struct RWSQLiteResultCode : Equatable
{
    public let rawValue: Int
    
    // MARK: Result Codes
    
    public static let ok            = RWSQLiteResultCode(  0) // SQLITE_OK           0 /* Successful result */
    
    public static let error         = RWSQLiteResultCode(  1) // SQLITE_ERROR        1 /* Generic error */
    public static let `internal`    = RWSQLiteResultCode(  2) // SQLITE_INTERNAL     2 /* Internal logic error in SQLite */
    public static let permission    = RWSQLiteResultCode(  3) // SQLITE_PERM         3 /* Access permission denied */
    public static let abort         = RWSQLiteResultCode(  4) // SQLITE_ABORT        4 /* Callback routine requested an abort */
    public static let busy          = RWSQLiteResultCode(  5) // SQLITE_BUSY         5 /* The database file is locked */
    public static let locked        = RWSQLiteResultCode(  6) // SQLITE_LOCKED       6 /* A table in the database is locked */
    public static let memory        = RWSQLiteResultCode(  7) // SQLITE_NOMEM        7 /* A malloc() failed */
    public static let readonly      = RWSQLiteResultCode(  8) // SQLITE_READONLY     8 /* Attempt to write a readonly database */
    public static let interrup      = RWSQLiteResultCode(  9) // SQLITE_INTERRUPT    9 /* Operation terminated by sqlite3_interrupt()*/
    public static let ioError       = RWSQLiteResultCode( 10) // SQLITE_IOERR       10 /* Some kind of disk I/O error occurred */
    public static let corrup        = RWSQLiteResultCode( 11) // SQLITE_CORRUPT     11 /* The database disk image is malformed */
    public static let notFoun       = RWSQLiteResultCode( 12) // SQLITE_NOTFOUND    12 /* Unknown opcode in sqlite3_file_control() */
    public static let full          = RWSQLiteResultCode( 13) // SQLITE_FULL        13 /* Insertion failed because database is full */
    public static let canNotOpen    = RWSQLiteResultCode( 14) // SQLITE_CANTOPEN    14 /* Unable to open the database file */
    public static let `protocol`    = RWSQLiteResultCode( 15) // SQLITE_PROTOCOL    15 /* Database lock protocol error */
    public static let empty         = RWSQLiteResultCode( 16) // SQLITE_EMPTY       16 /* Internal use only */
    public static let schema        = RWSQLiteResultCode( 17) // SQLITE_SCHEMA      17 /* The database schema changed */
    public static let tooBig        = RWSQLiteResultCode( 18) // SQLITE_TOOBIG      18 /* String or BLOB exceeds size limit */
    public static let constraint    = RWSQLiteResultCode( 19) // SQLITE_CONSTRAINT  19 /* Abort due to constraint violation */
    public static let mismatch      = RWSQLiteResultCode( 20) // SQLITE_MISMATCH    20 /* Data type mismatch */
    public static let misuse        = RWSQLiteResultCode( 21) // SQLITE_MISUSE      21 /* Library used incorrectly */
    public static let noLfs         = RWSQLiteResultCode( 22) // SQLITE_NOLFS       22 /* Uses OS features not supported on host */
    public static let authorization = RWSQLiteResultCode( 23) // SQLITE_AUTH        23 /* Authorization denied */
    public static let format        = RWSQLiteResultCode( 24) // SQLITE_FORMAT      24 /* Not used */
    public static let range         = RWSQLiteResultCode( 25) // SQLITE_RANGE       25 /* 2nd parameter to sqlite3_bind out of range */
    public static let notDatabase   = RWSQLiteResultCode( 26) // SQLITE_NOTADB      26 /* File opened that is not a database file */
    public static let notice        = RWSQLiteResultCode( 27) // SQLITE_NOTICE      27 /* Notifications from sqlite3_log() */
    public static let warning       = RWSQLiteResultCode( 28) // SQLITE_WARNING     28 /* Warnings from sqlite3_log() */
    public static let row           = RWSQLiteResultCode(100) // SQLITE_ROW        100 /* sqlite3_step() has another row ready */
    public static let done          = RWSQLiteResultCode(101) // SQLITE_DONE       101 /* sqlite3_step() has finished executing */
    
    // MARK: Extended Result Codes
    
    public static let errorCollatingSequence          = RWSQLiteResultCode(RWSQLiteResultCode.error.rawValue         | ( 1<<8)) // SQLITE_ERROR_MISSING_COLLSEQ   (SQLITE_ERROR | (1<<8))
    public static let errorRetry                      = RWSQLiteResultCode(RWSQLiteResultCode.error.rawValue         | ( 2<<8)) // SQLITE_ERROR_RETRY             (SQLITE_ERROR | (2<<8))
    public static let errorSnapshot                   = RWSQLiteResultCode(RWSQLiteResultCode.error.rawValue         | ( 3<<8)) // SQLITE_ERROR_SNAPSHOT          (SQLITE_ERROR | (3<<8))
    
    public static let ioErrorRead                     = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | ( 1<<8)) // SQLITE_IOERR_READ              (SQLITE_IOERR | (1<<8))
    public static let ioErrorShortRead                = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | ( 2<<8)) // SQLITE_IOERR_SHORT_READ        (SQLITE_IOERR | (2<<8))
    public static let ioErrorWrite                    = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | ( 3<<8)) // SQLITE_IOERR_WRITE             (SQLITE_IOERR | (3<<8))
    public static let ioErrorFileSynchronize          = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | ( 4<<8)) // SQLITE_IOERR_FSYNC             (SQLITE_IOERR | (4<<8))
    public static let ioErrorDirectoryFileSynchronize = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | ( 5<<8)) // SQLITE_IOERR_DIR_FSYNC         (SQLITE_IOERR | (5<<8))
    public static let ioErrorTruncate                 = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | ( 6<<8)) // SQLITE_IOERR_TRUNCATE          (SQLITE_IOERR | (6<<8))
    public static let ioErrorFileStat                 = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | ( 7<<8)) // SQLITE_IOERR_FSTAT             (SQLITE_IOERR | (7<<8))
    public static let ioErrorUnlock                   = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | ( 8<<8)) // SQLITE_IOERR_UNLOCK            (SQLITE_IOERR | (8<<8))
    public static let ioErrorReadLock                 = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | ( 9<<8)) // SQLITE_IOERR_RDLOCK            (SQLITE_IOERR | (9<<8))
    public static let ioErrorDelete                   = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (10<<8)) // SQLITE_IOERR_DELETE            (SQLITE_IOERR | (10<<8))
    public static let ioErrorBlocked                  = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (11<<8)) // SQLITE_IOERR_BLOCKED           (SQLITE_IOERR | (11<<8))
    public static let ioErrorNoMemory                 = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (12<<8)) // SQLITE_IOERR_NOMEM             (SQLITE_IOERR | (12<<8))
    public static let ioErrorAccess                   = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (13<<8)) // SQLITE_IOERR_ACCESS            (SQLITE_IOERR | (13<<8))
    public static let ioErrorCheckReservedLock        = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (14<<8)) // SQLITE_IOERR_CHECKRESERVEDLOCK (SQLITE_IOERR | (14<<8))
    public static let ioErrorLock                     = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (15<<8)) // SQLITE_IOERR_LOCK              (SQLITE_IOERR | (15<<8))
    public static let ioErrorClose                    = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (16<<8)) // SQLITE_IOERR_CLOSE             (SQLITE_IOERR | (16<<8))
    public static let ioErrorDirectoryClose           = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (17<<8)) // SQLITE_IOERR_DIR_CLOSE         (SQLITE_IOERR | (17<<8))
    public static let ioErrorSharedMemoryOpen         = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (18<<8)) // SQLITE_IOERR_SHMOPEN           (SQLITE_IOERR | (18<<8))
    public static let ioErrorSharedMemorySize         = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (19<<8)) // SQLITE_IOERR_SHMSIZE           (SQLITE_IOERR | (19<<8))
    public static let ioErrorSharedMemoryLock         = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (20<<8)) // SQLITE_IOERR_SHMLOCK           (SQLITE_IOERR | (20<<8))
    public static let ioErrorSharedMemoryMap          = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (21<<8)) // SQLITE_IOERR_SHMMAP            (SQLITE_IOERR | (21<<8))
    public static let ioErrorSeek                     = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (22<<8)) // SQLITE_IOERR_SEEK              (SQLITE_IOERR | (22<<8))
    public static let ioErrorDeleteNoEntity           = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (23<<8)) // SQLITE_IOERR_DELETE_NOENT      (SQLITE_IOERR | (23<<8))
    public static let ioErrorMmap                     = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (24<<8)) // SQLITE_IOERR_MMAP              (SQLITE_IOERR | (24<<8))
    public static let ioErrorGetTempPath              = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (25<<8)) // SQLITE_IOERR_GETTEMPPATH       (SQLITE_IOERR | (25<<8))
    public static let ioErrorConvertPath              = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (26<<8)) // SQLITE_IOERR_CONVPATH          (SQLITE_IOERR | (26<<8))
    public static let ioErrorVNode                    = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (27<<8)) // SQLITE_IOERR_VNODE             (SQLITE_IOERR | (27<<8))
    public static let ioErrorAuthorize                = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (28<<8)) // SQLITE_IOERR_AUTH              (SQLITE_IOERR | (28<<8))
    public static let ioErrorBeginAtomic              = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (29<<8)) // SQLITE_IOERR_BEGIN_ATOMIC      (SQLITE_IOERR | (29<<8))
    public static let ioErrorCommitAtomic             = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (30<<8)) // SQLITE_IOERR_COMMIT_ATOMIC     (SQLITE_IOERR | (30<<8))
    public static let ioErrorRollbackAtomic           = RWSQLiteResultCode(RWSQLiteResultCode.ioError.rawValue       | (31<<8)) // SQLITE_IOERR_ROLLBACK_ATOMIC   (SQLITE_IOERR | (31<<8))
    
    public static let lockedSharedCach                = RWSQLiteResultCode(RWSQLiteResultCode.locked.rawValue        | ( 1<<8)) // SQLITE_LOCKED_SHAREDCACHE      (SQLITE_LOCKED |  (1<<8))
    public static let lockedVTab                      = RWSQLiteResultCode(RWSQLiteResultCode.locked.rawValue        | ( 2<<8)) // SQLITE_LOCKED_VTAB             (SQLITE_LOCKED |  (2<<8))
    
    public static let busyRecovery                    = RWSQLiteResultCode(RWSQLiteResultCode.busy.rawValue          | ( 1<<8)) // SQLITE_BUSY_RECOVERY           (SQLITE_BUSY   |  (1<<8))
    public static let busySnapshot                    = RWSQLiteResultCode(RWSQLiteResultCode.busy.rawValue          | ( 2<<8)) // SQLITE_BUSY_SNAPSHOT           (SQLITE_BUSY   |  (2<<8))
    
    public static let canNotOpenNotTempDirectory      = RWSQLiteResultCode(RWSQLiteResultCode.canNotOpen.rawValue    | ( 1<<8)) // SQLITE_CANTOPEN_NOTEMPDIR      (SQLITE_CANTOPEN | (1<<8))
    public static let canNotOpenIsDirectory           = RWSQLiteResultCode(RWSQLiteResultCode.canNotOpen.rawValue    | ( 2<<8)) // SQLITE_CANTOPEN_ISDIR          (SQLITE_CANTOPEN | (2<<8))
    public static let canNotOpenFullPath              = RWSQLiteResultCode(RWSQLiteResultCode.canNotOpen.rawValue    | ( 3<<8)) // SQLITE_CANTOPEN_FULLPATH       (SQLITE_CANTOPEN | (3<<8))
    public static let canNotOpenConvertPath           = RWSQLiteResultCode(RWSQLiteResultCode.canNotOpen.rawValue    | ( 4<<8)) // SQLITE_CANTOPEN_CONVPATH       (SQLITE_CANTOPEN | (4<<8))
    public static let canNotOpenDirtyWal              = RWSQLiteResultCode(RWSQLiteResultCode.canNotOpen.rawValue    | ( 5<<8)) // SQLITE_CANTOPEN_DIRTYWAL       (SQLITE_CANTOPEN | (5<<8)) /* NOT USED */
    
    public static let corrupVTab                      = RWSQLiteResultCode(RWSQLiteResultCode.corrup.rawValue        | ( 1<<8)) // SQLITE_CORRUPT_VTAB            (SQLITE_CORRUPT | (1<<8))
    public static let corrupSequence                  = RWSQLiteResultCode(RWSQLiteResultCode.corrup.rawValue        | ( 2<<8)) // SQLITE_CORRUPT_SEQUENCE        (SQLITE_CORRUPT | (2<<8))
    
    public static let readonlyRecovery                = RWSQLiteResultCode(RWSQLiteResultCode.readonly.rawValue      | ( 1<<8)) // SQLITE_READONLY_RECOVERY       (SQLITE_READONLY | (1<<8))
    public static let readonlyCanNotLock              = RWSQLiteResultCode(RWSQLiteResultCode.readonly.rawValue      | ( 2<<8)) // SQLITE_READONLY_CANTLOCK       (SQLITE_READONLY | (2<<8))
    public static let readonlyRollback                = RWSQLiteResultCode(RWSQLiteResultCode.readonly.rawValue      | ( 3<<8)) // SQLITE_READONLY_ROLLBACK       (SQLITE_READONLY | (3<<8))
    public static let readonlyDataBaseMoved           = RWSQLiteResultCode(RWSQLiteResultCode.readonly.rawValue      | ( 4<<8)) // SQLITE_READONLY_DBMOVED        (SQLITE_READONLY | (4<<8))
    public static let readonlyCanNotInitialize        = RWSQLiteResultCode(RWSQLiteResultCode.readonly.rawValue      | ( 5<<8)) // SQLITE_READONLY_CANTINIT       (SQLITE_READONLY | (5<<8))
    public static let readonlyDirectory               = RWSQLiteResultCode(RWSQLiteResultCode.readonly.rawValue      | ( 6<<8)) // SQLITE_READONLY_DIRECTORY      (SQLITE_READONLY | (6<<8))
    
    public static let abortRollback                   = RWSQLiteResultCode(RWSQLiteResultCode.abort.rawValue         | ( 2<<8)) // SQLITE_ABORT_ROLLBACK          (SQLITE_ABORT | (2<<8))
    
    public static let constraintCheck                 = RWSQLiteResultCode(RWSQLiteResultCode.constraint.rawValue    | ( 1<<8)) // SQLITE_CONSTRAINT_CHECK        (SQLITE_CONSTRAINT | (1<<8))
    public static let constraintCommitHook            = RWSQLiteResultCode(RWSQLiteResultCode.constraint.rawValue    | ( 2<<8)) // SQLITE_CONSTRAINT_COMMITHOOK   (SQLITE_CONSTRAINT | (2<<8))
    public static let constraintForeingKey            = RWSQLiteResultCode(RWSQLiteResultCode.constraint.rawValue    | ( 3<<8)) // SQLITE_CONSTRAINT_FOREIGNKEY   (SQLITE_CONSTRAINT | (3<<8))
    public static let constraintFunction              = RWSQLiteResultCode(RWSQLiteResultCode.constraint.rawValue    | ( 4<<8)) // SQLITE_CONSTRAINT_FUNCTION     (SQLITE_CONSTRAINT | (4<<8))
    public static let constraintNotNull               = RWSQLiteResultCode(RWSQLiteResultCode.constraint.rawValue    | ( 5<<8)) // SQLITE_CONSTRAINT_NOTNULL      (SQLITE_CONSTRAINT | (5<<8))
    public static let constraintPrimaryKey            = RWSQLiteResultCode(RWSQLiteResultCode.constraint.rawValue    | ( 6<<8)) // SQLITE_CONSTRAINT_PRIMARYKEY   (SQLITE_CONSTRAINT | (6<<8))
    public static let constraintTrigger               = RWSQLiteResultCode(RWSQLiteResultCode.constraint.rawValue    | ( 7<<8)) // SQLITE_CONSTRAINT_TRIGGER      (SQLITE_CONSTRAINT | (7<<8))
    public static let constraintUnique                = RWSQLiteResultCode(RWSQLiteResultCode.constraint.rawValue    | ( 8<<8)) // SQLITE_CONSTRAINT_UNIQUE       (SQLITE_CONSTRAINT | (8<<8))
    public static let constraintVtab                  = RWSQLiteResultCode(RWSQLiteResultCode.constraint.rawValue    | ( 9<<8)) // SQLITE_CONSTRAINT_VTAB         (SQLITE_CONSTRAINT | (9<<8))
    public static let constraintRowId                 = RWSQLiteResultCode(RWSQLiteResultCode.constraint.rawValue    | (10<<8)) // SQLITE_CONSTRAINT_ROWID        (SQLITE_CONSTRAINT |(10<<8))
    
    public static let noticeWal                       = RWSQLiteResultCode(RWSQLiteResultCode.notice.rawValue        | ( 1<<8)) // SQLITE_NOTICE_RECOVER_WAL      (SQLITE_NOTICE | (1<<8))
    public static let noticeRecoverRollback           = RWSQLiteResultCode(RWSQLiteResultCode.notice.rawValue        | ( 2<<8)) // SQLITE_NOTICE_RECOVER_ROLLBACK (SQLITE_NOTICE | (2<<8))
    
    public static let warningAutoIndex                = RWSQLiteResultCode(RWSQLiteResultCode.warning.rawValue       | ( 1<<8)) // SQLITE_WARNING_AUTOINDEX       (SQLITE_WARNING | (1<<8))
    
    public static let authorizationUser               = RWSQLiteResultCode(RWSQLiteResultCode.authorization.rawValue | ( 1<<8)) // SQLITE_AUTH_USER               (SQLITE_AUTH | (1<<8))
    
    public static let okLoadPermanently               = RWSQLiteResultCode(RWSQLiteResultCode.ok.rawValue            | ( 1<<8)) // SQLITE_OK_LOAD_PERMANENTLY     (SQLITE_OK | (1<<8))
    
    // MARK: Initializers

    public init(_ rawValue: Int)
    {
        self.rawValue = rawValue
    }
    
    public init(_ rawValue: Int32)
    {
        self.rawValue = Int(rawValue)
    }
    
    // MARK: Equatable
    
    public static func == (lhs: RWSQLiteResultCode, rhs: RWSQLiteResultCode) -> Bool
    {
        let isEqual : Bool = (lhs.rawValue == rhs.rawValue)
        
        return isEqual
    }
}
