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

struct RWSQLiteResultCode : OptionSet {
    let rawValue: Int
    
    // MARK: Result Codes
    
    static let ok            = RWSQLiteResultCode(rawValue:   0) // SQLITE_OK           0 /* Successful result */
    
    static let error         = RWSQLiteResultCode(rawValue:   1) // SQLITE_ERROR        1 /* Generic error */
    static let `internal`    = RWSQLiteResultCode(rawValue:   2) // SQLITE_INTERNAL     2 /* Internal logic error in SQLite */
    static let permission    = RWSQLiteResultCode(rawValue:   3) // SQLITE_PERM         3 /* Access permission denied */
    static let abort         = RWSQLiteResultCode(rawValue:   4) // SQLITE_ABORT        4 /* Callback routine requested an abort */
    static let busy          = RWSQLiteResultCode(rawValue:   5) // SQLITE_BUSY         5 /* The database file is locked */
    static let locked        = RWSQLiteResultCode(rawValue:   6) // SQLITE_LOCKED       6 /* A table in the database is locked */
    static let memory        = RWSQLiteResultCode(rawValue:   7) // SQLITE_NOMEM        7 /* A malloc() failed */
    static let readonly      = RWSQLiteResultCode(rawValue:   8) // SQLITE_READONLY     8 /* Attempt to write a readonly database */
    static let interrup      = RWSQLiteResultCode(rawValue:   9) // SQLITE_INTERRUPT    9 /* Operation terminated by sqlite3_interrupt()*/
    static let ioError       = RWSQLiteResultCode(rawValue:  10) // SQLITE_IOERR       10 /* Some kind of disk I/O error occurred */
    static let corrup        = RWSQLiteResultCode(rawValue:  11) // SQLITE_CORRUPT     11 /* The database disk image is malformed */
    static let notFoun       = RWSQLiteResultCode(rawValue:  12) // SQLITE_NOTFOUND    12 /* Unknown opcode in sqlite3_file_control() */
    static let full          = RWSQLiteResultCode(rawValue:  13) // SQLITE_FULL        13 /* Insertion failed because database is full */
    static let canNotOpen    = RWSQLiteResultCode(rawValue:  14) // SQLITE_CANTOPEN    14 /* Unable to open the database file */
    static let `protocol`    = RWSQLiteResultCode(rawValue:  15) // SQLITE_PROTOCOL    15 /* Database lock protocol error */
    static let empty         = RWSQLiteResultCode(rawValue:  16) // SQLITE_EMPTY       16 /* Internal use only */
    static let schema        = RWSQLiteResultCode(rawValue:  17) // SQLITE_SCHEMA      17 /* The database schema changed */
    static let tooBig        = RWSQLiteResultCode(rawValue:  18) // SQLITE_TOOBIG      18 /* String or BLOB exceeds size limit */
    static let constraint    = RWSQLiteResultCode(rawValue:  19) // SQLITE_CONSTRAINT  19 /* Abort due to constraint violation */
    static let mismatch      = RWSQLiteResultCode(rawValue:  20) // SQLITE_MISMATCH    20 /* Data type mismatch */
    static let misuse        = RWSQLiteResultCode(rawValue:  21) // SQLITE_MISUSE      21 /* Library used incorrectly */
    static let noLfs         = RWSQLiteResultCode(rawValue:  22) // SQLITE_NOLFS       22 /* Uses OS features not supported on host */
    static let authorization = RWSQLiteResultCode(rawValue:  23) // SQLITE_AUTH        23 /* Authorization denied */
    static let format        = RWSQLiteResultCode(rawValue:  24) // SQLITE_FORMAT      24 /* Not used */
    static let range         = RWSQLiteResultCode(rawValue:  25) // SQLITE_RANGE       25 /* 2nd parameter to sqlite3_bind out of range */
    static let notDatabase   = RWSQLiteResultCode(rawValue:  26) // SQLITE_NOTADB      26 /* File opened that is not a database file */
    static let notice        = RWSQLiteResultCode(rawValue:  27) // SQLITE_NOTICE      27 /* Notifications from sqlite3_log() */
    static let warning       = RWSQLiteResultCode(rawValue:  28) // SQLITE_WARNING     28 /* Warnings from sqlite3_log() */
    static let row           = RWSQLiteResultCode(rawValue: 100) // SQLITE_ROW        100 /* sqlite3_step() has another row ready */
    static let done          = RWSQLiteResultCode(rawValue: 101) // SQLITE_DONE       101 /* sqlite3_step() has finished executing */

