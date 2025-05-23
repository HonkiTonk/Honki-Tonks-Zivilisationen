--//////////////////////////////////////////////////////////
-- SFML - Simple and Fast Multimedia Library
-- Copyright (C) 2007-2023 Laurent Gomila (laurent@sfml-dev.org)
-- This software is provided 'as-is', without any express or implied warranty.
-- In no event will the authors be held liable for any damages arising from the use of this software.
-- Permission is granted to anyone to use this software for any purpose,
-- including commercial applications, and to alter it and redistribute it freely,
-- subject to the following restrictions:
-- 1. The origin of this software must not be misrepresented;
--    you must not claim that you wrote the original software.
--    If you use this software in a product, an acknowledgment
--    in the product documentation would be appreciated but is not required.
-- 2. Altered source versions must be plainly marked as such,
--    and must not be misrepresented as being the original software.
-- 3. This notice may not be removed or altered from any source distribution.
--//////////////////////////////////////////////////////////

--//////////////////////////////////////////////////////////




with Sf.Network.IpAddress;
with Sf.System.Time;

package Sf.Network.Ftp is

   --//////////////////////////////////////////////////////////
   --//////////////////////////////////////////////////////////
   --//////////////////////////////////////////////////////////

   --//////////////////////////////////////////////////////////
   --//////////////////////////////////////////////////////////
   --/ @brief Enumeration of transfer modes
   --/
   --//////////////////////////////////////////////////////////
   type sfFtpTransferMode is
     (sfFtpBinary, --/< Binary mode (file is transfered as a sequence of bytes)
      sfFtpAscii,  --/< Text mode using ASCII encoding
      sfFtpEbcdic  --/< Text mode using EBCDIC encoding
     );

   --//////////////////////////////////////////////////////////
   --/ @brief Status codes possibly returned by a FTP response
   --/
   --//////////////////////////////////////////////////////////
   subtype sfFtpStatus is sfUint32;
                                                                    -- 1xx: the requested action is being initiated,
                                                                    -- expect another reply before proceeding with a new command
   sfFtpRestartMarkerReply          : constant sfFtpStatus := 110;  --/< Restart marker reply
   sfFtpServiceReadySoon            : constant sfFtpStatus := 120;  --/< Service ready in N minutes
   sfFtpDataConnectionAlreadyOpened : constant sfFtpStatus := 125;  --/< Data connection already opened, transfer starting
   sfFtpOpeningDataConnection       : constant sfFtpStatus := 150;  --/< File status ok, about to open data connection
                                                                    -- 2xx: the requested action has been successfully completed
   sfFtpOk                          : constant sfFtpStatus := 200;  --/< Command ok
   sfFtpPointlessCommand            : constant sfFtpStatus := 202;  --/< Command not implemented
   sfFtpSystemStatus                : constant sfFtpStatus := 211;  --/< System status, or system help reply
   sfFtpDirectoryStatus             : constant sfFtpStatus := 212;  --/< Directory status
   sfFtpFileStatus                  : constant sfFtpStatus := 213;  --/< File status
   sfFtpHelpMessage                 : constant sfFtpStatus := 214;  --/< Help message
   sfFtpSystemType                  : constant sfFtpStatus := 215;  --/< NAME system type, where NAME is an official system name from the list in the Assigned Numbers document
   sfFtpServiceReady                : constant sfFtpStatus := 220;  --/< Service ready for new user
   sfFtpClosingConnection           : constant sfFtpStatus := 221;  --/< Service closing control connection
   sfFtpDataConnectionOpened        : constant sfFtpStatus := 225;  --/< Data connection open, no transfer in progress
   sfFtpClosingDataConnection       : constant sfFtpStatus := 226;  --/< Closing data connection, requested file action successful
   sfFtpEnteringPassiveMode         : constant sfFtpStatus := 227;  --/< Entering passive mode
   sfFtpLoggedIn                    : constant sfFtpStatus := 230;  --/< User logged in, proceed. Logged out if appropriate
   sfFtpFileActionOk                : constant sfFtpStatus := 250;  --/< Requested file action ok
   sfFtpDirectoryOk                 : constant sfFtpStatus := 257;  --/< PATHNAME created
                                                                    -- 3xx: the command has been accepted, but the requested action
                                                                    -- is dormant, pending receipt of further information
   sfFtpNeedPassword                : constant sfFtpStatus := 331;  --/< User name ok, need password
   sfFtpNeedAccountToLogIn          : constant sfFtpStatus := 332;  --/< Need account for login
   sfFtpNeedInformation             : constant sfFtpStatus := 350;  --/< Requested file action pending further information
                                                                    -- 4xx: the command was not accepted and the requested action did not take place,
                                                                    -- but the error condition is temporary and the action may be requested again
   sfFtpServiceUnavailable          : constant sfFtpStatus := 421;  --/< Service not available, closing control connection
   sfFtpDataConnectionUnavailable   : constant sfFtpStatus := 425;  --/< Can't open data connection
   sfFtpTransferAborted             : constant sfFtpStatus := 426;  --/< Connection closed, transfer aborted
   sfFtpFileActionAborted           : constant sfFtpStatus := 450;  --/< Requested file action not taken
   sfFtpLocalError                  : constant sfFtpStatus := 451;  --/< Requested action aborted, local error in processing
   sfFtpInsufficientStorageSpace    : constant sfFtpStatus := 452;  --/< Requested action not taken; insufficient storage space in system, file unavailable
                                                                    -- 5xx: the command was not accepted and
                                                                    -- the requested action did not take place
   sfFtpCommandUnknown              : constant sfFtpStatus := 500;  --/< Syntax error, command unrecognized
   sfFtpParametersUnknown           : constant sfFtpStatus := 501;  --/< Syntax error in parameters or arguments
   sfFtpCommandNotImplemented       : constant sfFtpStatus := 502;  --/< Command not implemented
   sfFtpBadCommandSequence          : constant sfFtpStatus := 503;  --/< Bad sequence of commands
   sfFtpParameterNotImplemented     : constant sfFtpStatus := 504;  --/< Command not implemented for that parameter
   sfFtpNotLoggedIn                 : constant sfFtpStatus := 530;  --/< Not logged in
   sfFtpNeedAccountToStore          : constant sfFtpStatus := 532;  --/< Need account for storing files
   sfFtpFileUnavailable             : constant sfFtpStatus := 550;  --/< Requested action not taken, file unavailable
   sfFtpPageTypeUnknown             : constant sfFtpStatus := 551;  --/< Requested action aborted, page type unknown
   sfFtpNotEnoughMemory             : constant sfFtpStatus := 552;  --/< Requested file action aborted, exceeded storage allocation
   sfFtpFilenameNotAllowed          : constant sfFtpStatus := 553;  --/< Requested action not taken, file name not allowed
                                                                    -- 10xx: SFML custom codes
   sfFtpInvalidResponse             : constant sfFtpStatus := 1000; --/< Response is not a valid FTP one
   sfFtpConnectionFailed            : constant sfFtpStatus := 1001; --/< Connection with server failed
   sfFtpConnectionClosed            : constant sfFtpStatus := 1002; --/< Connection with server closed
   sfFtpInvalidFile                 : constant sfFtpStatus := 1003; --/< Invalid file to upload / download

   package ListingResponse is

      --//////////////////////////////////////////////////////////
      --/ @brief Destroy a FTP listing response
      --/
      --/ @param ftpListingResponse Ftp listing response to destroy
      --/
      --//////////////////////////////////////////////////////////
      procedure destroy (ftpListingResponse : sfFtpListingResponse_Ptr);

      --//////////////////////////////////////////////////////////
      --/ @brief Check if a FTP listing response status code means a success
      --/
      --/ This function is defined for convenience, it is
      --/ equivalent to testing if the status code is < 400.
      --/
      --/ @param ftpListingResponse Ftp listing response
      --/
      --/ @return sfTrue if the status is a success, sfFalse if it is a failure
      --/
      --//////////////////////////////////////////////////////////
      function isOk (ftpListingResponse : sfFtpListingResponse_Ptr) return sfBool;

      --//////////////////////////////////////////////////////////
      --/ @brief Get the status code of a FTP listing response
      --/
      --/ @param ftpListingResponse Ftp listing response
      --/
      --/ @return Status code
      --/
      --//////////////////////////////////////////////////////////
      function getStatus (ftpListingResponse : sfFtpListingResponse_Ptr) return sfFtpStatus;

      --//////////////////////////////////////////////////////////
      --/ @brief Get the full message contained in a FTP listing response
      --/
      --/ @param ftpListingResponse Ftp listing response
      --/
      --/ @return The response message
      --/
      --//////////////////////////////////////////////////////////
      function getMessage (ftpListingResponse : sfFtpListingResponse_Ptr) return String;

      --//////////////////////////////////////////////////////////
      --/ @brief Return the number of directory/file names contained in a FTP listing response
      --/
      --/ @param ftpListingResponse Ftp listing response
      --/
      --/ @return Total number of names available
      --/
      --//////////////////////////////////////////////////////////
      function getCount (ftpListingResponse : sfFtpListingResponse_Ptr) return sfSize_t;

      --//////////////////////////////////////////////////////////
      --/ @brief Return a directory/file name contained in a FTP listing response
      --/
      --/ @param ftpListingResponse Ftp listing response
      --/ @param index              Index of the name to get (in range [0 .. getCount-1])
      --/
      --/ @return The requested name
      --/
      --//////////////////////////////////////////////////////////
      function getName (ftpListingResponse : sfFtpListingResponse_Ptr; index : sfSize_t) return String;

   private
      pragma Import (C, destroy, "sfFtpListingResponse_destroy");
      pragma Import (C, isOk, "sfFtpListingResponse_isOk");
      pragma Import (C, getStatus, "sfFtpListingResponse_getStatus");
      pragma Import (C, getCount, "sfFtpListingResponse_getCount");

   end ListingResponse;

   package DirectoryResponse is

      --//////////////////////////////////////////////////////////
      --/ @brief Destroy a FTP directory response
      --/
      --/ @param ftpDirectoryResponse Ftp directory response to destroy
      --/
      --//////////////////////////////////////////////////////////
      procedure destroy (ftpDirectoryResponse : sfFtpDirectoryResponse_Ptr);

      --//////////////////////////////////////////////////////////
      --/ @brief Check if a FTP directory response status code means a success
      --/
      --/ This function is defined for convenience, it is
      --/ equivalent to testing if the status code is < 400.
      --/
      --/ @param ftpDirectoryResponse Ftp directory response
      --/
      --/ @return sfTrue if the status is a success, sfFalse if it is a failure
      --/
      --//////////////////////////////////////////////////////////
      function isOk (ftpDirectoryResponse : sfFtpDirectoryResponse_Ptr) return sfBool;

      --//////////////////////////////////////////////////////////
      --/ @brief Get the status code of a FTP directory response
      --/
      --/ @param ftpDirectoryResponse Ftp directory response
      --/
      --/ @return Status code
      --/
      --//////////////////////////////////////////////////////////
      function getStatus (ftpDirectoryResponse : sfFtpDirectoryResponse_Ptr) return sfFtpStatus;

      --//////////////////////////////////////////////////////////
      --/ @brief Get the full message contained in a FTP directory response
      --/
      --/ @param ftpDirectoryResponse Ftp directory response
      --/
      --/ @return The response message
      --/
      --//////////////////////////////////////////////////////////
      function getMessage (ftpDirectoryResponse : sfFtpDirectoryResponse_Ptr) return String;

      --//////////////////////////////////////////////////////////
      --/ @brief Get the directory returned in a FTP directory response
      --/
      --/ @param ftpDirectoryResponse Ftp directory response
      --/
      --/ @return Directory name
      --/
      --//////////////////////////////////////////////////////////
      function getDirectory (ftpDirectoryResponse : sfFtpDirectoryResponse_Ptr) return String;

   private

      pragma Import (C, destroy, "sfFtpDirectoryResponse_destroy");
      pragma Import (C, isOk, "sfFtpDirectoryResponse_isOk");
      pragma Import (C, getStatus, "sfFtpDirectoryResponse_getStatus");

   end DirectoryResponse;

   package Response is

   --//////////////////////////////////////////////////////////
   --/ @brief Destroy a FTP response
   --/
   --/ @param ftpResponse Ftp response to destroy
   --/
   --//////////////////////////////////////////////////////////
   procedure destroy (ftpResponse : sfFtpResponse_Ptr);

   --//////////////////////////////////////////////////////////
   --/ @brief Check if a FTP response status code means a success
   --/
   --/ This function is defined for convenience, it is
   --/ equivalent to testing if the status code is < 400.
   --/
   --/ @param ftpResponse Ftp response object
   --/
   --/ @return sfTrue if the status is a success, sfFalse if it is a failure
   --/
   --//////////////////////////////////////////////////////////
   function isOk (ftpResponse : sfFtpResponse_Ptr) return sfBool;

   --//////////////////////////////////////////////////////////
   --/ @brief Get the status code of a FTP response
   --/
   --/ @param ftpResponse Ftp response object
   --/
   --/ @return Status code
   --/
   --//////////////////////////////////////////////////////////
   function getStatus (ftpResponse : sfFtpResponse_Ptr) return sfFtpStatus;

   --//////////////////////////////////////////////////////////
   --/ @brief Get the full message contained in a FTP response
   --/
   --/ @param ftpResponse Ftp response object
   --/
   --/ @return The response message
   --/
   --//////////////////////////////////////////////////////////
   function getMessage (ftpResponse : sfFtpResponse_Ptr) return String;

   private

      pragma Import (C, destroy, "sfFtpResponse_destroy");
      pragma Import (C, isOk, "sfFtpResponse_isOk");
      pragma Import (C, getStatus, "sfFtpResponse_getStatus");

   end Response;

   --//////////////////////////////////////////////////////////
   --/ @brief Create a new Ftp object
   --/
   --/ @return A new sfFtp object
   --/
   --//////////////////////////////////////////////////////////
   function create return sfFtp_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Destroy a Ftp object
   --/
   --/ @param ftp Ftp object to destroy
   --/
   --//////////////////////////////////////////////////////////
   procedure destroy (ftp : sfFtp_Ptr);

   --//////////////////////////////////////////////////////////
   --/ @brief Connect to the specified FTP server
   --/
   --/ The port should be 21, which is the standard
   --/ port used by the FTP protocol. You shouldn't use a different
   --/ value, unless you really know what you do.
   --/ This function tries to connect to the server so it may take
   --/ a while to complete, especially if the server is not
   --/ reachable. To avoid blocking your application for too long,
   --/ you can use a timeout. Using 0 means that the
   --/ system timeout will be used (which is usually pretty long).
   --/
   --/ @param ftp     Ftp object
   --/ @param server  Name or address of the FTP server to connect to
   --/ @param port    Port used for the connection
   --/ @param timeout Maximum time to wait
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function connect
     (ftp     : sfFtp_Ptr;
      server  : Sf.Network.IpAddress.sfIpAddress;
      port    : sfUint16;
      timeout : Sf.System.Time.sfTime) return sfFtpResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Log in using an anonymous account
   --/
   --/ Logging in is mandatory after connecting to the server.
   --/ Users that are not logged in cannot perform any operation.
   --/
   --/ @param ftp Ftp object
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function loginAnonymous (ftp : sfFtp_Ptr) return sfFtpResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Log in using a username and a password
   --/
   --/ Logging in is mandatory after connecting to the server.
   --/ Users that are not logged in cannot perform any operation.
   --/
   --/ @param ftp      Ftp object
   --/ @param name     User name
   --/ @param password Password
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function login
     (ftp      : sfFtp_Ptr;
      name     : String;
      password : String) return sfFtpResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Close the connection with the server
   --/
   --/ @param ftp Ftp object
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function disconnect (ftp : sfFtp_Ptr) return sfFtpResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Send a null command to keep the connection alive
   --/
   --/ This command is useful because the server may close the
   --/ connection automatically if no command is sent.
   --/
   --/ @param ftp Ftp object
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function keepAlive (ftp : sfFtp_Ptr) return sfFtpResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Get the current working directory
   --/
   --/ The working directory is the root path for subsequent
   --/ operations involving directories and/or filenames.
   --/
   --/ @param ftp Ftp object
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function getWorkingDirectory (ftp : sfFtp_Ptr) return sfFtpDirectoryResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Get the contents of the given directory
   --/
   --/ This function retrieves the sub-directories and files
   --/ contained in the given directory. It is not recursive.
   --/ The @a directory parameter is relative to the current
   --/ working directory.
   --/
   --/ @param ftp       Ftp object
   --/ @param directory Directory to list
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function getDirectoryListing (ftp : sfFtp_Ptr; directory : String)
                                return sfFtpListingResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Change the current working directory
   --/
   --/ The new directory must be relative to the current one.
   --/
   --/ @param ftp       Ftp object
   --/ @param directory New working directory
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function changeDirectory (ftp       : sfFtp_Ptr;
                             directory : String) return sfFtpResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Go to the parent directory of the current one
   --/
   --/ @param ftp Ftp object
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function parentDirectory (ftp : sfFtp_Ptr) return sfFtpResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Create a new directory
   --/
   --/ The new directory is created as a child of the current
   --/ working directory.
   --/
   --/ @param ftp  Ftp object
   --/ @param name Name of the directory to create
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function createDirectory (ftp  : sfFtp_Ptr;
                             name : String) return sfFtpResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Remove an existing directory
   --/
   --/ The directory to remove must be relative to the
   --/ current working directory.
   --/ Use this function with caution, the directory will
   --/ be removed permanently!
   --/
   --/ @param ftp  Ftp object
   --/ @param name Name of the directory to remove
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function deleteDirectory (ftp : sfFtp_Ptr; name : String) return sfFtpResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Rename an existing file
   --/
   --/ The filenames must be relative to the current working
   --/ directory.
   --/
   --/ @param ftp     Ftp object
   --/ @param file    File to rename
   --/ @param newName New name of the file
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function renameFile
     (ftp     : sfFtp_Ptr;
      file    : String;
      newName : String) return sfFtpResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Remove an existing file
   --/
   --/ The file name must be relative to the current working
   --/ directory.
   --/ Use this function with caution, the file will be
   --/ removed permanently!
   --/
   --/ @param ftp  Ftp object
   --/ @param name File to remove
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function deleteFile (ftp  : sfFtp_Ptr;
                        name : String) return sfFtpResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Download a file from a FTP server
   --/
   --/ The filename of the distant file is relative to the
   --/ current working directory of the server, and the local
   --/ destination path is relative to the current directory
   --/ of your application.
   --/
   --/ @param ftp        Ftp object
   --/ @param remoteFile Filename of the distant file to download
   --/ @param localPath  Where to put to file on the local computer
   --/ @param mode       Transfer mode
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function download
     (ftp        : sfFtp_Ptr;
      remoteFile : String;
      localPath  : String;
      mode       : sfFtpTransferMode) return sfFtpResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Upload a file to a FTP server
   --/
   --/ The name of the local file is relative to the current
   --/ working directory of your application, and the
   --/ remote path is relative to the current directory of the
   --/ FTP server.
   --/
   --/ @param ftp        Ftp object
   --/ @param localFile  Path of the local file to upload
   --/ @param remotePath Where to put to file on the server
   --/ @param mode       Transfer mode
   --/ @param append     Pass sfTrue to append to or sfFalse to overwrite the remote file if it already exists
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function upload
     (ftp        : sfFtp_Ptr;
      localFile  : String;
      remotePath : String;
      mode : sfFtpTransferMode;
      append : sfBool) return sfFtpResponse_Ptr;

   --//////////////////////////////////////////////////////////
   --/ @brief Send a command to the FTP server
   --/
   --/ While the most often used commands are provided as
   --/ specific functions, this function can be used to send
   --/ any FTP command to the server. If the command requires
   --/ one or more parameters, they can be specified in
   --/ @a parameter. Otherwise you should pass NULL.
   --/ If the server returns information, you can extract it
   --/ from the response using sfResponse_getMessage().
   --/
   --/ @param ftp       Ftp object
   --/ @param command   Command to send
   --/ @param parameter Command parameter
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function sendCommand
     (ftp       : sfFtp_Ptr;
      command   : String;
      parameter : String) return sfFtpResponse_Ptr;

private

   pragma Convention (C, sfFtpTransferMode);
   pragma Import (C, create, "sfFtp_create");
   pragma Import (C, destroy, "sfFtp_destroy");
   pragma Import (C, connect, "sfFtp_connect");
   pragma Import (C, loginAnonymous, "sfFtp_loginAnonymous");
   pragma Import (C, disconnect, "sfFtp_disconnect");
   pragma Import (C, keepAlive, "sfFtp_keepAlive");
   pragma Import (C, getWorkingDirectory, "sfFtp_getWorkingDirectory");
   pragma Import (C, parentDirectory, "sfFtp_parentDirectory");


end Sf.Network.Ftp;