    // MARK: Extended Result Codes
    
    static let errorCollatingSequence          = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.error.rawValue         | ( 1<<8))) // SQLITE_ERROR_MISSING_COLLSEQ   (SQLITE_ERROR | (1<<8))
    static let errorRetry                      = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.error.rawValue         | ( 2<<8))) // SQLITE_ERROR_RETRY             (SQLITE_ERROR | (2<<8))
    static let errorSnapshot                   = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.error.rawValue         | ( 3<<8))) // SQLITE_ERROR_SNAPSHOT          (SQLITE_ERROR | (3<<8))
    
    static let ioErrorRead                     = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | ( 1<<8))) // SQLITE_IOERR_READ              (SQLITE_IOERR | (1<<8))
    static let ioErrorShortRead                = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | ( 2<<8))) // SQLITE_IOERR_SHORT_READ        (SQLITE_IOERR | (2<<8))
    static let ioErrorWrite                    = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | ( 3<<8))) // SQLITE_IOERR_WRITE             (SQLITE_IOERR | (3<<8))
    static let ioErrorFileSynchronize          = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | ( 4<<8))) // SQLITE_IOERR_FSYNC             (SQLITE_IOERR | (4<<8))
    static let ioErrorDirectoryFileSynchronize = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | ( 5<<8))) // SQLITE_IOERR_DIR_FSYNC         (SQLITE_IOERR | (5<<8))
    static let ioErrorTruncate                 = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | ( 6<<8))) // SQLITE_IOERR_TRUNCATE          (SQLITE_IOERR | (6<<8))
    static let ioErrorFileStat                 = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | ( 7<<8))) // SQLITE_IOERR_FSTAT             (SQLITE_IOERR | (7<<8))
    static let ioErrorUnlock                   = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | ( 8<<8))) // SQLITE_IOERR_UNLOCK            (SQLITE_IOERR | (8<<8))
    static let ioErrorReadLock                 = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | ( 9<<8))) // SQLITE_IOERR_RDLOCK            (SQLITE_IOERR | (9<<8))
    static let ioErrorDelete                   = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (10<<8))) // SQLITE_IOERR_DELETE            (SQLITE_IOERR | (10<<8))
    static let ioErrorBlocked                  = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (11<<8))) // SQLITE_IOERR_BLOCKED           (SQLITE_IOERR | (11<<8))
    static let ioErrorNoMemory                 = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (12<<8))) // SQLITE_IOERR_NOMEM             (SQLITE_IOERR | (12<<8))
    static let ioErrorAccess                   = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (13<<8))) // SQLITE_IOERR_ACCESS            (SQLITE_IOERR | (13<<8))
    static let ioErrorCheckReservedLock        = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (14<<8))) // SQLITE_IOERR_CHECKRESERVEDLOCK (SQLITE_IOERR | (14<<8))
    static let ioErrorLock                     = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (15<<8))) // SQLITE_IOERR_LOCK              (SQLITE_IOERR | (15<<8))
    static let ioErrorClose                    = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (16<<8))) // SQLITE_IOERR_CLOSE             (SQLITE_IOERR | (16<<8))
    static let ioErrorDirectoryClose           = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (17<<8))) // SQLITE_IOERR_DIR_CLOSE         (SQLITE_IOERR | (17<<8))
    static let ioErrorSharedMemoryOpen         = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (18<<8))) // SQLITE_IOERR_SHMOPEN           (SQLITE_IOERR | (18<<8))
    static let ioErrorSharedMemorySize         = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (19<<8))) // SQLITE_IOERR_SHMSIZE           (SQLITE_IOERR | (19<<8))
    static let ioErrorSharedMemoryLock         = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (20<<8))) // SQLITE_IOERR_SHMLOCK           (SQLITE_IOERR | (20<<8))
    static let ioErrorSharedMemoryMap          = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (21<<8))) // SQLITE_IOERR_SHMMAP            (SQLITE_IOERR | (21<<8))
    static let ioErrorSeek                     = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (22<<8))) // SQLITE_IOERR_SEEK              (SQLITE_IOERR | (22<<8))
    static let ioErrorDeleteNoEntity           = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (23<<8))) // SQLITE_IOERR_DELETE_NOENT      (SQLITE_IOERR | (23<<8))
    static let ioErrorMmap                     = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (24<<8))) // SQLITE_IOERR_MMAP              (SQLITE_IOERR | (24<<8))
    static let ioErrorGetTempPath              = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (25<<8))) // SQLITE_IOERR_GETTEMPPATH       (SQLITE_IOERR | (25<<8))
    static let ioErrorConvertPath              = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (26<<8))) // SQLITE_IOERR_CONVPATH          (SQLITE_IOERR | (26<<8))
    static let ioErrorVNode                    = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (27<<8))) // SQLITE_IOERR_VNODE             (SQLITE_IOERR | (27<<8))
    static let ioErrorAuthorize                = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (28<<8))) // SQLITE_IOERR_AUTH              (SQLITE_IOERR | (28<<8))
    static let ioErrorBeginAtomic              = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (29<<8))) // SQLITE_IOERR_BEGIN_ATOMIC      (SQLITE_IOERR | (29<<8))
    static let ioErrorCommitAtomic             = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (30<<8))) // SQLITE_IOERR_COMMIT_ATOMIC     (SQLITE_IOERR | (30<<8))
    static let ioErrorRollbackAtomic           = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ioError.rawValue       | (31<<8))) // SQLITE_IOERR_ROLLBACK_ATOMIC   (SQLITE_IOERR | (31<<8))
    
    static let lockedSharedCach                = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.locked.rawValue        | ( 1<<8))) // SQLITE_LOCKED_SHAREDCACHE      (SQLITE_LOCKED |  (1<<8))
    static let lockedVTab                      = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.locked.rawValue        | ( 2<<8))) // SQLITE_LOCKED_VTAB             (SQLITE_LOCKED |  (2<<8))
    
    static let busyRecovery                    = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.busy.rawValue          | ( 1<<8))) // SQLITE_BUSY_RECOVERY           (SQLITE_BUSY   |  (1<<8))
    static let busySnapshot                    = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.busy.rawValue          | ( 2<<8))) // SQLITE_BUSY_SNAPSHOT           (SQLITE_BUSY   |  (2<<8))
    
    static let canNotOpenNotTempDirectory      = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.canNotOpen.rawValue    | ( 1<<8))) // SQLITE_CANTOPEN_NOTEMPDIR      (SQLITE_CANTOPEN | (1<<8))
    static let canNotOpenIsDirectory           = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.canNotOpen.rawValue    | ( 2<<8))) // SQLITE_CANTOPEN_ISDIR          (SQLITE_CANTOPEN | (2<<8))
    static let canNotOpenFullPath              = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.canNotOpen.rawValue    | ( 3<<8))) // SQLITE_CANTOPEN_FULLPATH       (SQLITE_CANTOPEN | (3<<8))
    static let canNotOpenConvertPath           = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.canNotOpen.rawValue    | ( 4<<8))) // SQLITE_CANTOPEN_CONVPATH       (SQLITE_CANTOPEN | (4<<8))
    static let canNotOpenDirtyWal              = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.canNotOpen.rawValue    | ( 5<<8))) // SQLITE_CANTOPEN_DIRTYWAL       (SQLITE_CANTOPEN | (5<<8)) /* NOT USED */
    
    static let corrupVTab                      = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.corrup.rawValue        | ( 1<<8))) // SQLITE_CORRUPT_VTAB            (SQLITE_CORRUPT | (1<<8))
    static let corrupSequence                  = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.corrup.rawValue        | ( 2<<8))) // SQLITE_CORRUPT_SEQUENCE        (SQLITE_CORRUPT | (2<<8))
    
    static let readonlyRecovery                = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.readonly.rawValue      | ( 1<<8))) // SQLITE_READONLY_RECOVERY       (SQLITE_READONLY | (1<<8))
    static let readonlyCanNotLock              = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.readonly.rawValue      | ( 2<<8))) // SQLITE_READONLY_CANTLOCK       (SQLITE_READONLY | (2<<8))
    static let readonlyRollback                = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.readonly.rawValue      | ( 3<<8))) // SQLITE_READONLY_ROLLBACK       (SQLITE_READONLY | (3<<8))
    static let readonlyDataBaseMoved           = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.readonly.rawValue      | ( 4<<8))) // SQLITE_READONLY_DBMOVED        (SQLITE_READONLY | (4<<8))
    static let readonlyCanNotInitialize        = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.readonly.rawValue      | ( 5<<8))) // SQLITE_READONLY_CANTINIT       (SQLITE_READONLY | (5<<8))
    static let readonlyDirectory               = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.readonly.rawValue      | ( 6<<8))) // SQLITE_READONLY_DIRECTORY      (SQLITE_READONLY | (6<<8))
    
    static let abortRollback                   = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.abort.rawValue         | ( 2<<8))) // SQLITE_ABORT_ROLLBACK          (SQLITE_ABORT | (2<<8))
    
    static let constraintCheck                 = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.constraint.rawValue    | ( 1<<8))) // SQLITE_CONSTRAINT_CHECK        (SQLITE_CONSTRAINT | (1<<8))
    static let constraintCommitHook            = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.constraint.rawValue    | ( 2<<8))) // SQLITE_CONSTRAINT_COMMITHOOK   (SQLITE_CONSTRAINT | (2<<8))
    static let constraintForeingKey            = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.constraint.rawValue    | ( 3<<8))) // SQLITE_CONSTRAINT_FOREIGNKEY   (SQLITE_CONSTRAINT | (3<<8))
    static let constraintFunction              = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.constraint.rawValue    | ( 4<<8))) // SQLITE_CONSTRAINT_FUNCTION     (SQLITE_CONSTRAINT | (4<<8))
    static let constraintNotNull               = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.constraint.rawValue    | ( 5<<8))) // SQLITE_CONSTRAINT_NOTNULL      (SQLITE_CONSTRAINT | (5<<8))
    static let constraintPrimaryKey            = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.constraint.rawValue    | ( 6<<8))) // SQLITE_CONSTRAINT_PRIMARYKEY   (SQLITE_CONSTRAINT | (6<<8))
    static let constraintTrigger               = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.constraint.rawValue    | ( 7<<8))) // SQLITE_CONSTRAINT_TRIGGER      (SQLITE_CONSTRAINT | (7<<8))
    static let constraintUnique                = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.constraint.rawValue    | ( 8<<8))) // SQLITE_CONSTRAINT_UNIQUE       (SQLITE_CONSTRAINT | (8<<8))
    static let constraintVtab                  = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.constraint.rawValue    | ( 9<<8))) // SQLITE_CONSTRAINT_VTAB         (SQLITE_CONSTRAINT | (9<<8))
    static let constraintRowId                 = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.constraint.rawValue    | (10<<8))) // SQLITE_CONSTRAINT_ROWID        (SQLITE_CONSTRAINT |(10<<8))
    
    static let noticeWal                       = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.notice.rawValue        | ( 1<<8))) // SQLITE_NOTICE_RECOVER_WAL      (SQLITE_NOTICE | (1<<8))
    static let noticeRecoverRollback           = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.notice.rawValue        | ( 2<<8))) // SQLITE_NOTICE_RECOVER_ROLLBACK (SQLITE_NOTICE | (2<<8))
    
    static let warningAutoIndex                = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.warning.rawValue       | ( 1<<8))) // SQLITE_WARNING_AUTOINDEX       (SQLITE_WARNING | (1<<8))
    
    static let authorizationUser               = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.authorization.rawValue | ( 1<<8))) // SQLITE_AUTH_USER               (SQLITE_AUTH | (1<<8))
    
    static let okLoadPermanently               = RWSQLiteResultCode(rawValue: (RWSQLiteResultCode.ok.rawValue            | ( 1<<8))) // SQLITE_OK_LOAD_PERMANENTLY     (SQLITE_OK | (1<<8))
}
