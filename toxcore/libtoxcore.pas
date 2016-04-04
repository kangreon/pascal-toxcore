(*
 * This file is part of pascal-toxcore.
 *
 * pascal-toxcore is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * pascal-toxcore is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with pascal-toxcore. If not, see <http://www.gnu.org/licenses/>.
 *
 *)

//
//  Last update: 04.04.2016
//
unit libtoxcore;

interface
{$IFDEF FPC}
  {$MODE DELPHI}
  {$H+}            (* use AnsiString *)
  {$PACKENUM 4}    (* use 4-byte enums *)
  {$PACKRECORDS C} (* C/C++-compatible record packing *)
{$ELSE}
  {$MINENUMSIZE 4} (* use 4-byte enums *)
{$ENDIF}

type
	TTox = Pointer;

const
{$IF Defined(MSWINDOWS)}
  TOX_LIBRARY     = 'libtoxcore-0.dll';
  TOX_DNS_LIBRARY = 'libtoxcore-0.dll';
  TOXES_LIBRARY   = 'libtoxcore-0.dll';
  TOXAV_LIBRARY   = 'libtoxcore-0.dll';
{$ELSEIF Defined(DARWIN)}
  TOX_LIBRARY     = '';
  TOX_DNS_LIBRARY = '';
  TOXES_LIBRARY   = '';
  TOXAV_LIBRARY   = '';
//  {$linklib libtoxcore}
{$ELSEIF Defined(UNIX)}
  TOX_LIBRARY     = '';
  TOX_DNS_LIBRARY = '';
  TOXES_LIBRARY   = '';
  TOXAV_LIBRARY   = '';
{$IFEND}


  (**
   * The major version number. Incremented when the API or ABI changes in an
   * incompatible way.
   *)
  //#define TOX_VERSION_MAJOR               0u
  TOX_VERSION_MAJOR_ = 0;

  (**
   * The minor version number. Incremented when functionality is added without
   * breaking the API or ABI. Set to 0 when the major version number is
   * incremented.
   *)
  //#define TOX_VERSION_MINOR               0u
  TOX_VERSION_MINOR_ = 0;

  (**
   * The patch or revision number. Incremented when bugfixes are applied without
   * changing any functionality or API or ABI.
   *)
  //#define TOX_VERSION_PATCH               0u
  TOX_VERSION_PATCH_ = 0;

  (**
   * A macro to check at preprocessing time whether the client code is compatible
   * with the installed version of Tox.
   *)
  //#define TOX_VERSION_IS_API_COMPATIBLE(MAJOR, MINOR, PATCH)      \
  //  (TOX_VERSION_MAJOR == MAJOR &&                                \
  //   (TOX_VERSION_MINOR > MINOR ||                                \
  //    (TOX_VERSION_MINOR == MINOR &&                              \
  //     TOX_VERSION_PATCH >= PATCH)))
  function TOX_VERSION_IS_API_COMPATIBLE(MAJOR, MINOR, PATCH: Integer): Boolean;
//TODO: Проверить

(**
 * Return the major version number of the library. Can be used to display the
 * Tox library version or to check whether the client is compatible with the
 * dynamically linked version of Tox.
 *)
//uint32_t tox_version_major(void);
function tox_version_major: Cardinal; cdecl; external TOX_LIBRARY;
//TODO: Проверить tox_version_major

(*
 * Return the minor version number of the library.
 *)
//uint32_t tox_version_minor(void);
function tox_version_minor: Cardinal; cdecl; external TOX_LIBRARY;
//TODO: Проверить tox_version_minor


(**
 * Return the patch number of the library.
 *)
//uint32_t tox_version_patch(void);
function tox_version_patch: Cardinal; cdecl; external TOX_LIBRARY;
//TODO: Проверить tox_version_patch

//todo: что-нибудь придумать
///**
// * Return whether the compiled library version is compatible with the passed
// * version numbers.
// */
//bool tox_version_is_compatible(uint32_t major, uint32_t minor, uint32_t patch);
//
///**
// * A convenience macro to call tox_version_is_compatible with the currently
// * compiling API version.
// */
//#define TOX_VERSION_IS_ABI_COMPATIBLE()                         \
//  tox_version_is_compatible(TOX_VERSION_MAJOR, TOX_VERSION_MINOR, TOX_VERSION_PATCH)



(*******************************************************************************
 *
 * :: Numeric constants
 *
 ******************************************************************************)
const


  (**
   * The size of a Tox Public Key in bytes.
   *)
  //#define TOX_PUBLIC_KEY_SIZE            32
  TOX_PUBLIC_KEY_SIZE = 32;

  (**
   * The size of a Tox Secret Key in bytes.
   *)
  //#define TOX_SECRET_KEY_SIZE            32
  TOX_SECRET_KEY_SIZE = 32;

  (**
   * The size of a Tox address in bytes. Tox addresses are in the format
   * [Public Key (TOX_PUBLIC_KEY_SIZE bytes)][nospam (4 bytes)][checksum (2 bytes)].
   *
   * The checksum is computed over the Public Key and the nospam value. The first
   * byte is an XOR of all the even bytes (0, 2, 4, ...), the second byte is an
   * XOR of all the odd bytes (1, 3, 5, ...) of the Public Key and nospam.
   *)
  //#define TOX_ADDRESS_SIZE               (TOX_PUBLIC_KEY_SIZE + sizeof(uint32_t) + sizeof(uint16_t))
  TOX_ADDRESS_SIZE = TOX_PUBLIC_KEY_SIZE + SizeOf(Cardinal) + SizeOf(Word);

  (**
   * Maximum length of a nickname in bytes.
   *)
  //#define TOX_MAX_NAME_LENGTH            128
  TOX_MAX_NAME_LENGTH = 128;

  (**
   * Maximum length of a status message in bytes.
   *)
  //#define TOX_MAX_STATUS_MESSAGE_LENGTH  1007
  TOX_MAX_STATUS_MESSAGE_LENGTH = 1007;

  (**
   * Maximum length of a friend request message in bytes.
   *)
  //#define TOX_MAX_FRIEND_REQUEST_LENGTH  1016
  TOX_MAX_FRIEND_REQUEST_LENGTH = 1016;

  (**
   * Maximum length of a single message after which it should be split.
   *)
  //#define TOX_MAX_MESSAGE_LENGTH         1372
  TOX_MAX_MESSAGE_LENGTH = 1372;

  (**
   * Maximum size of custom packets. TODO: should be LENGTH?
   *)
  //#define TOX_MAX_CUSTOM_PACKET_SIZE     1373
  TOX_MAX_CUSTOM_PACKET_SIZE = 1373;

  (**
   * The number of bytes in a hash generated by tox_hash.
   *)
  //#define TOX_HASH_LENGTH                32
  TOX_HASH_LENGTH = 32;

  (**
   * The number of bytes in a file id.
   *)
  //#define TOX_FILE_ID_LENGTH             32
  TOX_FILE_ID_LENGTH = 32;

  (**
   * Maximum file name length for file transfers.
   *)
  //#define TOX_MAX_FILENAME_LENGTH        255
  TOX_MAX_FILENAME_LENGTH = 255;



(*******************************************************************************
 *
 * :: Global enumerations
 *
 ******************************************************************************)
type


(**
 * Represents the possible statuses a client can have.
 *)
//typedef enum TOX_USER_STATUS {
//
//    /**
//     * User is online and available.
//     */
//    TOX_USER_STATUS_NONE,
//
//    /**
//     * User is away. Clients can set this e.g. after a user defined
//     * inactivity time.
//     */
//    TOX_USER_STATUS_AWAY,
//
//    /**
//     * User is busy. Signals to other clients that this client does not
//     * currently wish to communicate.
//     */
//    TOX_USER_STATUS_BUSY,
//
//} TOX_USER_STATUS;

  PToxUserStatus = ^TToxUserStatus;
  TToxUserStatus = (
    // User is online and available.
    usNone,

    // User is away. Clients can set this e.g. after a user defined
    // inactivity time.
    usAway,

    // User is busy. Signals to other clients that this client does not
    // currently wish to communicate.
    usBusy
  );

(**
 * Represents message types for tox_friend_send_message and group chat
 * messages.
 *)
//typedef enum TOX_MESSAGE_TYPE {
//
//    /**
//     * Normal text message. Similar to PRIVMSG on IRC.
//     */
//    TOX_MESSAGE_TYPE_NORMAL,
//
//    /**
//     * A message describing an user action. This is similar to /me (CTCP ACTION)
//     * on IRC.
//     */
//    TOX_MESSAGE_TYPE_ACTION,
//
//} TOX_MESSAGE_TYPE;

  TToxMessageType = (
    // Normal text message. Similar to PRIVMSG on IRC.
    mtNormal,

    // A message describing an user action. This is similar to /me (CTCP ACTION)
    // on IRC.
    mtAction
  );



(*******************************************************************************
 *
 * :: Startup options
 *
 ******************************************************************************)



(**
 * Type of proxy used to connect to TCP relays.
 *)
//typedef enum TOX_PROXY_TYPE {
//
//    /**
//     * Don't use a proxy.
//     */
//    TOX_PROXY_TYPE_NONE,
//
//    /**
//     * HTTP proxy using CONNECT.
//     */
//    TOX_PROXY_TYPE_HTTP,
//
//    /**
//     * SOCKS proxy for simple socket pipes.
//     */
//    TOX_PROXY_TYPE_SOCKS5,
//
//} TOX_PROXY_TYPE;

  PToxProxyType = ^TToxProxyType;
  TToxProxyType = (
    // Don't use a proxy.
    ptNone,

    // HTTP proxy using CONNECT.
    ptHttp,

    // SOCKS proxy for simple socket pipes.
    ptSocks5
  );


(**
 * Type of savedata to create the Tox instance from.
 *)
//typedef enum TOX_SAVEDATA_TYPE {
//
//    /**
//     * No savedata.
//     */
//    TOX_SAVEDATA_TYPE_NONE,
//
//    /**
//     * Savedata is one that was obtained from tox_get_savedata
//     */
//    TOX_SAVEDATA_TYPE_TOX_SAVE,
//
//    /**
//     * Savedata is a secret key of length TOX_SECRET_KEY_SIZE
//     */
//    TOX_SAVEDATA_TYPE_SECRET_KEY,
//
//} TOX_SAVEDATA_TYPE;
  PToxSavedataType = ^TToxSavedataType;
  TToxSavedataType = (
    // No savedata.
    stNone,

    // Savedata is one that was obtained from tox_get_savedata
    stToxSave,

    //  Savedata is a secret key of length TOX_SECRET_KEY_SIZE
    stSecretKey
  );


(**
 * This struct contains all the startup options for Tox. You can either allocate
 * this object yourself, and pass it to tox_options_default, or call
 * tox_options_new to get a new default options object.
 *)
//struct Tox_Options {
//
//    /**
//     * The type of socket to create.
//     *
//     * If this is set to false, an IPv4 socket is created, which subsequently
//     * only allows IPv4 communication.
//     * If it is set to true, an IPv6 socket is created, allowing both IPv4 and
//     * IPv6 communication.
//     */
//    bool ipv6_enabled;
//
//
//    /**
//     * Enable the use of UDP communication when available.
//     *
//     * Setting this to false will force Tox to use TCP only. Communications will
//     * need to be relayed through a TCP relay node, potentially slowing them down.
//     * Disabling UDP support is necessary when using anonymous proxies or Tor.
//     */
//    bool udp_enabled;
//
//
//    /**
//     * Pass communications through a proxy.
//     */
//    TOX_PROXY_TYPE proxy_type;
//
//
//    /**
//     * The IP address or DNS name of the proxy to be used.
//     *
//     * If used, this must be non-NULL and be a valid DNS name. The name must not
//     * exceed 255 characters, and be in a NUL-terminated C string format
//     * (255 chars + 1 NUL byte).
//     *
//     * This member is ignored (it can be NULL) if proxy_type is TOX_PROXY_TYPE_NONE.
//     */
//    const char *proxy_host;
//
//
//    /**
//     * The port to use to connect to the proxy server.
//     *
//     * Ports must be in the range (1, 65535). The value is ignored if
//     * proxy_type is TOX_PROXY_TYPE_NONE.
//     */
//    uint16_t proxy_port;
//
//
//    /**
//     * The start port of the inclusive port range to attempt to use.
//     *
//     * If both start_port and end_port are 0, the default port range will be
//     * used: [33445, 33545].
//     *
//     * If either start_port or end_port is 0 while the other is non-zero, the
//     * non-zero port will be the only port in the range.
//     *
//     * Having start_port > end_port will yield the same behavior as if start_port
//     * and end_port were swapped.
//     */
//    uint16_t start_port;
//
//
//    /**
//     * The end port of the inclusive port range to attempt to use.
//     */
//    uint16_t end_port;
//
//
//    /**
//     * The port to use for the TCP server (relay). If 0, the TCP server is
//     * disabled.
//     *
//     * Enabling it is not required for Tox to function properly.
//     *
//     * When enabled, your Tox instance can act as a TCP relay for other Tox
//     * instance. This leads to increased traffic, thus when writing a client
//     * it is recommended to enable TCP server only if the user has an option
//     * to disable it.
//     */
//    uint16_t tcp_port;
//
//    /**
//     * The type of savedata to load from.
//     */
//    TOX_SAVEDATA_TYPE savedata_type;
//
//
//    /**
//     * The savedata.
//     */
//    const uint8_t *savedata_data;
//
//
//    /**
//     * The length of the savedata.
//     */
//    size_t savedata_length;
//
//};

  PToxOptions = ^TToxOptions;
  TToxOptions = record
    (**
     * The type of socket to create.
     *
     * If this is set to false, an IPv4 socket is created, which subsequently
     * only allows IPv4 communication.
     * If it is set to true, an IPv6 socket is created, allowing both IPv4 and
     * IPv6 communication.
     *)
    ipv6_enabled: Boolean;


    (**
     * Enable the use of UDP communication when available.
     *
     * Setting this to false will force Tox to use TCP only. Communications will
     * need to be relayed through a TCP relay node, potentially slowing them down.
     * Disabling UDP support is necessary when using anonymous proxies or Tor.
     *)
    udp_enabled: Boolean;


    (**
     * Pass communications through a proxy.
     *)
    proxy_type: TToxProxyType;


    (**
     * The IP address or DNS name of the proxy to be used.
     *
     * If used, this must be non-NULL and be a valid DNS name. The name must not
     * exceed 255 characters, and be in a NUL-terminated C string format
     * (255 chars + 1 NUL byte).
     *
     * This member is ignored (it can be NULL) if proxy_type is TOX_PROXY_TYPE_NONE.
     *)
    proxy_host: PAnsiChar;


    (**
     * The port to use to connect to the proxy server.
     *
     * Ports must be in the range (1, 65535). The value is ignored if
     * proxy_type is TOX_PROXY_TYPE_NONE.
     *)
    proxy_port: Word;


    (**
     * The start port of the inclusive port range to attempt to use.
     *
     * If both start_port and end_port are 0, the default port range will be
     * used: [33445, 33545].
     *
     * If either start_port or end_port is 0 while the other is non-zero, the
     * non-zero port will be the only port in the range.
     *
     * Having start_port > end_port will yield the same behavior as if start_port
     * and end_port were swapped.
     *)
    start_port: Word;


    (**
     * The end port of the inclusive port range to attempt to use.
     *)
    end_port: Word;


    (**
     * The port to use for the TCP server (relay). If 0, the TCP server is
     * disabled.
     *
     * Enabling it is not required for Tox to function properly.
     *
     * When enabled, your Tox instance can act as a TCP relay for other Tox
     * instance. This leads to increased traffic, thus when writing a client
     * it is recommended to enable TCP server only if the user has an option
     * to disable it.
     *)
    tcp_port: Word;


    (**
     * The type of savedata to load from.
     *)
    savedata_type: TToxSavedataType;


    (**
     * The savedata.
     *)
    savedata_data: PByte;



    (**
     * The length of the savedata.
     *)
    savedata_length: NativeUInt;
  end;


(**
 * Initialises a Tox_Options object with the default options.
 *
 * The result of this function is independent of the original options. All
 * values will be overwritten, no values will be read (so it is permissible
 * to pass an uninitialised object).
 *
 * If options is NULL, this function has no effect.
 *
 * @param options An options object to be filled with default options.
 *)
//void tox_options_default(struct Tox_Options *options);
procedure tox_options_default(options: PToxOptions); cdecl; external TOX_LIBRARY;

//typedef enum TOX_ERR_OPTIONS_NEW {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_OPTIONS_NEW_OK,
//
//    /**
//     * The function failed to allocate enough memory for the options struct.
//     */
//    TOX_ERR_OPTIONS_NEW_MALLOC,
//
//} TOX_ERR_OPTIONS_NEW;
type
  TToxErrOptionsNew = (eonOk, eonMalloc);

(**
 * Allocates a new Tox_Options object and initialises it with the default
 * options. This function can be used to preserve long term ABI compatibility by
 * giving the responsibility of allocation and deallocation to the Tox library.
 *
 * Objects returned from this function must be freed using the tox_options_free
 * function.
 *
 * @return A new Tox_Options object with default options or NULL on failure.
 *)
//struct Tox_Options *tox_options_new(TOX_ERR_OPTIONS_NEW *error);
function tox_options_new(var error: TToxErrOptionsNew): PToxOptions; cdecl; external TOX_LIBRARY;

(**
 * Releases all resources associated with an options objects.
 *
 * Passing a pointer that was not returned by tox_options_new results in
 * undefined behaviour.
 *)
//void tox_options_free(struct Tox_Options *options);
procedure tox_options_free(options: PToxOptions); cdecl; external TOX_LIBRARY;


(*******************************************************************************
 *
 * :: Creation and destruction
 *
 ******************************************************************************)

//typedef enum TOX_ERR_NEW {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_NEW_OK,
//
//    /**
//     * One of the arguments to the function was NULL when it was not expected.
//     */
//    TOX_ERR_NEW_NULL,
//
//    /**
//     * The function was unable to allocate enough memory to store the internal
//     * structures for the Tox object.
//     */
//    TOX_ERR_NEW_MALLOC,
//
//    /**
//     * The function was unable to bind to a port. This may mean that all ports
//     * have already been bound, e.g. by other Tox instances, or it may mean
//     * a permission error. You may be able to gather more information from errno.
//     */
//    TOX_ERR_NEW_PORT_ALLOC,
//
//    /**
//     * proxy_type was invalid.
//     */
//    TOX_ERR_NEW_PROXY_BAD_TYPE,
//
//    /**
//     * proxy_type was valid but the proxy_host passed had an invalid format
//     * or was NULL.
//     */
//    TOX_ERR_NEW_PROXY_BAD_HOST,
//
//    /**
//     * proxy_type was valid, but the proxy_port was invalid.
//     */
//    TOX_ERR_NEW_PROXY_BAD_PORT,
//
//    /**
//     * The proxy address passed could not be resolved.
//     */
//    TOX_ERR_NEW_PROXY_NOT_FOUND,
//
//    /**
//     * The byte array to be loaded contained an encrypted save.
//     */
//    TOX_ERR_NEW_LOAD_ENCRYPTED,
//
//    /**
//     * The data format was invalid. This can happen when loading data that was
//     * saved by an older version of Tox, or when the data has been corrupted.
//     * When loading from badly formatted data, some data may have been loaded,
//     * and the rest is discarded. Passing an invalid length parameter also
//     * causes this error.
//     */
//    TOX_ERR_NEW_LOAD_BAD_FORMAT,
//
//} TOX_ERR_NEW;

type
  PToxErrNew = ^TToxErrNew;
  TToxErrNew = (
    (**
     * The function returned successfully.
     *)
    enOk,

    (**
     * One of the arguments to the function was NULL when it was not expected.
     *)
    enNULL,

    (**
     * The function was unable to allocate enough memory to store the internal
     * structures for the Tox object.
     *)
    enMalloc,

    (**
     * The function was unable to bind to a port. This may mean that all ports
     * have already been bound, e.g. by other Tox instances, or it may mean
     * a permission error. You may be able to gather more information from errno.
     *)
    enPortAlloc,

    (**
     * proxy_type was invalid.
     *)
    enProxyBadType,

    (**
     * proxy_type was valid but the proxy_host passed had an invalid format
     * or was NULL.
     *)
    enProxyBadHost,

    (**
     * proxy_type was valid, but the proxy_port was invalid.
     *)
    enProxyBadPort,

    (**
     * The proxy address passed could not be resolved.
     *)
    enProxyNotFound,

    (**
     * The byte array to be loaded contained an encrypted save.
     *)
    enLoadEncrypted,

    (**
     * The data format was invalid. This can happen when loading data that was
     * saved by an older version of Tox, or when the data has been corrupted.
     * When loading from badly formatted data, some data may have been loaded,
     * and the rest is discarded. Passing an invalid length parameter also
     * causes this error.
     *)
    enLoadBadFormat
  );


(**
 * @brief Creates and initialises a new Tox instance with the options passed.
 *
 * This function will bring the instance into a valid state. Running the event
 * loop with a new instance will operate correctly.
 *
 * If loading failed or succeeded only partially, the new or partially loaded
 * instance is returned and an error code is set.
 *
 * @param options An options object as described above. If this parameter is
 *   NULL, the default options are used.
 *
 * @see tox_iterate for the event loop.
 *
 * @return A new Tox instance pointer on success or NULL on failure.
 *)
//Tox *tox_new(const struct Tox_Options *options, TOX_ERR_NEW *error);
function tox_new(options: PToxOptions; error: PToxErrNew): TTox; cdecl; external TOX_LIBRARY;

(**
 * Releases all resources associated with the Tox instance and disconnects from
 * the network.
 *
 * After calling this function, the Tox pointer becomes invalid. No other
 * functions can be called, and the pointer value can no longer be read.
 *)
//void tox_kill(Tox *tox);
procedure tox_kill(tox: TTox); cdecl; external TOX_LIBRARY;

(**
 * Calculates the number of bytes required to store the tox instance with
 * tox_get_savedata. This function cannot fail. The result is always greater than 0.
 *
 * @see threading for concurrency implications.
 *)
//size_t tox_get_savedata_size(const Tox *tox);
function tox_get_savedata_size(const tox: TTox): NativeUInt; cdecl; external TOX_LIBRARY;

(**
 * Store all information associated with the tox instance to a byte array.
 *
 * @param data A memory region large enough to store the tox instance data.
 *   Call tox_get_savedata_size to find the number of bytes required. If this parameter
 *   is NULL, this function has no effect.
 *)
//void tox_get_savedata(const Tox *tox, uint8_t *savedata);
procedure tox_get_savedata(const tox: TTox; savedata: PByte); cdecl; external TOX_LIBRARY;
//todo: проверить tox_get_savedata


(*******************************************************************************
 *
 * :: Connection lifecycle and event loop
 *
 ******************************************************************************)


//typedef enum TOX_ERR_BOOTSTRAP {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_BOOTSTRAP_OK,
//
//    /**
//     * One of the arguments to the function was NULL when it was not expected.
//     */
//    TOX_ERR_BOOTSTRAP_NULL,
//
//    /**
//     * The address could not be resolved to an IP address, or the IP address
//     * passed was invalid.
//     */
//    TOX_ERR_BOOTSTRAP_BAD_HOST,
//
//    /**
//     * The port passed was invalid. The valid port range is (1, 65535).
//     */
//    TOX_ERR_BOOTSTRAP_BAD_PORT,
//
//} TOX_ERR_BOOTSTRAP;
type
  TToxErrBootstrap = (
    (**
     * The function returned successfully.
     *)
    ebOk,

    (**
     * One of the arguments to the function was NULL when it was not expected.
     *)
    ebNULL,

    (**
     * The address could not be resolved to an IP address, or the IP address
     * passed was invalid.
     *)
    ebBadHost,

    (**
     * The port passed was invalid. The valid port range is (1, 65535).
     *)
    ebBadPort
  );

(**
 * Sends a "get nodes" request to the given bootstrap node with IP, port, and
 * public key to setup connections.
 *
 * This function will attempt to connect to the node using UDP. You must use
 * this function even if Tox_Options.udp_enabled was set to false.
 *
 * @param address The hostname or IP address (IPv4 or IPv6) of the node.
 * @param port The port on the host on which the bootstrap Tox instance is
 *   listening.
 * @param public_key The long term public key of the bootstrap node
 *   (TOX_PUBLIC_KEY_SIZE bytes).
 * @return true on success.
 *)
//bool tox_bootstrap(Tox *tox, const char *address, uint16_t port, const uint8_t *public_key, TOX_ERR_BOOTSTRAP *error);
function tox_bootstrap(tox: TTox; address: PAnsiChar; port: Word;
  const public_key: PByte; var error: TToxErrBootstrap): Boolean; cdecl; external TOX_LIBRARY;


(**
 * Adds additional host:port pair as TCP relay.
 *
 * This function can be used to initiate TCP connections to different ports on
 * the same bootstrap node, or to add TCP relays without using them as
 * bootstrap nodes.
 *
 * @param address The hostname or IP address (IPv4 or IPv6) of the TCP relay.
 * @param port The port on the host on which the TCP relay is listening.
 * @param public_key The long term public key of the TCP relay
 *   (TOX_PUBLIC_KEY_SIZE bytes).
 * @return true on success.
 *)
//bool tox_add_tcp_relay(Tox *tox, const char *address, uint16_t port, const uint8_t *public_key,
//                       TOX_ERR_BOOTSTRAP *error);
function tox_add_tcp_relay(tox: TTox; address: PAnsiChar; port: Word;
  const public_key: PByte; var error: TToxErrBootstrap): Boolean; cdecl; external TOX_LIBRARY;

(**
 * Protocols that can be used to connect to the network or friends.
 *)
//typedef enum TOX_CONNECTION {
//
//    /**
//     * There is no connection. This instance, or the friend the state change is
//     * about, is now offline.
//     */
//    TOX_CONNECTION_NONE,
//
//    /**
//     * A TCP connection has been established. For the own instance, this means it
//     * is connected through a TCP relay, only. For a friend, this means that the
//     * connection to that particular friend goes through a TCP relay.
//     */
//    TOX_CONNECTION_TCP,
//
//    /**
//     * A UDP connection has been established. For the own instance, this means it
//     * is able to send UDP packets to DHT nodes, but may still be connected to
//     * a TCP relay. For a friend, this means that the connection to that
//     * particular friend was built using direct UDP packets.
//     */
//    TOX_CONNECTION_UDP,
//
//} TOX_CONNECTION;

type
  TToxConnection = (
    (**
     * There is no connection. This instance, or the friend the state change is
     * about, is now offline.
     *)
    tcNone,

    (**
     * A TCP connection has been established. For the own instance, this means it
     * is connected through a TCP relay, only. For a friend, this means that the
     * connection to that particular friend goes through a TCP relay.
     *)
    tcTCP,

    (**
     * A UDP connection has been established. For the own instance, this means it
     * is able to send UDP packets to DHT nodes, but may still be connected to
     * a TCP relay. For a friend, this means that the connection to that
     * particular friend was built using direct UDP packets.
     *)
    tcUDP
  );

(**
 * Return whether we are connected to the DHT. The return value is equal to the
 * last value received through the `self_connection_status` callback.
 *)
//TOX_CONNECTION tox_self_get_connection_status(const Tox *tox);
function tox_self_get_connection_status(const tox: TTox): TToxConnection; cdecl; external TOX_LIBRARY;

(**
 * @param connection_status Whether we are connected to the DHT.
 *)
//typedef void tox_self_connection_status_cb(Tox *tox, TOX_CONNECTION connection_status, void *user_data);
type
  Ttox_self_connection_status_cb = procedure(tox: TTox; connection_status: TToxConnection;
    user_data: Pointer); cdecl;

(**
 * Set the callback for the `self_connection_status` event. Pass NULL to unset.
 *
 * This event is triggered whenever there is a change in the DHT connection
 * state. When disconnected, a client may choose to call tox_bootstrap again, to
 * reconnect to the DHT. Note that this state may frequently change for short
 * amounts of time. Clients should therefore not immediately bootstrap on
 * receiving a disconnect.
 *
 * TODO: how long should a client wait before bootstrapping again?
 *)
//void tox_callback_self_connection_status(Tox *tox, tox_self_connection_status_cb *callback, void *user_data);
procedure tox_callback_self_connection_status(Tox: TTox; callback: Ttox_self_connection_status_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;

(**
 * Return the time in milliseconds before tox_iterate() should be called again
 * for optimal performance.
 *)
//uint32_t tox_iteration_interval(const Tox *tox);
function tox_iteration_interval(const tox: TTox): Cardinal; cdecl; external TOX_LIBRARY;

(**
 * The main loop that needs to be run in intervals of tox_iteration_interval()
 * milliseconds.
 *)
//void tox_iterate(Tox *tox);
procedure tox_iterate(tox: TTox); cdecl; external TOX_LIBRARY;


(*******************************************************************************
 *
 * :: Internal client information (Tox address/id)
 *
 ******************************************************************************)



(**
 * Writes the Tox friend address of the client to a byte array. The address is
 * not in human-readable format. If a client wants to display the address,
 * formatting is required.
 *
 * @param address A memory region of at least TOX_ADDRESS_SIZE bytes. If this
 *   parameter is NULL, this function has no effect.
 * @see TOX_ADDRESS_SIZE for the address format.
 *)
//void tox_self_get_address(const Tox *tox, uint8_t *address);
procedure tox_self_get_address(const tox: TTox; address: PByte); cdecl; external TOX_LIBRARY;


(**
 * Set the 4-byte nospam part of the address.
 *
 * @param nospam Any 32 bit unsigned integer.
 *)
//void tox_self_set_nospam(Tox *tox, uint32_t nospam);
procedure tox_self_set_nospam(tox: TTox; nospam: Cardinal); cdecl; external TOX_LIBRARY;

(**
 * Get the 4-byte nospam part of the address.
 *)
//uint32_t tox_self_get_nospam(const Tox *tox);
function tox_self_get_nospam(const tox: TTox): Cardinal; cdecl; external TOX_LIBRARY;

(**
 * Copy the Tox Public Key (long term) from the Tox object.
 *
 * @param public_key A memory region of at least TOX_PUBLIC_KEY_SIZE bytes. If
 *   this parameter is NULL, this function has no effect.
 *)
//void tox_self_get_public_key(const Tox *tox, uint8_t *public_key);
procedure tox_self_get_public_key(const tox: TTox; public_key: PByte); cdecl; external TOX_LIBRARY;

(**
 * Copy the Tox Secret Key from the Tox object.
 *
 * @param secret_key A memory region of at least TOX_SECRET_KEY_SIZE bytes. If
 *   this parameter is NULL, this function has no effect.
 *)
//void tox_self_get_secret_key(const Tox *tox, uint8_t *secret_key);
procedure tox_self_get_secret_key(const tox: TTox; secret_key: PByte); cdecl; external TOX_LIBRARY;



(*******************************************************************************
 *
 * :: User-visible client information (nickname/status)
 *
 ******************************************************************************)



(**
 * Common error codes for all functions that set a piece of user-visible
 * client information.
 *)
//typedef enum TOX_ERR_SET_INFO {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_SET_INFO_OK,
//
//    /**
//     * One of the arguments to the function was NULL when it was not expected.
//     */
//    TOX_ERR_SET_INFO_NULL,
//
//    /**
//     * Information length exceeded maximum permissible size.
//     */
//    TOX_ERR_SET_INFO_TOO_LONG,
//
//} TOX_ERR_SET_INFO;
type
  TToxErrSetInfo = (
    (**
     * The function returned successfully.
     *)
    siOk,

    (**
     * One of the arguments to the function was NULL when it was not expected.
     *)
    siNULL,

    (**
     * Information length exceeded maximum permissible size.
     *)
    siTooLong
  );

(**
 * Set the nickname for the Tox client.
 *
 * Nickname length cannot exceed TOX_MAX_NAME_LENGTH. If length is 0, the name
 * parameter is ignored (it can be NULL), and the nickname is set back to empty.
 *
 * @param name A byte array containing the new nickname.
 * @param length The size of the name byte array.
 *
 * @return true on success.
 *)
//bool tox_self_set_name(Tox *tox, const uint8_t *name, size_t length, TOX_ERR_SET_INFO *error);
function tox_self_set_name(tox: TTox; const name: PByte; length: NativeUInt;
  var error: TToxErrSetInfo): Boolean; cdecl; external TOX_LIBRARY;

(**
 * Return the length of the current nickname as passed to tox_self_set_name.
 *
 * If no nickname was set before calling this function, the name is empty,
 * and this function returns 0.
 *
 * @see threading for concurrency implications.
 *)
//size_t tox_self_get_name_size(const Tox *tox);
function tox_self_get_name_size(const tox: TTox): NativeUInt; cdecl; external TOX_LIBRARY;

(**
 * Write the nickname set by tox_self_set_name to a byte array.
 *
 * If no nickname was set before calling this function, the name is empty,
 * and this function has no effect.
 *
 * Call tox_self_get_name_size to find out how much memory to allocate for
 * the result.
 *
 * @param name A valid memory location large enough to hold the nickname.
 *   If this parameter is NULL, the function has no effect.
 *)
//void tox_self_get_name(const Tox *tox, uint8_t *name);
procedure tox_self_get_name(const tox: TTox; name: PByte); cdecl; external TOX_LIBRARY;

(**
 * Set the client's status message.
 *
 * Status message length cannot exceed TOX_MAX_STATUS_MESSAGE_LENGTH. If
 * length is 0, the status parameter is ignored (it can be NULL), and the
 * user status is set back to empty.
 *)
//bool tox_self_set_status_message(Tox *tox, const uint8_t *status_message, size_t length, TOX_ERR_SET_INFO *error);
function tox_self_set_status_message(tox: TTox; const status_message: PByte;
  length: NativeUInt; var error: TToxErrSetInfo): Boolean; cdecl; external TOX_LIBRARY;

(**
 * Return the length of the current status message as passed to tox_self_set_status_message.
 *
 * If no status message was set before calling this function, the status
 * is empty, and this function returns 0.
 *
 * @see threading for concurrency implications.
 *)
//size_t tox_self_get_status_message_size(const Tox *tox);
function tox_self_get_status_message_size(const tox: TTox): NativeUInt; cdecl; external TOX_LIBRARY;

(**
 * Write the status message set by tox_self_set_status_message to a byte array.
 *
 * If no status message was set before calling this function, the status is
 * empty, and this function has no effect.
 *
 * Call tox_self_get_status_message_size to find out how much memory to allocate for
 * the result.
 *
 * @param status A valid memory location large enough to hold the status message.
 *   If this parameter is NULL, the function has no effect.
 *)
//void tox_self_get_status_message(const Tox *tox, uint8_t *status_message);
procedure tox_self_get_status_message(const tox: TTox;
  status_message: PByte); cdecl; external TOX_LIBRARY;

(**
 * Set the client's user status.
 *
 * @param user_status One of the user statuses listed in the enumeration above.
 *)
//void tox_self_set_status(Tox *tox, TOX_USER_STATUS status);
procedure tox_self_set_status(tox: TTox; status: TToxUserStatus); cdecl; external TOX_LIBRARY;

(**
 * Returns the client's user status.
 *)
//TOX_USER_STATUS tox_self_get_status(const Tox *tox);
function tox_self_get_status(const tox: TTox): TToxUserStatus; cdecl; external TOX_LIBRARY;



(*******************************************************************************
 *
 * :: Friend list management
 *
 ******************************************************************************)



//typedef enum TOX_ERR_FRIEND_ADD {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_FRIEND_ADD_OK,
//
//    /**
//     * One of the arguments to the function was NULL when it was not expected.
//     */
//    TOX_ERR_FRIEND_ADD_NULL,
//
//    /**
//     * The length of the friend request message exceeded
//     * TOX_MAX_FRIEND_REQUEST_LENGTH.
//     */
//    TOX_ERR_FRIEND_ADD_TOO_LONG,
//
//    /**
//     * The friend request message was empty. This, and the TOO_LONG code will
//     * never be returned from tox_friend_add_norequest.
//     */
//    TOX_ERR_FRIEND_ADD_NO_MESSAGE,
//
//    /**
//     * The friend address belongs to the sending client.
//     */
//    TOX_ERR_FRIEND_ADD_OWN_KEY,
//
//    /**
//     * A friend request has already been sent, or the address belongs to a friend
//     * that is already on the friend list.
//     */
//    TOX_ERR_FRIEND_ADD_ALREADY_SENT,
//
//    /**
//     * The friend address checksum failed.
//     */
//    TOX_ERR_FRIEND_ADD_BAD_CHECKSUM,
//
//    /**
//     * The friend was already there, but the nospam value was different.
//     */
//    TOX_ERR_FRIEND_ADD_SET_NEW_NOSPAM,
//
//    /**
//     * A memory allocation failed when trying to increase the friend list size.
//     */
//    TOX_ERR_FRIEND_ADD_MALLOC,
//
//} TOX_ERR_FRIEND_ADD;
type
  TToxErrFriendAdd = (
    (**
     * The function returned successfully.
     *)
    faOk,

    (**
     * One of the arguments to the function was NULL when it was not expected.
     *)
    faNULL,

    (**
     * The length of the friend request message exceeded
     * TOX_MAX_FRIEND_REQUEST_LENGTH.
     *)
    faTooLong,

    (**
     * The friend request message was empty. This, and the TOO_LONG code will
     * never be returned from tox_friend_add_norequest.
     *)
    faNoMessage,

    (**
     * The friend address belongs to the sending client.
     *)
    faOwnKey,

    (**
     * A friend request has already been sent, or the address belongs to a friend
     * that is already on the friend list.
     *)
    faAlreadySent,

    (**
     * The friend address checksum failed.
     *)
    faBadChecksum,

    (**
     * The friend was already there, but the nospam value was different.
     *)
    faSetNewNospam,

    (**
     * A memory allocation failed when trying to increase the friend list size.
     *)
    faMalloc
  );


(**
 * Add a friend to the friend list and send a friend request.
 *
 * A friend request message must be at least 1 byte long and at most
 * TOX_MAX_FRIEND_REQUEST_LENGTH.
 *
 * Friend numbers are unique identifiers used in all functions that operate on
 * friends. Once added, a friend number is stable for the lifetime of the Tox
 * object. After saving the state and reloading it, the friend numbers may not
 * be the same as before. Deleting a friend creates a gap in the friend number
 * set, which is filled by the next adding of a friend. Any pattern in friend
 * numbers should not be relied on.
 *
 * If more than INT32_MAX friends are added, this function causes undefined
 * behaviour.
 *
 * @param address The address of the friend (returned by tox_self_get_address of
 *   the friend you wish to add) it must be TOX_ADDRESS_SIZE bytes.
 * @param message The message that will be sent along with the friend request.
 * @param length The length of the data byte array.
 *
 * @return the friend number on success, UINT32_MAX on failure.
 *)
//uint32_t tox_friend_add(Tox *tox, const uint8_t *address, const uint8_t *message, size_t length,
//                        TOX_ERR_FRIEND_ADD *error);
function tox_friend_add(tox: TTox; address: PByte; const text_message: PByte;
  length: NativeUInt; var error: TToxErrFriendAdd): Cardinal; cdecl; external TOX_LIBRARY;

(**
 * Add a friend without sending a friend request.
 *
 * This function is used to add a friend in response to a friend request. If the
 * client receives a friend request, it can be reasonably sure that the other
 * client added this client as a friend, eliminating the need for a friend
 * request.
 *
 * This function is also useful in a situation where both instances are
 * controlled by the same entity, so that this entity can perform the mutual
 * friend adding. In this case, there is no need for a friend request, either.
 *
 * @param public_key A byte array of length TOX_PUBLIC_KEY_SIZE containing the
 *   Public Key (not the Address) of the friend to add.
 *
 * @return the friend number on success, UINT32_MAX on failure.
 * @see tox_friend_add for a more detailed description of friend numbers.
 *)
//uint32_t tox_friend_add_norequest(Tox *tox, const uint8_t *public_key, TOX_ERR_FRIEND_ADD *error);
function tox_friend_add_norequest(tox: TTox; const public_key: PByte;
  var error: TToxErrFriendAdd): Cardinal; cdecl; external TOX_LIBRARY;


//typedef enum TOX_ERR_FRIEND_DELETE {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_FRIEND_DELETE_OK,
//
//    /**
//     * There was no friend with the given friend number. No friends were deleted.
//     */
//    TOX_ERR_FRIEND_DELETE_FRIEND_NOT_FOUND,
//
//} TOX_ERR_FRIEND_DELETE;
type
  TToxErrFriendDelete = (
    (**
     * The function returned successfully.
     *)
    fdOk,

    (**
     * There was no friend with the given friend number. No friends were deleted.
     *)
    fdFriendNotFound
  );

(**
 * Remove a friend from the friend list.
 *
 * This does not notify the friend of their deletion. After calling this
 * function, this client will appear offline to the friend and no communication
 * can occur between the two.
 *
 * @param friend_number Friend number for the friend to be deleted.
 *
 * @return true on success.
 *)
//bool tox_friend_delete(Tox *tox, uint32_t friend_number, TOX_ERR_FRIEND_DELETE *error);
function tox_friend_delete(tox: TTox; friend_number: Cardinal;
  var error: TToxErrFriendDelete): Boolean; cdecl; external TOX_LIBRARY;



(*******************************************************************************
 *
 * :: Friend list queries
 *
 ******************************************************************************)



//typedef enum TOX_ERR_FRIEND_BY_PUBLIC_KEY {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_FRIEND_BY_PUBLIC_KEY_OK,
//
//    /**
//     * One of the arguments to the function was NULL when it was not expected.
//     */
//    TOX_ERR_FRIEND_BY_PUBLIC_KEY_NULL,
//
//    /**
//     * No friend with the given Public Key exists on the friend list.
//     */
//    TOX_ERR_FRIEND_BY_PUBLIC_KEY_NOT_FOUND,
//
//} TOX_ERR_FRIEND_BY_PUBLIC_KEY;
type
  TToxErrFriendByPublicKey = (
    (**
     * The function returned successfully.
     *)
    fkOk,

    (**
     * One of the arguments to the function was NULL when it was not expected.
     *)
    fkNULL,

    (**
     * No friend with the given Public Key exists on the friend list.
     *)
    fkNotFound
  );

(**
 * Return the friend number associated with that Public Key.
 *
 * @return the friend number on success, UINT32_MAX on failure.
 * @param public_key A byte array containing the Public Key.
 *)
//uint32_t tox_friend_by_public_key(const Tox *tox, const uint8_t *public_key, TOX_ERR_FRIEND_BY_PUBLIC_KEY *error);
function tox_friend_by_public_key(const tox: TTox; const public_key: PByte;
  var error: TToxErrFriendByPublicKey): Cardinal; cdecl; external TOX_LIBRARY;

(**
 * Checks if a friend with the given friend number exists and returns true if
 * it does.
 *)
//bool tox_friend_exists(const Tox *tox, uint32_t friend_number);
function tox_friend_exists(const tox: TTox; friend_number: Cardinal): Boolean; cdecl; external TOX_LIBRARY;

(**
 * Return the number of friends on the friend list.
 *
 * This function can be used to determine how much memory to allocate for
 * tox_self_get_friend_list.
 *)
//size_t tox_self_get_friend_list_size(const Tox *tox);
function tox_self_get_friend_list_size(const tox: TTox): NativeUInt; cdecl; external TOX_LIBRARY;

(**
 * Copy a list of valid friend numbers into an array.
 *
 * Call tox_self_get_friend_list_size to determine the number of elements to allocate.
 *
 * @param list A memory region with enough space to hold the friend list. If
 *   this parameter is NULL, this function has no effect.
 *)
//void tox_self_get_friend_list(const Tox *tox, uint32_t *friend_list);
procedure tox_self_get_friend_list(tox: TTox; friend_list: PCardinal); cdecl; external TOX_LIBRARY;
//todo: проверить tox_self_get_friend_list!!!

//typedef enum TOX_ERR_FRIEND_GET_PUBLIC_KEY {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_FRIEND_GET_PUBLIC_KEY_OK,
//
//    /**
//     * No friend with the given number exists on the friend list.
//     */
//    TOX_ERR_FRIEND_GET_PUBLIC_KEY_FRIEND_NOT_FOUND,
//
//} TOX_ERR_FRIEND_GET_PUBLIC_KEY;
type
  TToxErrFriendGetPublicKey = (
    (**
     * The function returned successfully.
     *)
    fgkOk,

    (**
     * No friend with the given number exists on the friend list.
     *)
    fgkFriendNotFound
  );

(**
 * Copies the Public Key associated with a given friend number to a byte array.
 *
 * @param friend_number The friend number you want the Public Key of.
 * @param public_key A memory region of at least TOX_PUBLIC_KEY_SIZE bytes. If
 *   this parameter is NULL, this function has no effect.
 *
 * @return true on success.
 *)
//bool tox_friend_get_public_key(const Tox *tox, uint32_t friend_number, uint8_t *public_key,
//                               TOX_ERR_FRIEND_GET_PUBLIC_KEY *error);
function tox_friend_get_public_key(const tox: TTox; friend_number: Cardinal;
  public_key: PByte; var error: TToxErrFriendGetPublicKey): Boolean; cdecl; external TOX_LIBRARY;

//typedef enum TOX_ERR_FRIEND_GET_LAST_ONLINE {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_FRIEND_GET_LAST_ONLINE_OK,
//
//    /**
//     * No friend with the given number exists on the friend list.
//     */
//    TOX_ERR_FRIEND_GET_LAST_ONLINE_FRIEND_NOT_FOUND,
//
//} TOX_ERR_FRIEND_GET_LAST_ONLINE;
type
  TToxErrFriendGetLastOnline = (
    (**
     * The function returned successfully.
     *)
    fglOK,

    (**
     * No friend with the given number exists on the friend list.
     *)
    fglFriendNotFound
  );

(**
 * Return a unix-time timestamp of the last time the friend associated with a given
 * friend number was seen online. This function will return UINT64_MAX on error.
 *
 * @param friend_number The friend number you want to query.
 *)
//uint64_t tox_friend_get_last_online(const Tox *tox, uint32_t friend_number, TOX_ERR_FRIEND_GET_LAST_ONLINE *error);
function tox_friend_get_last_online(const tox: TTox; friend_number: Cardinal;
  var error: TToxErrFriendGetLastOnline): UInt64; cdecl; external TOX_LIBRARY;



(*******************************************************************************
 *
 * :: Friend-specific state queries (can also be received through callbacks)
 *
 ******************************************************************************)



(**
 * Common error codes for friend state query functions.
 *)
//typedef enum TOX_ERR_FRIEND_QUERY {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_FRIEND_QUERY_OK,
//
//    /**
//     * The pointer parameter for storing the query result (name, message) was
//     * NULL. Unlike the `_self_` variants of these functions, which have no effect
//     * when a parameter is NULL, these functions return an error in that case.
//     */
//    TOX_ERR_FRIEND_QUERY_NULL,
//
//    /**
//     * The friend_number did not designate a valid friend.
//     */
//    TOX_ERR_FRIEND_QUERY_FRIEND_NOT_FOUND,
//
//} TOX_ERR_FRIEND_QUERY;
type
  TToxErrFriendQuery = (
    (**
     * The function returned successfully.
     *)
    fqOk,

    (**
     * The pointer parameter for storing the query result (name, message) was
     * NULL. Unlike the `_self_` variants of these functions, which have no effect
     * when a parameter is NULL, these functions return an error in that case.
     *)
    fqNULL,

    (**
     * The friend_number did not designate a valid friend.
     *)
    fqFriendNotFound
  );

(**
 * Return the length of the friend's name. If the friend number is invalid, the
 * return value is unspecified.
 *
 * The return value is equal to the `length` argument received by the last
 * `friend_name` callback.
 *)
//size_t tox_friend_get_name_size(const Tox *tox, uint32_t friend_number, TOX_ERR_FRIEND_QUERY *error);
function tox_friend_get_name_size(const tox: TTox; friend_number: Cardinal;
  var error: TToxErrFriendQuery): NativeUInt; cdecl; external TOX_LIBRARY;

(**
 * Write the name of the friend designated by the given friend number to a byte
 * array.
 *
 * Call tox_friend_get_name_size to determine the allocation size for the `name`
 * parameter.
 *
 * The data written to `name` is equal to the data received by the last
 * `friend_name` callback.
 *
 * @param name A valid memory region large enough to store the friend's name.
 *
 * @return true on success.
 *)
//bool tox_friend_get_name(const Tox *tox, uint32_t friend_number, uint8_t *name, TOX_ERR_FRIEND_QUERY *error);
function tox_friend_get_name(const tox: TTox; friend_number: Cardinal; name: PByte;
  var error: TToxErrFriendQuery): Boolean; cdecl; external TOX_LIBRARY;

(**
 * @param friend_number The friend number of the friend whose name changed.
 * @param name A byte array containing the same data as
 *   tox_friend_get_name would write to its `name` parameter.
 * @param length A value equal to the return value of
 *   tox_friend_get_name_size.
 *)
//typedef void tox_friend_name_cb(Tox *tox, uint32_t friend_number, const uint8_t *name, size_t length, void *user_data);
type
  Ttox_friend_name_cb = procedure(tox: TTox; friend_number: Cardinal;
    const name: PByte; length: NativeUInt; user_data: Pointer); cdecl;

(**
 * Set the callback for the `friend_name` event. Pass NULL to unset.
 *
 * This event is triggered when a friend changes their name.
 *)
//void tox_callback_friend_name(Tox *tox, tox_friend_name_cb *callback, void *user_data);
procedure tox_callback_friend_name(tox: TTox; callback: Ttox_friend_name_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;

(**
 * Return the length of the friend's status message. If the friend number is
 * invalid, the return value is SIZE_MAX.
 *)
//size_t tox_friend_get_status_message_size(const Tox *tox, uint32_t friend_number, TOX_ERR_FRIEND_QUERY *error);
function tox_friend_get_status_message_size(const tox: TTox; friend_number: Cardinal;
  var error: TToxErrFriendQuery): NativeUInt; cdecl; external TOX_LIBRARY;

(**
 * Write the status message of the friend designated by the given friend number to a byte
 * array.
 *
 * Call tox_friend_get_status_message_size to determine the allocation size for the `status_name`
 * parameter.
 *
 * The data written to `status_message` is equal to the data received by the last
 * `friend_status_message` callback.
 *
 * @param status_message A valid memory region large enough to store the friend's status message.
 *)
//bool tox_friend_get_status_message(const Tox *tox, uint32_t friend_number, uint8_t *status_message,
//                                   TOX_ERR_FRIEND_QUERY *error);
function tox_friend_get_status_message(const tox: TTox; friend_number: Cardinal;
  status_message: PByte; var error: TToxErrFriendQuery): Boolean; cdecl; external TOX_LIBRARY;

(**
 * @param friend_number The friend number of the friend whose status message
 *   changed.
 * @param message A byte array containing the same data as
 *   tox_friend_get_status_message would write to its `status_message` parameter.
 * @param length A value equal to the return value of
 *   tox_friend_get_status_message_size.
 *)
//typedef void tox_friend_status_message_cb(Tox *tox, uint32_t friend_number, const uint8_t *message, size_t length,
//        void *user_data);
type
  Ttox_friend_status_message_cb = procedure(tox: TTox; friend_number:  Cardinal;
    const message: PByte; length: NativeUInt; user_data: Pointer); cdecl;

(**
 * Set the callback for the `friend_status_message` event. Pass NULL to unset.
 *
 * This event is triggered when a friend changes their status message.
 *)
//void tox_callback_friend_status_message(Tox *tox, tox_friend_status_message_cb *callback, void *user_data);
procedure tox_callback_friend_status_message(tox: TTox; callback: Ttox_friend_status_message_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;

(**
 * Return the friend's user status (away/busy/...). If the friend number is
 * invalid, the return value is unspecified.
 *
 * The status returned is equal to the last status received through the
 * `friend_status` callback.
 *)
//TOX_USER_STATUS tox_friend_get_status(const Tox *tox, uint32_t friend_number, TOX_ERR_FRIEND_QUERY *error);
function tox_friend_get_status(const tox: TTox; friend_number: Cardinal;
  var error: TToxErrFriendQuery): TToxUserStatus; cdecl; external TOX_LIBRARY;

(**
 * @param friend_number The friend number of the friend whose user status
 *   changed.
 * @param status The new user status.
 *)
//typedef void tox_friend_status_cb(Tox *tox, uint32_t friend_number, TOX_USER_STATUS status, void *user_data);
type
  Ttox_friend_status_cb = procedure(tox: TTox; friend_number: Cardinal;
    status: TToxUserStatus; user_data: Pointer); cdecl;

(**
 * Set the callback for the `friend_status` event. Pass NULL to unset.
 *
 * This event is triggered when a friend changes their user status.
 *)
//void tox_callback_friend_status(Tox *tox, tox_friend_status_cb *callback, void *user_data);
procedure tox_callback_friend_status(tox: TTox; callback: Ttox_friend_status_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;

(**
 * Check whether a friend is currently connected to this client.
 *
 * The result of this function is equal to the last value received by the
 * `friend_connection_status` callback.
 *
 * @param friend_number The friend number for which to query the connection
 *   status.
 *
 * @return the friend's connection status as it was received through the
 *   `friend_connection_status` event.
 *)
//TOX_CONNECTION tox_friend_get_connection_status(const Tox *tox, uint32_t friend_number, TOX_ERR_FRIEND_QUERY *error);
function tox_friend_get_connection_status(const tox: TTox; friend_number: Cardinal;
  var error: TToxErrFriendQuery): TToxConnection; cdecl; external TOX_LIBRARY;

(**
 * @param friend_number The friend number of the friend whose connection status
 *   changed.
 * @param connection_status The result of calling
 *   tox_friend_get_connection_status on the passed friend_number.
 *)
//typedef void tox_friend_connection_status_cb(Tox *tox, uint32_t friend_number, TOX_CONNECTION connection_status,
//        void *user_data);
type
  Ttox_friend_connection_status_cb = procedure(tox: TTox; friend_number: Cardinal;
    connection_status: TToxConnection; user_data: Pointer); cdecl;

(**
 * Set the callback for the `friend_connection_status` event. Pass NULL to unset.
 *
 * This event is triggered when a friend goes offline after having been online,
 * or when a friend goes online.
 *
 * This callback is not called when adding friends. It is assumed that when
 * adding friends, their connection status is initially offline.
 *)
//void tox_callback_friend_connection_status(Tox *tox, tox_friend_connection_status_cb *callback, void *user_data);
procedure tox_callback_friend_connection_status(tox: TTox; callback: Ttox_friend_connection_status_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;

(**
 * Check whether a friend is currently typing a message.
 *
 * @param friend_number The friend number for which to query the typing status.
 *
 * @return true if the friend is typing.
 * @return false if the friend is not typing, or the friend number was
 *   invalid. Inspect the error code to determine which case it is.
 *)
//bool tox_friend_get_typing(const Tox *tox, uint32_t friend_number, TOX_ERR_FRIEND_QUERY *error);
function tox_friend_get_typing(const tox: TTox; friend_number: Cardinal;
  var error: TToxErrFriendQuery): Boolean; cdecl; external TOX_LIBRARY;

(**
 * @param friend_number The friend number of the friend who started or stopped
 *   typing.
 * @param is_typing The result of calling tox_friend_get_typing on the passed
 *   friend_number.
 *)
//typedef void tox_friend_typing_cb(Tox *tox, uint32_t friend_number, bool is_typing, void *user_data);
type
  Ttox_friend_typing_cb = procedure(tox: TTox; friend_number: Cardinal;
    is_typing: Boolean; user_data: Pointer); cdecl;

(**
 * Set the callback for the `friend_typing` event. Pass NULL to unset.
 *
 * This event is triggered when a friend starts or stops typing.
 *)
//void tox_callback_friend_typing(Tox *tox, tox_friend_typing_cb *callback, void *user_data);
procedure tox_callback_friend_typing(tox: TTox; callback: Ttox_friend_typing_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;



(*******************************************************************************
 *
 * :: Sending private messages
 *
 ******************************************************************************)



//typedef enum TOX_ERR_SET_TYPING {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_SET_TYPING_OK,
//
//    /**
//     * The friend number did not designate a valid friend.
//     */
//    TOX_ERR_SET_TYPING_FRIEND_NOT_FOUND,
//
//} TOX_ERR_SET_TYPING;
type
  TToxErrSetTyping = (
    (**
     * The function returned successfully.
     *)
    estOK,

    (**
     * The friend number did not designate a valid friend.
     *)
    estFFriendNotFound
  );

(**
 * Set the client's typing status for a friend.
 *
 * The client is responsible for turning it on or off.
 *
 * @param friend_number The friend to which the client is typing a message.
 * @param typing The typing status. True means the client is typing.
 *
 * @return true on success.
 *)
//bool tox_self_set_typing(Tox *tox, uint32_t friend_number, bool typing, TOX_ERR_SET_TYPING *error);
function tox_self_set_typing(tox: TTox; friend_number: Cardinal; typing: Boolean;
  var error: TToxErrSetTyping): Boolean; cdecl; external TOX_LIBRARY;

//typedef enum TOX_ERR_FRIEND_SEND_MESSAGE {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_FRIEND_SEND_MESSAGE_OK,
//
//    /**
//     * One of the arguments to the function was NULL when it was not expected.
//     */
//    TOX_ERR_FRIEND_SEND_MESSAGE_NULL,
//
//    /**
//     * The friend number did not designate a valid friend.
//     */
//    TOX_ERR_FRIEND_SEND_MESSAGE_FRIEND_NOT_FOUND,
//
//    /**
//     * This client is currently not connected to the friend.
//     */
//    TOX_ERR_FRIEND_SEND_MESSAGE_FRIEND_NOT_CONNECTED,
//
//    /**
//     * An allocation error occurred while increasing the send queue size.
//     */
//    TOX_ERR_FRIEND_SEND_MESSAGE_SENDQ,
//
//    /**
//     * Message length exceeded TOX_MAX_MESSAGE_LENGTH.
//     */
//    TOX_ERR_FRIEND_SEND_MESSAGE_TOO_LONG,
//
//    /**
//     * Attempted to send a zero-length message.
//     */
//    TOX_ERR_FRIEND_SEND_MESSAGE_EMPTY,
//
//} TOX_ERR_FRIEND_SEND_MESSAGE;
type
  TToxErrFriendSendMessage = (
    (**
     * The function returned successfully.
     *)
    esmOk,

    (**
     * One of the arguments to the function was NULL when it was not expected.
     *)
    esmNULL,

    (**
     * The friend number did not designate a valid friend.
     *)
    esmFriendNotFound,

    (**
     * This client is currently not connected to the friend.
     *)
    esmFriendNotConnected,

    (**
     * An allocation error occurred while increasing the send queue size.
     *)
    esmSendq,

    (**
     * Message length exceeded TOX_MAX_MESSAGE_LENGTH.
     *)
    esmTooLong,

    (**
     * Attempted to send a zero-length message.
     *)
    esmEmpty
  );

(**
 * Send a text chat message to an online friend.
 *
 * This function creates a chat message packet and pushes it into the send
 * queue.
 *
 * The message length may not exceed TOX_MAX_MESSAGE_LENGTH. Larger messages
 * must be split by the client and sent as separate messages. Other clients can
 * then reassemble the fragments. Messages may not be empty.
 *
 * The return value of this function is the message ID. If a read receipt is
 * received, the triggered `friend_read_receipt` event will be passed this message ID.
 *
 * Message IDs are unique per friend. The first message ID is 0. Message IDs are
 * incremented by 1 each time a message is sent. If UINT32_MAX messages were
 * sent, the next message ID is 0.
 *
 * @param type Message type (normal, action, ...).
 * @param friend_number The friend number of the friend to send the message to.
 * @param message A non-NULL pointer to the first element of a byte array
 *   containing the message text.
 * @param length Length of the message to be sent.
 *)
//uint32_t tox_friend_send_message(Tox *tox, uint32_t friend_number, TOX_MESSAGE_TYPE type, const uint8_t *message,
//                                 size_t length, TOX_ERR_FRIEND_SEND_MESSAGE *error);
function tox_friend_send_message(tox: TTox; friend_number: Cardinal;
  message_type: TToxMessageType; const message: PByte; length: NativeUInt;
  var error: TToxErrFriendSendMessage): Cardinal; cdecl; external TOX_LIBRARY;

(**
 * @param friend_number The friend number of the friend who received the message.
 * @param message_id The message ID as returned from tox_friend_send_message
 *   corresponding to the message sent.
 *)
//typedef void tox_friend_read_receipt_cb(Tox *tox, uint32_t friend_number, uint32_t message_id, void *user_data);
type
  Ttox_friend_read_receipt_cb = procedure(tox: TTox; friend_number: Cardinal;
    message_id: Cardinal; user_data: Pointer); cdecl;

(**
 * Set the callback for the `friend_read_receipt` event. Pass NULL to unset.
 *
 * This event is triggered when the friend receives the message sent with
 * tox_friend_send_message with the corresponding message ID.
 *)
//void tox_callback_friend_read_receipt(Tox *tox, tox_friend_read_receipt_cb *callback, void *user_data);
procedure tox_callback_friend_read_receipt(tox: TTox; callback: Ttox_friend_read_receipt_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;



(*******************************************************************************
 *
 * :: Receiving private messages and friend requests
 *
 ******************************************************************************)



(**
 * @param public_key The Public Key of the user who sent the friend request.
 * @param time_delta A delta in seconds between when the message was composed
 *   and when it is being transmitted. For messages that are sent immediately,
 *   it will be 0. If a message was written and couldn't be sent immediately
 *   (due to a connection failure, for example), the time_delta is an
 *   approximation of when it was composed.
 * @param message The message they sent along with the request.
 * @param length The size of the message byte array.
 *)
//typedef void tox_friend_request_cb(Tox *tox, const uint8_t *public_key, const uint8_t *message, size_t length,
//                                   void *user_data);
type
  Ttox_friend_request_cb = procedure(tox: TTox; const public_key: PByte;
    const message: PByte; length: NativeUInt; user_data: Pointer); cdecl;

(**
 * Set the callback for the `friend_request` event. Pass NULL to unset.
 *
 * This event is triggered when a friend request is received.
 *)
//void tox_callback_friend_request(Tox *tox, tox_friend_request_cb *callback, void *user_data);
procedure tox_callback_friend_request(tox: TTox; callback: Ttox_friend_request_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;

(**
 * @param friend_number The friend number of the friend who sent the message.
 * @param time_delta Time between composition and sending.
 * @param message The message data they sent.
 * @param length The size of the message byte array.
 *
 * @see friend_request for more information on time_delta.
 *)
//typedef void tox_friend_message_cb(Tox *tox, uint32_t friend_number, TOX_MESSAGE_TYPE type, const uint8_t *message,
//                                   size_t length, void *user_data);
type
  Ttox_friend_message_cb = procedure(tox: TTox; friend_number: Cardinal;
    message_type: TToxMessageType; const message: PByte; length: NativeUInt;
    user_data: Pointer); cdecl;

(**
 * Set the callback for the `friend_message` event. Pass NULL to unset.
 *
 * This event is triggered when a message from a friend is received.
 *)
//void tox_callback_friend_message(Tox *tox, tox_friend_message_cb *callback, void *user_data);
procedure tox_callback_friend_message(tox: TTox; callback: Ttox_friend_message_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;



(*******************************************************************************
 *
 * :: File transmission: common between sending and receiving
 *
 ******************************************************************************)



(**
 * Generates a cryptographic hash of the given data.
 *
 * This function may be used by clients for any purpose, but is provided
 * primarily for validating cached avatars. This use is highly recommended to
 * avoid unnecessary avatar updates.
 *
 * If hash is NULL or data is NULL while length is not 0 the function returns false,
 * otherwise it returns true.
 *
 * This function is a wrapper to internal message-digest functions.
 *
 * @param hash A valid memory location the hash data. It must be at least
 *   TOX_HASH_LENGTH bytes in size.
 * @param data Data to be hashed or NULL.
 * @param length Size of the data array or 0.
 *
 * @return true if hash was not NULL.
 *)
//bool tox_hash(uint8_t *hash, const uint8_t *data, size_t length);
function tox_hash(hash: PByte; const data: PByte; length: NativeUInt): Boolean; cdecl; external TOX_LIBRARY;

//enum TOX_FILE_KIND {
//
//    /**
//     * Arbitrary file data. Clients can choose to handle it based on the file name
//     * or magic or any other way they choose.
//     */
//    TOX_FILE_KIND_DATA,
//
//    /**
//     * Avatar file_id. This consists of tox_hash(image).
//     * Avatar data. This consists of the image data.
//     *
//     * Avatars can be sent at any time the client wishes. Generally, a client will
//     * send the avatar to a friend when that friend comes online, and to all
//     * friends when the avatar changed. A client can save some traffic by
//     * remembering which friend received the updated avatar already and only send
//     * it if the friend has an out of date avatar.
//     *
//     * Clients who receive avatar send requests can reject it (by sending
//     * TOX_FILE_CONTROL_CANCEL before any other controls), or accept it (by
//     * sending TOX_FILE_CONTROL_RESUME). The file_id of length TOX_HASH_LENGTH bytes
//     * (same length as TOX_FILE_ID_LENGTH) will contain the hash. A client can compare
//     * this hash with a saved hash and send TOX_FILE_CONTROL_CANCEL to terminate the avatar
//     * transfer if it matches.
//     *
//     * When file_size is set to 0 in the transfer request it means that the client
//     * has no avatar.
//     */
//    TOX_FILE_KIND_AVATAR,
//
//};
type
  TToxFileKindAvatar = (
    (**
     * Arbitrary file data. Clients can choose to handle it based on the file name
     * or magic or any other way they choose.
     *)
    fkData,

    (**
     * Avatar file_id. This consists of tox_hash(image).
     * Avatar data. This consists of the image data.
     *
     * Avatars can be sent at any time the client wishes. Generally, a client will
     * send the avatar to a friend when that friend comes online, and to all
     * friends when the avatar changed. A client can save some traffic by
     * remembering which friend received the updated avatar already and only send
     * it if the friend has an out of date avatar.
     *
     * Clients who receive avatar send requests can reject it (by sending
     * TOX_FILE_CONTROL_CANCEL before any other controls), or accept it (by
     * sending TOX_FILE_CONTROL_RESUME). The file_id of length TOX_HASH_LENGTH bytes
     * (same length as TOX_FILE_ID_LENGTH) will contain the hash. A client can compare
     * this hash with a saved hash and send TOX_FILE_CONTROL_CANCEL to terminate the avatar
     * transfer if it matches.
     *
     * When file_size is set to 0 in the transfer request it means that the client
     * has no avatar.
     *)
    fkAvatar
  );

//typedef enum TOX_FILE_CONTROL {
//
//    /**
//     * Sent by the receiving side to accept a file send request. Also sent after a
//     * TOX_FILE_CONTROL_PAUSE command to continue sending or receiving.
//     */
//    TOX_FILE_CONTROL_RESUME,
//
//    /**
//     * Sent by clients to pause the file transfer. The initial state of a file
//     * transfer is always paused on the receiving side and running on the sending
//     * side. If both the sending and receiving side pause the transfer, then both
//     * need to send TOX_FILE_CONTROL_RESUME for the transfer to resume.
//     */
//    TOX_FILE_CONTROL_PAUSE,
//
//    /**
//     * Sent by the receiving side to reject a file send request before any other
//     * commands are sent. Also sent by either side to terminate a file transfer.
//     */
//    TOX_FILE_CONTROL_CANCEL,
//
//} TOX_FILE_CONTROL;
type
  TToxFileControl = (
    (**
     * Sent by the receiving side to accept a file send request. Also sent after a
     * TOX_FILE_CONTROL_PAUSE command to continue sending or receiving.
     *)
    fcResume,

    (**
     * Sent by clients to pause the file transfer. The initial state of a file
     * transfer is always paused on the receiving side and running on the sending
     * side. If both the sending and receiving side pause the transfer, then both
     * need to send TOX_FILE_CONTROL_RESUME for the transfer to resume.
     *)
    fcPause,

    (**
     * Sent by the receiving side to reject a file send request before any other
     * commands are sent. Also sent by either side to terminate a file transfer.
     *)
    fcCancel
  );

//typedef enum TOX_ERR_FILE_CONTROL {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_FILE_CONTROL_OK,
//
//    /**
//     * The friend_number passed did not designate a valid friend.
//     */
//    TOX_ERR_FILE_CONTROL_FRIEND_NOT_FOUND,
//
//    /**
//     * This client is currently not connected to the friend.
//     */
//    TOX_ERR_FILE_CONTROL_FRIEND_NOT_CONNECTED,
//
//    /**
//     * No file transfer with the given file number was found for the given friend.
//     */
//    TOX_ERR_FILE_CONTROL_NOT_FOUND,
//
//    /**
//     * A RESUME control was sent, but the file transfer is running normally.
//     */
//    TOX_ERR_FILE_CONTROL_NOT_PAUSED,
//
//    /**
//     * A RESUME control was sent, but the file transfer was paused by the other
//     * party. Only the party that paused the transfer can resume it.
//     */
//    TOX_ERR_FILE_CONTROL_DENIED,
//
//    /**
//     * A PAUSE control was sent, but the file transfer was already paused.
//     */
//    TOX_ERR_FILE_CONTROL_ALREADY_PAUSED,
//
//    /**
//     * Packet queue is full.
//     */
//    TOX_ERR_FILE_CONTROL_SENDQ,
//
//} TOX_ERR_FILE_CONTROL;
type
  TToxErrFileControl = (
    (**
     * The function returned successfully.
     *)
    efcOk,

    (**
     * The friend_number passed did not designate a valid friend.
     *)
    efcFriendNotFound,

    (**
     * This client is currently not connected to the friend.
     *)
    efcFriendNotConnected,

    (**
     * No file transfer with the given file number was found for the given friend.
     *)
    efcNotFound,

    (**
     * A RESUME control was sent, but the file transfer is running normally.
     *)
    efcNotPaused,

    (**
     * A RESUME control was sent, but the file transfer was paused by the other
     * party. Only the party that paused the transfer can resume it
     *)
    efcDenieb,

    (**
     * A PAUSE control was sent, but the file transfer was already paused.
     *)
    efcAlreadyPaused,

    (**
     * Packet queue is full.
     *)
    efcSendq
  );

(**
 * Sends a file control command to a friend for a given file transfer.
 *
 * @param friend_number The friend number of the friend the file is being
 *   transferred to or received from.
 * @param file_number The friend-specific identifier for the file transfer.
 * @param control The control command to send.
 *
 * @return true on success.
 *)
//bool tox_file_control(Tox *tox, uint32_t friend_number, uint32_t file_number, TOX_FILE_CONTROL control,
//                      TOX_ERR_FILE_CONTROL *error);
function tox_file_control(tox: TTox; friend_number: Cardinal; file_number: Cardinal;
  control: TToxFileControl; var error: TToxErrFileControl): Boolean; cdecl; external TOX_LIBRARY;

(**
 * When receiving TOX_FILE_CONTROL_CANCEL, the client should release the
 * resources associated with the file number and consider the transfer failed.
 *
 * @param friend_number The friend number of the friend who is sending the file.
 * @param file_number The friend-specific file number the data received is
 *   associated with.
 * @param control The file control command received.
 *)
//typedef void tox_file_recv_control_cb(Tox *tox, uint32_t friend_number, uint32_t file_number, TOX_FILE_CONTROL control,
//                                      void *user_data);
type
  Ttox_file_recv_control_cb = procedure(tox: TTox; friend_number: Cardinal;
    file_number: Cardinal; control: TToxFileControl; user_data: Pointer); cdecl;

(**
 * Set the callback for the `file_recv_control` event. Pass NULL to unset.
 *
 * This event is triggered when a file control command is received from a
 * friend.
 *)
//void tox_callback_file_recv_control(Tox *tox, tox_file_recv_control_cb *callback, void *user_data);
procedure tox_callback_file_recv_control(tox: TTox; callback: Ttox_file_recv_control_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;

//typedef enum TOX_ERR_FILE_SEEK {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_FILE_SEEK_OK,
//
//    /**
//     * The friend_number passed did not designate a valid friend.
//     */
//    TOX_ERR_FILE_SEEK_FRIEND_NOT_FOUND,
//
//    /**
//     * This client is currently not connected to the friend.
//     */
//    TOX_ERR_FILE_SEEK_FRIEND_NOT_CONNECTED,
//
//    /**
//     * No file transfer with the given file number was found for the given friend.
//     */
//    TOX_ERR_FILE_SEEK_NOT_FOUND,
//
//    /**
//     * File was not in a state where it could be seeked.
//     */
//    TOX_ERR_FILE_SEEK_DENIED,
//
//    /**
//     * Seek position was invalid
//     */
//    TOX_ERR_FILE_SEEK_INVALID_POSITION,
//
//    /**
//     * Packet queue is full.
//     */
//    TOX_ERR_FILE_SEEK_SENDQ,
//
//} TOX_ERR_FILE_SEEK;
type
  TToxErrFileSeek = (
    (**
     * The function returned successfully.
     *)
    efsOk,

    (**
     * The friend_number passed did not designate a valid friend.
     *)
    efsFriendNotFound,

    (**
     * This client is currently not connected to the friend.
     *)
    efsFriendNotConnected,

    (**
     * No file transfer with the given file number was found for the given friend.
     *)
    efsNotFound,

    (**
     * File was not in a state where it could be seeked.
     *)
    efsDenied,

    (**
     * Seek position was invalid
     *)
    efsInvalidPosition,

    (**
     * Packet queue is full.
     *)
    efsSendq
  );

(**
 * Sends a file seek control command to a friend for a given file transfer.
 *
 * This function can only be called to resume a file transfer right before
 * TOX_FILE_CONTROL_RESUME is sent.
 *
 * @param friend_number The friend number of the friend the file is being
 *   received from.
 * @param file_number The friend-specific identifier for the file transfer.
 * @param position The position that the file should be seeked to.
 *)
//bool tox_file_seek(Tox *tox, uint32_t friend_number, uint32_t file_number, uint64_t position, TOX_ERR_FILE_SEEK *error);
function tox_file_seek(tox: TTox; friend_number: Cardinal; file_number: Cardinal;
  position: UInt64; var error: TToxErrFileSeek): Boolean; cdecl; external TOX_LIBRARY;

//typedef enum TOX_ERR_FILE_GET {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_FILE_GET_OK,
//
//    /**
//     * One of the arguments to the function was NULL when it was not expected.
//     */
//    TOX_ERR_FILE_GET_NULL,
//
//    /**
//     * The friend_number passed did not designate a valid friend.
//     */
//    TOX_ERR_FILE_GET_FRIEND_NOT_FOUND,
//
//    /**
//     * No file transfer with the given file number was found for the given friend.
//     */
//    TOX_ERR_FILE_GET_NOT_FOUND,
//
//} TOX_ERR_FILE_GET;
type
  TtoxErrFileGet = (
    (**
     * The function returned successfully.
     *)
    efgOk,

    (**
     * One of the arguments to the function was NULL when it was not expected.
     *)
    efgNULL,

    (**
     * The friend_number passed did not designate a valid friend.
     *)
    efgFriendNotFound,

    (**
     * No file transfer with the given file number was found for the given friend.
     *)
    efgNotFound
  );

(**
 * Copy the file id associated to the file transfer to a byte array.
 *
 * @param friend_number The friend number of the friend the file is being
 *   transferred to or received from.
 * @param file_number The friend-specific identifier for the file transfer.
 * @param file_id A memory region of at least TOX_FILE_ID_LENGTH bytes. If
 *   this parameter is NULL, this function has no effect.
 *
 * @return true on success.
 *)
//bool tox_file_get_file_id(const Tox *tox, uint32_t friend_number, uint32_t file_number, uint8_t *file_id,
//                          TOX_ERR_FILE_GET *error);
function tox_file_get_file_id(const tox: TTox; friend_number: Cardinal;
  file_number: Cardinal; file_id: PByte; var error: TtoxErrFileGet): Boolean; cdecl; external TOX_LIBRARY;



(*******************************************************************************
 *
 * :: File transmission: sending
 *
 ******************************************************************************)



//typedef enum TOX_ERR_FILE_SEND {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_FILE_SEND_OK,
//
//    /**
//     * One of the arguments to the function was NULL when it was not expected.
//     */
//    TOX_ERR_FILE_SEND_NULL,
//
//    /**
//     * The friend_number passed did not designate a valid friend.
//     */
//    TOX_ERR_FILE_SEND_FRIEND_NOT_FOUND,
//
//    /**
//     * This client is currently not connected to the friend.
//     */
//    TOX_ERR_FILE_SEND_FRIEND_NOT_CONNECTED,
//
//    /**
//     * Filename length exceeded TOX_MAX_FILENAME_LENGTH bytes.
//     */
//    TOX_ERR_FILE_SEND_NAME_TOO_LONG,
//
//    /**
//     * Too many ongoing transfers. The maximum number of concurrent file transfers
//     * is 256 per friend per direction (sending and receiving).
//     */
//    TOX_ERR_FILE_SEND_TOO_MANY,
//
//} TOX_ERR_FILE_SEND;
type
  TToxErrFileSend = (
    (**
     * The function returned successfully.
     *)
    efsendOk,

    (**
     * One of the arguments to the function was NULL when it was not expected.
     *)
    efsendNULL,

    (**
     * The friend_number passed did not designate a valid friend.
     *)
    efsendFriendNotFound,

    (**
     * This client is currently not connected to the friend.
     *)
    efsendFriendNotConnected,

    (**
     * Filename length exceeded TOX_MAX_FILENAME_LENGTH bytes.
     *)
    efsendNameTooLong,

    (**
     * Too many ongoing transfers. The maximum number of concurrent file transfers
     * is 256 per friend per direction (sending and receiving)
     *)
    efsendTooMany
  );

(**
 * Send a file transmission request.
 *
 * Maximum filename length is TOX_MAX_FILENAME_LENGTH bytes. The filename
 * should generally just be a file name, not a path with directory names.
 *
 * If a non-UINT64_MAX file size is provided, it can be used by both sides to
 * determine the sending progress. File size can be set to UINT64_MAX for streaming
 * data of unknown size.
 *
 * File transmission occurs in chunks, which are requested through the
 * `file_chunk_request` event.
 *
 * When a friend goes offline, all file transfers associated with the friend are
 * purged from core.
 *
 * If the file contents change during a transfer, the behaviour is unspecified
 * in general. What will actually happen depends on the mode in which the file
 * was modified and how the client determines the file size.
 *
 * - If the file size was increased
 *   - and sending mode was streaming (file_size = UINT64_MAX), the behaviour
 *     will be as expected.
 *   - and sending mode was file (file_size != UINT64_MAX), the
 *     file_chunk_request callback will receive length = 0 when Core thinks
 *     the file transfer has finished. If the client remembers the file size as
 *     it was when sending the request, it will terminate the transfer normally.
 *     If the client re-reads the size, it will think the friend cancelled the
 *     transfer.
 * - If the file size was decreased
 *   - and sending mode was streaming, the behaviour is as expected.
 *   - and sending mode was file, the callback will return 0 at the new
 *     (earlier) end-of-file, signalling to the friend that the transfer was
 *     cancelled.
 * - If the file contents were modified
 *   - at a position before the current read, the two files (local and remote)
 *     will differ after the transfer terminates.
 *   - at a position after the current read, the file transfer will succeed as
 *     expected.
 *   - In either case, both sides will regard the transfer as complete and
 *     successful.
 *
 * @param friend_number The friend number of the friend the file send request
 *   should be sent to.
 * @param kind The meaning of the file to be sent.
 * @param file_size Size in bytes of the file the client wants to send, UINT64_MAX if
 *   unknown or streaming.
 * @param file_id A file identifier of length TOX_FILE_ID_LENGTH that can be used to
 *   uniquely identify file transfers across core restarts. If NULL, a random one will
 *   be generated by core. It can then be obtained by using tox_file_get_file_id().
 * @param filename Name of the file. Does not need to be the actual name. This
 *   name will be sent along with the file send request.
 * @param filename_length Size in bytes of the filename.
 *
 * @return A file number used as an identifier in subsequent callbacks. This
 *   number is per friend. File numbers are reused after a transfer terminates.
 *   On failure, this function returns UINT32_MAX. Any pattern in file numbers
 *   should not be relied on.
 *)
//uint32_t tox_file_send(Tox *tox, uint32_t friend_number, uint32_t kind, uint64_t file_size, const uint8_t *file_id,
//                       const uint8_t *filename, size_t filename_length, TOX_ERR_FILE_SEND *error);
function tox_file_send(tox: TTox; friend_number: Cardinal; kind: Cardinal;
  file_size: UInt64; const file_id: PByte; const filename: PByte;
  filename_length: NativeUInt; var error: TToxErrFileSend): Cardinal; cdecl; external TOX_LIBRARY;

//typedef enum TOX_ERR_FILE_SEND_CHUNK {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_FILE_SEND_CHUNK_OK,
//
//    /**
//     * The length parameter was non-zero, but data was NULL.
//     */
//    TOX_ERR_FILE_SEND_CHUNK_NULL,
//
//    /**
//     * The friend_number passed did not designate a valid friend.
//     */
//    TOX_ERR_FILE_SEND_CHUNK_FRIEND_NOT_FOUND,
//
//    /**
//     * This client is currently not connected to the friend.
//     */
//    TOX_ERR_FILE_SEND_CHUNK_FRIEND_NOT_CONNECTED,
//
//    /**
//     * No file transfer with the given file number was found for the given friend.
//     */
//    TOX_ERR_FILE_SEND_CHUNK_NOT_FOUND,
//
//    /**
//     * File transfer was found but isn't in a transferring state: (paused, done,
//     * broken, etc...) (happens only when not called from the request chunk callback).
//     */
//    TOX_ERR_FILE_SEND_CHUNK_NOT_TRANSFERRING,
//
//    /**
//     * Attempted to send more or less data than requested. The requested data size is
//     * adjusted according to maximum transmission unit and the expected end of
//     * the file. Trying to send less or more than requested will return this error.
//     */
//    TOX_ERR_FILE_SEND_CHUNK_INVALID_LENGTH,
//
//    /**
//     * Packet queue is full.
//     */
//    TOX_ERR_FILE_SEND_CHUNK_SENDQ,
//
//    /**
//     * Position parameter was wrong.
//     */
//    TOX_ERR_FILE_SEND_CHUNK_WRONG_POSITION,
//
//} TOX_ERR_FILE_SEND_CHUNK;
type
  TToxErrFileSendChunk = (
    (**
     * The function returned successfully.
     *)
    efscOk,

    (**
     * The length parameter was non-zero, but data was NULL.
     *)
    efscNULL,

    (**
     * The friend_number passed did not designate a valid friend.
     *)
    efscFriendNotFound,

    (**
     * This client is currently not connected to the friend.
     *)
    efscFriendNotConnected,

    (**
     * No file transfer with the given file number was found for the given friend.
     *)
    efscNotFound,

    (**
     * File transfer was found but isn't in a transferring state: (paused, done,
     * broken, etc...) (happens only when not called from the request chunk callback)
     *)
    efscNotTransferring,

    (**
     * Attempted to send more or less data than requested. The requested data size is
     * adjusted according to maximum transmission unit and the expected end of
     * the file. Trying to send less or more than requested will return this error.
     *)
    efscInvalidLength,

    (**
     * Packet queue is full.
     *)
    efscSendq,

    (**
     * Position parameter was wrong.
     *)
    efscWrongPosition
  );

(**
 * Send a chunk of file data to a friend.
 *
 * This function is called in response to the `file_chunk_request` callback. The
 * length parameter should be equal to the one received though the callback.
 * If it is zero, the transfer is assumed complete. For files with known size,
 * Core will know that the transfer is complete after the last byte has been
 * received, so it is not necessary (though not harmful) to send a zero-length
 * chunk to terminate. For streams, core will know that the transfer is finished
 * if a chunk with length less than the length requested in the callback is sent.
 *
 * @param friend_number The friend number of the receiving friend for this file.
 * @param file_number The file transfer identifier returned by tox_file_send.
 * @param position The file or stream position from which to continue reading.
 * @return true on success.
 *)
//bool tox_file_send_chunk(Tox *tox, uint32_t friend_number, uint32_t file_number, uint64_t position, const uint8_t *data,
//                         size_t length, TOX_ERR_FILE_SEND_CHUNK *error);
function tox_file_send_chunk(tox: TTox; friend_number: Cardinal; file_number: Cardinal;
  position: UInt64; const data: PByte; length: NativeUInt;
  var error: TToxErrFileSendChunk): Boolean; cdecl; external TOX_LIBRARY;

(**
 * If the length parameter is 0, the file transfer is finished, and the client's
 * resources associated with the file number should be released. After a call
 * with zero length, the file number can be reused for future file transfers.
 *
 * If the requested position is not equal to the client's idea of the current
 * file or stream position, it will need to seek. In case of read-once streams,
 * the client should keep the last read chunk so that a seek back can be
 * supported. A seek-back only ever needs to read from the last requested chunk.
 * This happens when a chunk was requested, but the send failed. A seek-back
 * request can occur an arbitrary number of times for any given chunk.
 *
 * In response to receiving this callback, the client should call the function
 * `tox_file_send_chunk` with the requested chunk. If the number of bytes sent
 * through that function is zero, the file transfer is assumed complete. A
 * client must send the full length of data requested with this callback.
 *
 * @param friend_number The friend number of the receiving friend for this file.
 * @param file_number The file transfer identifier returned by tox_file_send.
 * @param position The file or stream position from which to continue reading.
 * @param length The number of bytes requested for the current chunk.
 *)
//typedef void tox_file_chunk_request_cb(Tox *tox, uint32_t friend_number, uint32_t file_number, uint64_t position,
//                                       size_t length, void *user_data);
type
  Ttox_file_chunk_request_cb = procedure(tox: TTox; friend_number: Cardinal;
    file_number: Cardinal; position: UInt64; length: NativeUInt; user_data: Pointer); cdecl;

(**
 * Set the callback for the `file_chunk_request` event. Pass NULL to unset.
 *
 * This event is triggered when Core is ready to send more file data.
 *)
//void tox_callback_file_chunk_request(Tox *tox, tox_file_chunk_request_cb *callback, void *user_data);
procedure tox_callback_file_chunk_request(tox: TTox; callback: Ttox_file_chunk_request_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;



(*******************************************************************************
 *
 * :: File transmission: receiving
 *
 ******************************************************************************)



(**
 * The client should acquire resources to be associated with the file transfer.
 * Incoming file transfers start in the PAUSED state. After this callback
 * returns, a transfer can be rejected by sending a TOX_FILE_CONTROL_CANCEL
 * control command before any other control commands. It can be accepted by
 * sending TOX_FILE_CONTROL_RESUME.
 *
 * @param friend_number The friend number of the friend who is sending the file
 *   transfer request.
 * @param file_number The friend-specific file number the data received is
 *   associated with.
 * @param kind The meaning of the file to be sent.
 * @param file_size Size in bytes of the file the client wants to send,
 *   UINT64_MAX if unknown or streaming.
 * @param filename Name of the file. Does not need to be the actual name. This
 *   name will be sent along with the file send request.
 * @param filename_length Size in bytes of the filename.
 *)
//typedef void tox_file_recv_cb(Tox *tox, uint32_t friend_number, uint32_t file_number, uint32_t kind, uint64_t file_size,
//                              const uint8_t *filename, size_t filename_length, void *user_data);
type
  Ttox_file_recv_cb = procedure(tox: TTox; friend_number: Cardinal; file_number: Cardinal;
    kind: Cardinal; file_size: UInt64; const filename: PByte; filename_lenght: NativeUInt;
    user_data: Pointer); cdecl;

(**
 * Set the callback for the `file_recv` event. Pass NULL to unset.
 *
 * This event is triggered when a file transfer request is received.
 *)
//void tox_callback_file_recv(Tox *tox, tox_file_recv_cb *callback, void *user_data);
procedure tox_callback_file_recv(toc: TTox; callback: Ttox_file_recv_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;

(**
 * When length is 0, the transfer is finished and the client should release the
 * resources it acquired for the transfer. After a call with length = 0, the
 * file number can be reused for new file transfers.
 *
 * If position is equal to file_size (received in the file_receive callback)
 * when the transfer finishes, the file was received completely. Otherwise, if
 * file_size was UINT64_MAX, streaming ended successfully when length is 0.
 *
 * @param friend_number The friend number of the friend who is sending the file.
 * @param file_number The friend-specific file number the data received is
 *   associated with.
 * @param position The file position of the first byte in data.
 * @param data A byte array containing the received chunk.
 * @param length The length of the received chunk.
 *)
//typedef void tox_file_recv_chunk_cb(Tox *tox, uint32_t friend_number, uint32_t file_number, uint64_t position,
//                                    const uint8_t *data, size_t length, void *user_data);
type
  Ttox_file_recv_chunk_cb = procedure(tox: TTox; friend_number: Cardinal;
    file_number: Cardinal; position: UInt64; const data: PByte; length: NativeUInt;
    user_data: Pointer); cdecl;

(**
 * Set the callback for the `file_recv_chunk` event. Pass NULL to unset.
 *
 * This event is first triggered when a file transfer request is received, and
 * subsequently when a chunk of file data for an accepted request was received.
 *)
//void tox_callback_file_recv_chunk(Tox *tox, tox_file_recv_chunk_cb *callback, void *user_data);
procedure tox_callback_file_recv_chunk(tox: TTox; callback: Ttox_file_recv_chunk_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;



(*******************************************************************************
 *
 * :: Group chat management
 *
 ******************************************************************************)




(*******************************************************************************
 *
 * :: Group chat message sending and receiving
 *
 ******************************************************************************)




(*******************************************************************************
 *
 * :: Low-level custom packet sending and receiving
 *
 ******************************************************************************)



//typedef enum TOX_ERR_FRIEND_CUSTOM_PACKET {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_FRIEND_CUSTOM_PACKET_OK,
//
//    /**
//     * One of the arguments to the function was NULL when it was not expected.
//     */
//    TOX_ERR_FRIEND_CUSTOM_PACKET_NULL,
//
//    /**
//     * The friend number did not designate a valid friend.
//     */
//    TOX_ERR_FRIEND_CUSTOM_PACKET_FRIEND_NOT_FOUND,
//
//    /**
//     * This client is currently not connected to the friend.
//     */
//    TOX_ERR_FRIEND_CUSTOM_PACKET_FRIEND_NOT_CONNECTED,
//
//    /**
//     * The first byte of data was not in the specified range for the packet type.
//     * This range is 200-254 for lossy, and 160-191 for lossless packets.
//     */
//    TOX_ERR_FRIEND_CUSTOM_PACKET_INVALID,
//
//    /**
//     * Attempted to send an empty packet.
//     */
//    TOX_ERR_FRIEND_CUSTOM_PACKET_EMPTY,
//
//    /**
//     * Packet data length exceeded TOX_MAX_CUSTOM_PACKET_SIZE.
//     */
//    TOX_ERR_FRIEND_CUSTOM_PACKET_TOO_LONG,
//
//    /**
//     * Packet queue is full.
//     */
//    TOX_ERR_FRIEND_CUSTOM_PACKET_SENDQ,
//
//} TOX_ERR_FRIEND_CUSTOM_PACKET;
type
  TToxErrFriendCustomPacket = (
    (**
     * The function returned successfully.
     *)
    efcpOk,

    (**
     * One of the arguments to the function was NULL when it was not expected.
     *)
    efcpNULL,

    (**
     * The friend number did not designate a valid friend.
     *)
    efcpFriendNotFound,

    (**
     * This client is currently not connected to the friend.
     *)
    efcpFriendNotConnected,

    (**
     * The first byte of data was not in the specified range for the packet type.
     * This range is 200-254 for lossy, and 160-191 for lossless packets.
     *)
    efcpInvalid,

    (**
     * Attempted to send an empty packet.
     *)
    efcpEmpty,

    (**
     * Packet data length exceeded TOX_MAX_CUSTOM_PACKET_SIZE.
     *)
    efcpPacketTooLong,

    (**
     * Packet queue is full.
     *)
    efcpSendq
  );

(**
 * Send a custom lossy packet to a friend.
 *
 * The first byte of data must be in the range 200-254. Maximum length of a
 * custom packet is TOX_MAX_CUSTOM_PACKET_SIZE.
 *
 * Lossy packets behave like UDP packets, meaning they might never reach the
 * other side or might arrive more than once (if someone is messing with the
 * connection) or might arrive in the wrong order.
 *
 * Unless latency is an issue, it is recommended that you use lossless custom
 * packets instead.
 *
 * @param friend_number The friend number of the friend this lossy packet
 *   should be sent to.
 * @param data A byte array containing the packet data.
 * @param length The length of the packet data byte array.
 *
 * @return true on success.
 *)
//bool tox_friend_send_lossy_packet(Tox *tox, uint32_t friend_number, const uint8_t *data, size_t length,
//                                  TOX_ERR_FRIEND_CUSTOM_PACKET *error);
function tox_friend_send_lossy_packet(tox: TTox; friend_number: Cardinal;
  const data: PByte; length: NativeUInt; var error: TToxErrFriendCustomPacket): Boolean; cdecl; external TOX_LIBRARY;

(**
 * Send a custom lossless packet to a friend.
 *
 * The first byte of data must be in the range 160-191. Maximum length of a
 * custom packet is TOX_MAX_CUSTOM_PACKET_SIZE.
 *
 * Lossless packet behaviour is comparable to TCP (reliability, arrive in order)
 * but with packets instead of a stream.
 *
 * @param friend_number The friend number of the friend this lossless packet
 *   should be sent to.
 * @param data A byte array containing the packet data.
 * @param length The length of the packet data byte array.
 *
 * @return true on success.
 *)
//bool tox_friend_send_lossless_packet(Tox *tox, uint32_t friend_number, const uint8_t *data, size_t length,
//                                     TOX_ERR_FRIEND_CUSTOM_PACKET *error);
function tox_friend_send_lossless_packet(tox: TTox; friend_number: Cardinal;
  const data: PByte; length: NativeUInt; var error: TToxErrFriendCustomPacket): Boolean; cdecl; external TOX_LIBRARY;

(**
 * @param friend_number The friend number of the friend who sent a lossy packet.
 * @param data A byte array containing the received packet data.
 * @param length The length of the packet data byte array.
 *)
//typedef void tox_friend_lossy_packet_cb(Tox *tox, uint32_t friend_number, const uint8_t *data, size_t length,
//                                        void *user_data);
type
  Ttox_friend_lossy_packet_cb = procedure(tox: TTox; friend_number: Cardinal;
    const data: PByte; length: NativeUInt; user_data: Pointer); cdecl;

(**
 * Set the callback for the `friend_lossy_packet` event. Pass NULL to unset.
 *
 *)
//void tox_callback_friend_lossy_packet(Tox *tox, tox_friend_lossy_packet_cb *callback, void *user_data);
procedure tox_callback_friend_lossy_packet(tox: TTox; callback: Ttox_friend_lossy_packet_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;

(**
 * @param friend_number The friend number of the friend who sent the packet.
 * @param data A byte array containing the received packet data.
 * @param length The length of the packet data byte array.
 *)
//typedef void tox_friend_lossless_packet_cb(Tox *tox, uint32_t friend_number, const uint8_t *data, size_t length,
//        void *user_data);
type
  Ttox_friend_lossless_packet_cb = procedure(tox: TTox; friend_number: Cardinal;
    const data: PByte; length: NativeUInt; user_data: Pointer); cdecl;

(**
 * Set the callback for the `friend_lossless_packet` event. Pass NULL to unset.
 *
 *)
//void tox_callback_friend_lossless_packet(Tox *tox, tox_friend_lossless_packet_cb *callback, void *user_data);
procedure tox_callback_friend_lossless_packet(tox: TTox; callback: Ttox_friend_lossless_packet_cb;
  user_data: Pointer); cdecl; external TOX_LIBRARY;



(*******************************************************************************
 *
 * :: Low-level network information
 *
 ******************************************************************************)



(**
 * Writes the temporary DHT public key of this instance to a byte array.
 *
 * This can be used in combination with an externally accessible IP address and
 * the bound port (from tox_self_get_udp_port) to run a temporary bootstrap node.
 *
 * Be aware that every time a new instance is created, the DHT public key
 * changes, meaning this cannot be used to run a permanent bootstrap node.
 *
 * @param dht_id A memory region of at least TOX_PUBLIC_KEY_SIZE bytes. If this
 *   parameter is NULL, this function has no effect.
 *)
//void tox_self_get_dht_id(const Tox *tox, uint8_t *dht_id);
procedure tox_self_get_dht_id(const tox: TTox; dht_id: PByte); cdecl; external TOX_LIBRARY;

//typedef enum TOX_ERR_GET_PORT {
//
//    /**
//     * The function returned successfully.
//     */
//    TOX_ERR_GET_PORT_OK,
//
//    /**
//     * The instance was not bound to any port.
//     */
//    TOX_ERR_GET_PORT_NOT_BOUND,
//
//} TOX_ERR_GET_PORT;
type
  TToxErrGetPort = (
    (**
     * The function returned successfully.
     *)
    egpOk,

    (**
     * The instance was not bound to any port.
     *)
    egpNotBound
  );

(**
 * Return the UDP port this Tox instance is bound to.
 *)
//uint16_t tox_self_get_udp_port(const Tox *tox, TOX_ERR_GET_PORT *error);
function tox_self_get_udp_port(const tox: TTox; var error: TToxErrGetPort): Word; cdecl; external TOX_LIBRARY;

(**
 * Return the TCP port this Tox instance is bound to. This is only relevant if
 * the instance is acting as a TCP relay.
 *)
//uint16_t tox_self_get_tcp_port(const Tox *tox, TOX_ERR_GET_PORT *error);
function tox_self_get_tcp_port(tox: TTox; var error: TToxErrGetPort): Word; cdecl; external TOX_LIBRARY;



// include from tox_old.h (916b6aa on 11 Mar 2015)

(* Group chat types for tox_callback_group_invite function.
 *
 * TOX_GROUPCHAT_TYPE_TEXT groupchats must be accepted with the tox_join_groupchat() function.
 * The function to accept TOX_GROUPCHAT_TYPE_AV is in toxav.
 *)
//enum {
//    TOX_GROUPCHAT_TYPE_TEXT,
//    TOX_GROUPCHAT_TYPE_AV
//};
type
  TToxGroupchatType = (
    gtText,
    gtAV
  );

(* Set the callback for group invites.
 *
 *  Function(Tox *tox, int32_t friendnumber, uint8_t type, const uint8_t *data, uint16_t length, void *userdata)
 *
 * data of length is what needs to be passed to join_groupchat().
 *
 * for what type means see the enum right above this comment.
 *)
//void tox_callback_group_invite(Tox *tox, void (*function)(Tox *tox, int32_t, uint8_t, const uint8_t *, uint16_t,
//                               void *), void *userdata);
type
  TProcGroupInvite = procedure(tox: TTox; FriendNumber: Integer; const group_type: Byte;
    const data: PByte; length: Word; userdata: Pointer); cdecl;

procedure tox_callback_group_invite(tox: TTox; callback: TProcGroupInvite;
  userdata: Pointer); cdecl; external TOX_LIBRARY;

(* Set the callback for group messages.
 *
 *  Function(Tox *tox, int groupnumber, int peernumber, const uint8_t * message, uint16_t length, void *userdata)
 *)
//void tox_callback_group_message(Tox *tox, void (*function)(Tox *tox, int, int, const uint8_t *, uint16_t, void *),
//                                void *userdata);
type
  TProcGroupMessage = procedure(tox: TTox; groupnumber: Integer; peernumber: Integer;
    const message: PByte; length: Word; userdata: Pointer); cdecl;

procedure tox_callback_group_message(tox: TTox; callback: TProcGroupMessage;
  userdata: Pointer); cdecl; external TOX_LIBRARY;

(* Set the callback for group actions.
 *
 *  Function(Tox *tox, int groupnumber, int peernumber, const uint8_t * action, uint16_t length, void *userdata)
 *)
//void tox_callback_group_action(Tox *tox, void (*function)(Tox *tox, int, int, const uint8_t *, uint16_t, void *),
//                               void *userdata);
type
  TProcGroupAction = procedure(tox: TTox; groupnumber: Integer; peernumber: Integer;
    const action: PByte; length: Word; userdata: Pointer); cdecl;

procedure tox_callback_group_action(tox: TTox; callback: TProcGroupAction;
  userdata: Pointer); cdecl; external TOX_LIBRARY;

(* Set callback function for title changes.
 *
 * Function(Tox *tox, int groupnumber, int peernumber, uint8_t * title, uint8_t length, void *userdata)
 * if peernumber == -1, then author is unknown (e.g. initial joining the group)
 *)
//void tox_callback_group_title(Tox *tox, void (*function)(Tox *tox, int, int, const uint8_t *, uint8_t,
//                              void *), void *userdata);
type
  TProcGroupTitle = procedure(tox: TTox; groupnumber: Integer; peernumber: Integer;
    title: PByte; length: Word; userdata: Pointer); cdecl;

procedure tox_callback_group_title(tox: TTox; callback: TProcGroupTitle;
  userdata: Pointer); cdecl; external TOX_LIBRARY;

(* Set callback function for peer name list changes.
 *
 * It gets called every time the name list changes(new peer/name, deleted peer)
 *  Function(Tox *tox, int groupnumber, int peernumber, TOX_CHAT_CHANGE change, void *userdata)
 *)
//typedef enum {
//    TOX_CHAT_CHANGE_PEER_ADD,
//    TOX_CHAT_CHANGE_PEER_DEL,
//    TOX_CHAT_CHANGE_PEER_NAME,
//} TOX_CHAT_CHANGE;
//
//void tox_callback_group_namelist_change(Tox *tox, void (*function)(Tox *tox, int, int, uint8_t, void *),
//                                        void *userdata);
type
  TToxChatChange = (
    ccpAdd,
    ccpDel,
    ccpName
  );

  TProcGroupNamelistChange = procedure(tox: TTox; groupnumber: Integer;
    peernumber: Integer; change: TToxChatChange; userdata: Pointer); cdecl;

procedure tox_callback_group_namelist_change(tox: TTox; callback: TProcGroupNamelistChange;
  userdata: Pointer); cdecl; external TOX_LIBRARY;

(* Creates a new groupchat and puts it in the chats array.
 *
 * return group number on success.
 * return -1 on failure.
 *)
//int tox_add_groupchat(Tox *tox);
function tox_add_groupchat(tox: TTox): Integer; cdecl; external TOX_LIBRARY;

(* Delete a groupchat from the chats array.
 *
 * return 0 on success.
 * return -1 if failure.
 *)
//int tox_del_groupchat(Tox *tox, int groupnumber);
function tox_del_groupchat(tox: TTox; groupnumber: Integer): Integer; cdecl; external TOX_LIBRARY;

(* Copy the name of peernumber who is in groupnumber to name.
 * name must be at least TOX_MAX_NAME_LENGTH long.
 *
 * return length of name if success
 * return -1 if failure
 *)
//int tox_group_peername(const Tox *tox, int groupnumber, int peernumber, uint8_t *name);
function tox_group_peername(const tox: TTox; groupnumber: Integer;
  peernumber: Integer; name: PByte): Integer; cdecl; external TOX_LIBRARY;

(* Copy the public key of peernumber who is in groupnumber to public_key.
 * public_key must be TOX_PUBLIC_KEY_SIZE long.
 *
 * returns 0 on success
 * returns -1 on failure
 *)
//int tox_group_peer_pubkey(const Tox *tox, int groupnumber, int peernumber, uint8_t *public_key);
function tox_group_peer_pubkey(const tox: TTox; groupnumber: Integer;
  peernumber: Integer; public_key: PByte): Integer; cdecl; external TOX_LIBRARY;

(* invite friendnumber to groupnumber
 * return 0 on success
 * return -1 on failure
 *)
//int tox_invite_friend(Tox *tox, int32_t friendnumber, int groupnumber);
function tox_invite_friend(tox: TTox; friendnumber: Integer;
  groupnumber: Integer): Integer; cdecl; external TOX_LIBRARY;

(* Join a group (you need to have been invited first.) using data of length obtained
 * in the group invite callback.
 *
 * returns group number on success
 * returns -1 on failure.
 *)
//int tox_join_groupchat(Tox *tox, int32_t friendnumber, const uint8_t *data, uint16_t length);
function tox_join_groupchat(tox: TTox; friendnumber: Integer; const data: PByte;
  length: Word): Integer; cdecl; external TOX_LIBRARY;

(* send a group message
 * return 0 on success
 * return -1 on failure
 *)
//int tox_group_message_send(Tox *tox, int groupnumber, const uint8_t *message, uint16_t length);
function tox_group_message_send(tox: TTox; groupnumber: Integer; const message: PByte;
  length: Word): Integer; cdecl; external TOX_LIBRARY;

(* send a group action
 * return 0 on success
 * return -1 on failure
 *)
//int tox_group_action_send(Tox *tox, int groupnumber, const uint8_t *action, uint16_t length);
function tox_group_action_send(tox: TTox; GroupNumber: Integer; const action: PByte;
  length: Word): Integer; cdecl; external TOX_LIBRARY;

(* set the group's title, limited to MAX_NAME_LENGTH
 * return 0 on success
 * return -1 on failure
 *)
//int tox_group_set_title(Tox *tox, int groupnumber, const uint8_t *title, uint8_t length);
function tox_group_set_title(tox: TTox; groupnumber: Integer; const title: PByte;
  length: Word): Integer; cdecl; external TOX_LIBRARY;

(* Get group title from groupnumber and put it in title.
 * title needs to be a valid memory location with a max_length size of at least MAX_NAME_LENGTH (128) bytes.
 *
 *  return length of copied title if success.
 *  return -1 if failure.
 *)
//int tox_group_get_title(Tox *tox, int groupnumber, uint8_t *title, uint32_t max_length);
function tox_group_get_title(tox: TTox; groupnumber: Integer; title: PByte;
  max_length: Cardinal): Integer; cdecl; external TOX_LIBRARY;

(* Check if the current peernumber corresponds to ours.
 *
 * return 1 if the peernumber corresponds to ours.
 * return 0 on failure.
 *)
//unsigned int tox_group_peernumber_is_ours(const Tox *tox, int groupnumber, int peernumber);
function tox_group_peernumber_is_ours(const tox: TTox; groupnumber: Integer;
  peernumber: Integer): Cardinal; cdecl; external TOX_LIBRARY;

(* Return the number of peers in the group chat on success.
 * return -1 on failure
 *)
//int tox_group_number_peers(const Tox *tox, int groupnumber);
function tox_group_number_peers(tox: TTox; groupnumber: Integer): Integer; cdecl; external TOX_LIBRARY;

(* List all the peers in the group chat.
 *
 * Copies the names of the peers to the name[length][TOX_MAX_NAME_LENGTH] array.
 *
 * Copies the lengths of the names to lengths[length]
 *
 * returns the number of peers on success.
 *
 * return -1 on failure.
 *)
//int tox_group_get_names(const Tox *tox, int groupnumber, uint8_t names[][TOX_MAX_NAME_LENGTH], uint16_t lengths[],
//                        uint16_t length);
function tox_group_get_names(Tox: TTox; groupnumber: Integer; names: PByte;
  length: PWord): Integer; cdecl; external TOX_LIBRARY;
  //TODO: Change param 'names' in function 'tox_group_get_names'
  //TODO: Validate param 'length' in function 'tox_group_get_names'

(* Return the number of chats in the instance m.
 * You should use this to determine how much memory to allocate
 * for copy_chatlist. *)
//uint32_t tox_count_chatlist(const Tox *tox);
function tox_count_chatlist(const tox: TTox): Cardinal; cdecl; external TOX_LIBRARY;

(* Copy a list of valid chat IDs into the array out_list.
 * If out_list is NULL, returns 0.
 * Otherwise, returns the number of elements copied.
 * If the array was too small, the contents
 * of out_list will be truncated to list_size. *)
//uint32_t tox_get_chatlist(const Tox *tox, int32_t *out_list, uint32_t list_size);
function tox_get_chatlist(tox: TTox; out_list: PInteger; list_size: Cardinal): Cardinal; cdecl; external TOX_LIBRARY;

(* return the type of groupchat (TOX_GROUPCHAT_TYPE_) that groupnumber is.
 *
 * return -1 on failure.
 * return type on success.
 *)
//int tox_group_get_type(const Tox *tox, int groupnumber);
function tox_group_get_type(const tox: TTox; groupnumber: Integer): Integer; cdecl; external TOX_LIBRARY;



// include from toxdns.h (4290241 on 7 Oct 2014)

(* Clients are encouraged to set this as the maximum length names can have. *)
//#define TOXDNS_MAX_RECOMMENDED_NAME_LENGTH 32
const
  TOXDNS_MAX_RECOMMENDED_NAME_LENGTH = 32;

(* How to use this api to make secure tox dns3 requests:
 *
 * 1. Get the public key of a server that supports tox dns3.
 * 2. use tox_dns3_new() to create a new object to create DNS requests
 * and handle responses for that server.
 * 3. Use tox_generate_dns3_string() to generate a string based on the name we want to query and a request_id
 * that must be stored somewhere for when we want to decrypt the response.
 * 4. take the string and use it for your DNS request like this:
 * _4haaaaipr1o3mz0bxweox541airydbovqlbju51mb4p0ebxq.rlqdj4kkisbep2ks3fj2nvtmk4daduqiueabmexqva1jc._tox.utox.org
 * 5. The TXT in the DNS you receive should look like this:
 * v=tox3;id=2vgcxuycbuctvauik3plsv3d3aadv4zfjfhi3thaizwxinelrvigchv0ah3qjcsx5qhmaksb2lv2hm5cwbtx0yp
 * 6. Take the id string and use it with tox_decrypt_dns3_TXT() and the request_id corresponding to the
 * request we stored earlier to get the Tox id returned by the DNS server.
 *)

(* Create a new tox_dns3 object for server with server_public_key of size TOX_CLIENT_ID_SIZE.
 *
 * return Null on failure.
 * return pointer object on success.
 *)
//void *tox_dns3_new(uint8_t *server_public_key);
type
  TToxDNS = Pointer;

function tox_dns3_new(server_public_key: PByte): TToxDNS; cdecl; external TOX_DNS_LIBRARY;

(* Destroy the tox dns3 object.
 *)
//void tox_dns3_kill(void *dns3_object);
procedure tox_dns3_kill(dns3_object: TToxDNS); cdecl; external TOX_DNS_LIBRARY;

(* Generate a dns3 string of string_max_len used to query the dns server referred to by to
 * dns3_object for a tox id registered to user with name of name_len.
 *
 * the uint32_t pointed by request_id will be set to the request id which must be passed to
 * tox_decrypt_dns3_TXT() to correctly decode the response.
 *
 * This is what the string returned looks like:
 * 4haaaaipr1o3mz0bxweox541airydbovqlbju51mb4p0ebxq.rlqdj4kkisbep2ks3fj2nvtmk4daduqiueabmexqva1jc
 *
 * returns length of string on success.
 * returns -1 on failure.
 *)
//int tox_generate_dns3_string(void *dns3_object, uint8_t *string, uint16_t string_max_len, uint32_t *request_id,
//                             uint8_t *name, uint8_t name_len);
function tox_generate_dns3_string(dns3_object: TToxDNS; str: PByte; string_max_len: Word;
  request_id: PCardinal; name: PByte; name_len: Byte): Integer; cdecl; external TOX_DNS_LIBRARY;

(* Decode and decrypt the id_record returned of length id_record_len into
 * tox_id (needs to be at least TOX_FRIEND_ADDRESS_SIZE).
 *
 * request_id is the request id given by tox_generate_dns3_string() when creating the request.
 *
 * the id_record passed to this function should look somewhat like this:
 * 2vgcxuycbuctvauik3plsv3d3aadv4zfjfhi3thaizwxinelrvigchv0ah3qjcsx5qhmaksb2lv2hm5cwbtx0yp
 *
 * returns -1 on failure.
 * returns 0 on success.
 *
 *)
//int tox_decrypt_dns3_TXT(void *dns3_object, uint8_t *tox_id, uint8_t *id_record, uint32_t id_record_len,
//                         uint32_t request_id);
function tox_decrypt_dns3_TXT(dns3_object: TToxDNS; tox_id: PByte; id_record: PByte;
  id_record_len: Cardinal; request_id: Cardinal): Integer;  cdecl; external TOX_DNS_LIBRARY;



// include from toxencryptsave.h (d552cd6 on 14 Feb 2016)

const
  TOX_PASS_SALT_LENGTH = 32;
  TOX_PASS_KEY_LENGTH = 32;
  TOX_PASS_ENCRYPTION_EXTRA_LENGTH = 80;



(*******************************************************************************
 *
 * :: API version
 *
 ******************************************************************************)




(**
 * The major version number. Incremented when the API or ABI changes in an
 * incompatible way.
 *)
//#define TOXES_VERSION_MAJOR               0u
const
  TOXES_VERSION_MAJOR_ = 0;

(**
 * The minor version number. Incremented when functionality is added without
 * breaking the API or ABI. Set to 0 when the major version number is
 * incremented.
 *)
//#define TOXES_VERSION_MINOR               0u
const
  TOXES_VERSION_MINOR_ = 0;

(**
 * The patch or revision number. Incremented when bugfixes are applied without
 * changing any functionality or API or ABI.
 *)
//#define TOXES_VERSION_PATCH               0u
const
  TOXES_VERSION_PATCH_ = 0;

(**
 * A macro to check at preprocessing time whether the client code is compatible
 * with the installed version of ToxAV.
 *)
//#define TOXES_VERSION_IS_API_COMPATIBLE(MAJOR, MINOR, PATCH)        \
//  (TOXES_VERSION_MAJOR == MAJOR &&                                \
//   (TOXES_VERSION_MINOR > MINOR ||                                \
//    (TOXES_VERSION_MINOR == MINOR &&                              \
//     TOXES_VERSION_PATCH >= PATCH)))
function TOXES_VERSION_IS_API_COMPATIBLE(MAJOR, MINOR, PATCH: Integer): Boolean;

(**
 * A convenience macro to call toxES_version_is_compatible with the currently
 * compiling API version.
 *)
//#define TOXES_VERSION_IS_ABI_COMPATIBLE()                         \
//  toxes_version_is_compatible(TOXES_VERSION_MAJOR, TOXES_VERSION_MINOR, TOXES_VERSION_PATCH)
function TOXES_VERSION_IS_ABI_COMPATIBLE: Boolean;

(**
 * Return the major version number of the library. Can be used to display the
 * ToxAV library version or to check whether the client is compatible with the
 * dynamically linked version of ToxAV.
 *)
//uint32_t toxes_version_major(void);
function toxes_version_major: Cardinal; cdecl; external TOXES_LIBRARY;

(**
 * Return the minor version number of the library.
 *)
//uint32_t toxes_version_minor(void);
function toxes_version_minor: Cardinal; cdecl; external TOXES_LIBRARY;

(**
 * Return the patch number of the library.
 *)
//uint32_t toxes_version_patch(void);
function toxes_version_patch: Cardinal; cdecl; external TOXES_LIBRARY;

(**
 * Return whether the compiled library version is compatible with the passed
 * version numbers.
 *)
//bool toxes_version_is_compatible(uint32_t major, uint32_t minor, uint32_t patch);
function toxes_version_is_compatible(major, minor, patch: Cardinal): Boolean; cdecl; external TOXES_LIBRARY;

(* This module is conceptually organized into two parts. The first part are the functions
 * with "key" in the name. To use these functions, first derive an encryption key
 * from a password with tox_derive_key_from_pass, and use the returned key to
 * encrypt the data. The second part takes the password itself instead of the key,
 * and then delegates to the first part to derive the key before de/encryption,
 * which can simplify client code; however, key derivation is very expensive
 * compared to the actual encryption, so clients that do a lot of encryption should
 * favor using the first part intead of the second part.
 *
 * The encrypted data is prepended with a magic number, to aid validity checking
 * (no guarantees are made of course). Any data to be decrypted must start with
 * the magic number.
 *
 * Clients should consider alerting their users that, unlike plain data, if even one bit
 * becomes corrupted, the data will be entirely unrecoverable.
 * Ditto if they forget their password, there is no way to recover the data.
 *)

(* Since apparently no one actually bothered to learn about the module previously,
 * the recently removed functions tox_encrypted_new and tox_get_encrypted_savedata
 * may be trivially replaced by calls to tox_pass_decrypt -> tox_new or
 * tox_get_savedata -> tox_pass_encrypt as appropriate. The removed functions
 * were never more than 5 line wrappers of the other public API functions anyways.
 * (As has always been, tox_pass_decrypt and tox_pass_encrypt are interchangeable
 *  with tox_pass_key_decrypt and tox_pass_key_encrypt, as the client program requires.)
 *)

//typedef enum TOX_ERR_KEY_DERIVATION {
//    TOX_ERR_KEY_DERIVATION_OK,
//    /**
//     * Some input data, or maybe the output pointer, was null.
//     */
//    TOX_ERR_KEY_DERIVATION_NULL,
//    /**
//     * The crypto lib was unable to derive a key from the given passphrase,
//     * which is usually a lack of memory issue. The functions accepting keys
//     * do not produce this error.
//     */
//    TOX_ERR_KEY_DERIVATION_FAILED
//} TOX_ERR_KEY_DERIVATION;
type
  TToxErrKeyDerivation = (
    ekdOk,

    (**
     * Some input data, or maybe the output pointer, was null.
     *)
    ekdNULL,

    (**
     * The crypto lib was unable to derive a key from the given passphrase,
     * which is usually a lack of memory issue. The functions accepting keys
     * do not produce this error.
     *)
    ekdFailed
  );

//typedef enum TOX_ERR_ENCRYPTION {
//    TOX_ERR_ENCRYPTION_OK,
//    /**
//     * Some input data, or maybe the output pointer, was null.
//     */
//    TOX_ERR_ENCRYPTION_NULL,
//    /**
//     * The crypto lib was unable to derive a key from the given passphrase,
//     * which is usually a lack of memory issue. The functions accepting keys
//     * do not produce this error.
//     */
//    TOX_ERR_ENCRYPTION_KEY_DERIVATION_FAILED,
//    /**
//     * The encryption itself failed.
//     */
//    TOX_ERR_ENCRYPTION_FAILED
//} TOX_ERR_ENCRYPTION;
type
  PToxErrEncryption = ^TToxErrEncryption;
  TToxErrEncryption = (
    eeOk,

    (**
     * Some input data, or maybe the output pointer, was null.
     *)
    eeNULL,

    (**
     * The crypto lib was unable to derive a key from the given passphrase,
     * which is usually a lack of memory issue. The functions accepting keys
     * do not produce this error.
     *)
    eeKeyDerivationFailed,

    (**
     * The encryption itself failed.
     *)
    eeFailed
  );

//typedef enum TOX_ERR_DECRYPTION {
//    TOX_ERR_DECRYPTION_OK,
//    /**
//     * Some input data, or maybe the output pointer, was null.
//     */
//    TOX_ERR_DECRYPTION_NULL,
//    /**
//     * The input data was shorter than TOX_PASS_ENCRYPTION_EXTRA_LENGTH bytes
//     */
//    TOX_ERR_DECRYPTION_INVALID_LENGTH,
//    /**
//     * The input data is missing the magic number (i.e. wasn't created by this
//     * module, or is corrupted)
//     */
//    TOX_ERR_DECRYPTION_BAD_FORMAT,
//    /**
//     * The crypto lib was unable to derive a key from the given passphrase,
//     * which is usually a lack of memory issue. The functions accepting keys
//     * do not produce this error.
//     */
//    TOX_ERR_DECRYPTION_KEY_DERIVATION_FAILED,
//    /**
//     * The encrypted byte array could not be decrypted. Either the data was
//     * corrupt or the password/key was incorrect.
//     */
//    TOX_ERR_DECRYPTION_FAILED
//} TOX_ERR_DECRYPTION;
type
  TToxErrDecryption = (
    edOk,

    (**
     * Some input data, or maybe the output pointer, was null.
     *)
    edNULL,

    (**
     * The input data was shorter than TOX_PASS_ENCRYPTION_EXTRA_LENGTH bytes
     *)
    edInvalidLength,

    (**
     * The input data is missing the magic number (i.e. wasn't created by this
     * module, or is corrupted
     *)
    edBadFormat,

    (**
     * The crypto lib was unable to derive a key from the given passphrase,
     * which is usually a lack of memory issue. The functions accepting key
     * do not produce this error.
     *)
    edKeyDerivationFailed,

    (**
     * The encrypted byte array could not be decrypted. Either the data was
     * corrupt or the password/key was incorrect.
     *)
    edFailed
  );



(******************************* BEGIN PART 2 *******************************
 * For simplicty, the second part of the module is presented first. The API for
 * the first part is analgous, with some extra functions for key handling. If
 * your code spends too much time using these functions, consider using the part
 * 1 functions instead.
 *)

(* Encrypts the given data with the given passphrase. The output array must be
 * at least data_len + TOX_PASS_ENCRYPTION_EXTRA_LENGTH bytes long. This delegates
 * to tox_derive_key_from_pass and tox_pass_key_encrypt.
 *
 * returns true on success
 *)
//bool tox_pass_encrypt(const uint8_t *data, size_t data_len, const uint8_t *passphrase, size_t pplength, uint8_t *out,
//                      TOX_ERR_ENCRYPTION *error);
function tox_pass_encrypt(data: PByte; data_len: NativeUInt; passphrase: PByte;
  pplength: NativeUInt; out_data: PByte; error: PToxErrEncryption): Boolean; cdecl; external TOXES_LIBRARY;

(* Decrypts the given data with the given passphrase. The output array must be
 * at least data_len - TOX_PASS_ENCRYPTION_EXTRA_LENGTH bytes long. This delegates
 * to tox_pass_key_decrypt.
 *
 * the output data has size data_length - TOX_PASS_ENCRYPTION_EXTRA_LENGTH
 *
 * returns true on success
 *)
//bool tox_pass_decrypt(const uint8_t *data, size_t length, const uint8_t *passphrase, size_t pplength, uint8_t *out,
//                      TOX_ERR_DECRYPTION *error);
function tox_pass_decrypt(const data: PByte; length: NativeUInt; const passphrase: PByte;
  pplength: NativeUInt; out_data: PByte; var error: TToxErrDecryption): Boolean; cdecl; external TOXES_LIBRARY;

(******************************* BEGIN PART 1 *******************************
 * And now part "1", which does the actual encryption, and is rather less cpu
 * intensive than part one. The first 3 functions are for key handling.
 *)

(* This key structure's internals should not be used by any client program, even
 * if they are straightforward here.
 *)
//typedef struct {
//    uint8_t salt[TOX_PASS_SALT_LENGTH];
//    uint8_t key[TOX_PASS_KEY_LENGTH];
//} TOX_PASS_KEY;
type
  TToxPassKey = record
    salt: array[0..TOX_PASS_SALT_LENGTH - 1] of Byte;
    key: array[0..TOX_PASS_KEY_LENGTH - 1] of Byte;
  end;

(* Generates a secret symmetric key from the given passphrase. out_key must be at least
 * TOX_PASS_KEY_LENGTH bytes long.
 * Be sure to not compromise the key! Only keep it in memory, do not write to disk.
 * The password is zeroed after key derivation.
 * The key should only be used with the other functions in this module, as it
 * includes a salt.
 * Note that this function is not deterministic; to derive the same key from a
 * password, you also must know the random salt that was used. See below.
 *
 * returns true on success
 *)
//bool tox_derive_key_from_pass(const uint8_t *passphrase, size_t pplength, TOX_PASS_KEY *out_key,
//                              TOX_ERR_KEY_DERIVATION *error);
function tox_derive_key_from_pass(const passphrase: PByte; pplength: NativeUInt;
  var out_key: TToxPassKey; var error: TToxErrKeyDerivation): Boolean; cdecl; external TOXES_LIBRARY;

(* Same as above, except use the given salt for deterministic key derivation.
 * The salt must be TOX_PASS_SALT_LENGTH bytes in length.
 *)
//bool tox_derive_key_with_salt(const uint8_t *passphrase, size_t pplength, const uint8_t *salt, TOX_PASS_KEY *out_key,
//                              TOX_ERR_KEY_DERIVATION *error);
function tox_derive_key_with_salt(const passphrase: PByte; pplength: NativeUInt;
  const salt: PByte; var out_key: TToxPassKey; var error: TToxErrKeyDerivation): Boolean; cdecl; external TOXES_LIBRARY;

(* This retrieves the salt used to encrypt the given data, which can then be passed to
 * derive_key_with_salt to produce the same key as was previously used. Any encrpyted
 * data with this module can be used as input.
 *
 * returns true if magic number matches
 * success does not say anything about the validity of the data, only that data of
 * the appropriate size was copied
 *)
//bool tox_get_salt(const uint8_t *data, uint8_t *salt);
function tox_get_salt(const data: PByte; salt: PByte): Boolean; cdecl; external TOXES_LIBRARY;

(* Now come the functions that are analogous to the part 2 functions. *)

(* Encrypt arbitrary with a key produced by tox_derive_key_*. The output
 * array must be at least data_len + TOX_PASS_ENCRYPTION_EXTRA_LENGTH bytes long.
 * key must be TOX_PASS_KEY_LENGTH bytes.
 * If you already have a symmetric key from somewhere besides this module, simply
 * call encrypt_data_symmetric in toxcore/crypto_core directly.
 *
 * returns true on success
 *)
//bool tox_pass_key_encrypt(const uint8_t *data, size_t data_len, const TOX_PASS_KEY *key, uint8_t *out,
//                          TOX_ERR_ENCRYPTION *error);
function tox_pass_key_encrypt(const data: PByte; data_len: NativeUInt;
  const key: TToxPassKey; out_data: PByte; var error: TToxErrEncryption): Boolean; cdecl; external TOXES_LIBRARY;

(* This is the inverse of tox_pass_key_encrypt, also using only keys produced by
 * tox_derive_key_from_pass.
 *
 * the output data has size data_length - TOX_PASS_ENCRYPTION_EXTRA_LENGTH
 *
 * returns true on success
 *)
//bool tox_pass_key_decrypt(const uint8_t *data, size_t length, const TOX_PASS_KEY *key, uint8_t *out,
//                          TOX_ERR_DECRYPTION *error);
function tox_pass_key_decrypt(const data: PByte; length: NativeUInt;
  const key: TToxPassKey; out_data: PByte; var error: TToxErrDecryption): Boolean; cdecl; external TOXES_LIBRARY;

(* Determines whether or not the given data is encrypted (by checking the magic number)
 *)
//bool tox_is_data_encrypted(const uint8_t *data);
function tox_is_data_encrypted(const data: PByte): Boolean; cdecl; external TOXES_LIBRARY;



// include from toxav.h (6a494e2 on 3 Nov 2015)



(** \page av Public audio/video API for Tox clients.
 *
 * This API can handle multiple calls. Each call has its state, in very rare
 * occasions the library can change the state of the call without apps knowledge.
 *
 *)

(** \subsection events Events and callbacks
 *
 * As in Core API, events are handled by callbacks. One callback can be
 * registered per event. All events have a callback function type named
 * `toxav_{event}_cb` and a function to register it named `toxav_callback_{event}`.
 * Passing a NULL callback will result in no callback being registered for that
 * event. Only one callback per event can be registered, so if a client needs
 * multiple event listeners, it needs to implement the dispatch functionality
 * itself. Unlike Core API, lack of some event handlers will cause the the
 * library to drop calls before they are started. Hanging up call from a
 * callback causes undefined behaviour.
 *
 *)

(** \subsection threading Threading implications
 *
 * Unlike the Core API, this API is fully thread-safe. The library will ensure
 * the proper synchronization of parallel calls.
 *
 * A common way to run ToxAV (multiple or single instance) is to have a thread,
 * separate from tox instance thread, running a simple toxav_iterate loop,
 * sleeping for toxav_iteration_interval * milliseconds on each iteration.
 *
 * An important thing to note is that events are triggered from both tox and
 * toxav thread (see above). Audio and video receive frame events are triggered
 * from toxav thread while all the other events are triggered from tox thread.
 *
 * Tox thread has priority with mutex mechanisms. Any api function can
 * fail if mutexes are held by tox thread in which case they will set SYNC
 * error code.
 *)

(**
 * External Tox type.
 *)

(**
 * ToxAV.
 *)

(**
 * The ToxAV instance type. Each ToxAV instance can be bound to only one Tox
 * instance, and Tox instance can have only one ToxAV instance. One must make
 * sure to close ToxAV instance prior closing Tox instance otherwise undefined
 * behaviour occurs. Upon closing of ToxAV instance, all active calls will be
 * forcibly terminated without notifying peers.
 *
 *)
type
  TToxAV = Pointer;

(*******************************************************************************
 *
 * :: API version
 *
 ******************************************************************************)
(**
 * The major version number. Incremented when the API or ABI changes in an
 * incompatible way.
 *)
//#define TOXAV_VERSION_MAJOR               0u
const
  TOXAV_VERSION_MAJOR_ = 0;

(**
 * The minor version number. Incremented when functionality is added without
 * breaking the API or ABI. Set to 0 when the major version number is
 * incremented.
 *)
//#define TOXAV_VERSION_MINOR               0u
  TOXAV_VERSION_MINOR_ = 0;

(**
 * The patch or revision number. Incremented when bugfixes are applied without
 * changing any functionality or API or ABI.
 *)
//#define TOXAV_VERSION_PATCH               0u
  TOXAV_VERSION_PATCH_ = 0;

(**
 * A macro to check at preprocessing time whether the client code is compatible
 * with the installed version of ToxAV.
 *)
//#define TOXAV_VERSION_IS_API_COMPATIBLE(MAJOR, MINOR, PATCH)        \
//  (TOXAV_VERSION_MAJOR == MAJOR &&                                \
//   (TOXAV_VERSION_MINOR > MINOR ||                                \
//    (TOXAV_VERSION_MINOR == MINOR &&                              \
//     TOXAV_VERSION_PATCH >= PATCH)))
function TOXAV_VERSION_IS_API_COMPATIBLE(MAJOR, MINOR, PATCH: Integer): Boolean;

(**
 * A convenience macro to call toxav_version_is_compatible with the currently
 * compiling API version.
 *)
//#define TOXAV_VERSION_IS_ABI_COMPATIBLE()                         \
//  toxav_version_is_compatible(TOXAV_VERSION_MAJOR, TOXAV_VERSION_MINOR, TOXAV_VERSION_PATCH)
function TOXAV_VERSION_IS_ABI_COMPATIBLE: Boolean;

(**
 * Return the major version number of the library. Can be used to display the
 * ToxAV library version or to check whether the client is compatible with the
 * dynamically linked version of ToxAV.
 *)
//uint32_t toxav_version_major(void);
function toxav_version_major: Cardinal; cdecl; external TOXAV_LIBRARY;

(**
 * Return the minor version number of the library.
 *)
//uint32_t toxav_version_minor(void);
function toxav_version_minor: Cardinal; cdecl; external TOXAV_LIBRARY;

(**
 * Return the patch number of the library.
 *)
//uint32_t toxav_version_patch(void);
function toxav_version_patch: Cardinal; cdecl; external TOXAV_LIBRARY;

(**
 * Return whether the compiled library version is compatible with the passed
 * version numbers.
 *)
//bool toxav_version_is_compatible(uint32_t major, uint32_t minor, uint32_t patch);
function toxav_version_is_compatible(major, minor, patch: Cardinal): Boolean; cdecl; external TOXAV_LIBRARY;



(*******************************************************************************
 *
 * :: Creation and destruction
 *
 ******************************************************************************)




//typedef enum TOXAV_ERR_NEW {
//    /**
//     * The function returned successfully.
//     */
//    TOXAV_ERR_NEW_OK,
//    /**
//     * One of the arguments to the function was NULL when it was not expected.
//     */
//    TOXAV_ERR_NEW_NULL,
//    /**
//     * Memory allocation failure while trying to allocate structures required for
//     * the A/V session.
//     */
//    TOXAV_ERR_NEW_MALLOC,
//    /**
//     * Attempted to create a second session for the same Tox instance.
//     */
//    TOXAV_ERR_NEW_MULTIPLE,
//} TOXAV_ERR_NEW;
type
  TToxAVErrNew = (
    (**
     * The function returned successfully.
     *)
    avenOk,

    (**
     * One of the arguments to the function was NULL when it was not expected.
     *)
    avenNULL,

    (**
     * Memory allocation failure while trying to allocate structures required for
     * the A/V session.
     *)

    avenMalloc,

    (**
     * Attempted to create a second session for the same Tox instance.
     *)
    avenMultiple
  );

(**
 * Start new A/V session. There can only be only one session per Tox instance.
 *)
//ToxAV *toxav_new(Tox *tox, TOXAV_ERR_NEW *error);
function toxav_new(tox: TTox; var error: TToxAVErrNew): TToxAV; cdecl; external TOXAV_LIBRARY;

(**
 * Releases all resources associated with the A/V session.
 *
 * If any calls were ongoing, these will be forcibly terminated without
 * notifying peers. After calling this function, no other functions may be
 * called and the av pointer becomes invalid.
 *)
//void toxav_kill(ToxAV *toxAV);
procedure toxav_kill(toxAV: TToxAV); cdecl; external TOXAV_LIBRARY;

(**
 * Returns the Tox instance the A/V object was created for.
 *)
//Tox *toxav_get_tox(const ToxAV *toxAV);
function toxav_get_tox(const toxAV: TToxAV): TTox; cdecl; external TOXAV_LIBRARY;



(*******************************************************************************
 *
 * :: A/V event loop
 *
 ******************************************************************************)




(**
 * Returns the interval in milliseconds when the next toxav_iterate call should
 * be. If no call is active at the moment, this function returns 200.
 *)
//uint32_t toxav_iteration_interval(const ToxAV *toxAV);
function toxav_iteration_interval(const toxAV: TToxAV): Cardinal; cdecl; external TOXAV_LIBRARY;

(**
 * Main loop for the session. This function needs to be called in intervals of
 * toxav_iteration_interval() milliseconds. It is best called in the separate
 * thread from tox_iterate.
 *)
//void toxav_iterate(ToxAV *toxAV);
procedure toxav_iterate(toxAV: TToxAV); cdecl; external TOXAV_LIBRARY;



(*******************************************************************************
 *
 * :: Call setup
 *
 ******************************************************************************)
//typedef enum TOXAV_ERR_CALL {
//    /**
//     * The function returned successfully.
//     */
//    TOXAV_ERR_CALL_OK,
//    /**
//     * A resource allocation error occurred while trying to create the structures
//     * required for the call.
//     */
//    TOXAV_ERR_CALL_MALLOC,
//    /**
//     * Synchronization error occurred.
//     */
//    TOXAV_ERR_CALL_SYNC,
//    /**
//     * The friend number did not designate a valid friend.
//     */
//    TOXAV_ERR_CALL_FRIEND_NOT_FOUND,
//    /**
//     * The friend was valid, but not currently connected.
//     */
//    TOXAV_ERR_CALL_FRIEND_NOT_CONNECTED,
//    /**
//     * Attempted to call a friend while already in an audio or video call with
//     * them.
//     */
//    TOXAV_ERR_CALL_FRIEND_ALREADY_IN_CALL,
//    /**
//     * Audio or video bit rate is invalid.
//     */
//    TOXAV_ERR_CALL_INVALID_BIT_RATE,
//} TOXAV_ERR_CALL;
type
  TToxAVErrCall = (
    (**
     * The function returned successfully.
     *)
    avecOk,

    (**
     * A resource allocation error occurred while trying to create the structures
     * required for the call.
     *)
    avecMalloc,

    (**
     * Synchronization error occurred.
     *)
    avecSync,

    (**
     * The friend number did not designate a valid friend.
     *)
    avecFriendNotFound,

    (**
     * The friend was valid, but not currently connected.
     *)
    avecFriendNotConnected,

    (**
     * Attempted to call a friend while already in an audio or video call with
     * them.
     *)
    avecFriendAlreadyInCall,

    (**
     * Audio or video bit rate is invalid.
     *)
    avecInvalidBitRate
  );

(**
 * Call a friend. This will start ringing the friend.
 *
 * It is the client's responsibility to stop ringing after a certain timeout,
 * if such behaviour is desired. If the client does not stop ringing, the
 * library will not stop until the friend is disconnected. Audio and video
 * receiving are both enabled by default.
 *
 * @param friend_number The friend number of the friend that should be called.
 * @param audio_bit_rate Audio bit rate in Kb/sec. Set this to 0 to disable
 * audio sending.
 * @param video_bit_rate Video bit rate in Kb/sec. Set this to 0 to disable
 * video sending.
 *)
//bool toxav_call(ToxAV *toxAV, uint32_t friend_number, uint32_t audio_bit_rate,
//                uint32_t video_bit_rate, TOXAV_ERR_CALL *error);
function toxav_call(toxAV: TToxAV; friend_number: Cardinal; audio_bit_rate: Cardinal;
  video_bit_rate: Cardinal; var error: TToxAVErrCall): Boolean; cdecl; external TOXAV_LIBRARY;

(**
 * The function type for the call callback.
 *
 * @param friend_number The friend number from which the call is incoming.
 * @param audio_enabled True if friend is sending audio.
 * @param video_enabled True if friend is sending video.
 *)
//typedef void toxav_call_cb(ToxAV *toxAV, uint32_t friend_number, bool audio_enabled,
//                           bool video_enabled, void *user_data);
type
  Ttoxav_call_cb = procedure(toxAV: TToxAV; friend_number: Cardinal; audio_enabled: Boolean;
    video_enabled: Boolean; user_data: Pointer); cdecl;

(**
 * Set the callback for the `call` event. Pass NULL to unset.
 *
 *)
//void toxav_callback_call(ToxAV *toxAV, toxav_call_cb *callback, void *user_data);
procedure toxav_callback_call(toxAV: TToxAV; callback: Ttoxav_call_cb;
  user_data: Pointer); cdecl; external TOXAV_LIBRARY;

//typedef enum TOXAV_ERR_ANSWER {
//    /**
//     * The function returned successfully.
//     */
//    TOXAV_ERR_ANSWER_OK,
//    /**
//     * Synchronization error occurred.
//     */
//    TOXAV_ERR_ANSWER_SYNC,
//    /**
//     * Failed to initialize codecs for call session. Note that codec initiation
//     * will fail if there is no receive callback registered for either audio or
//     * video.
//     */
//    TOXAV_ERR_ANSWER_CODEC_INITIALIZATION,
//    /**
//     * The friend number did not designate a valid friend.
//     */
//    TOXAV_ERR_ANSWER_FRIEND_NOT_FOUND,
//    /**
//     * The friend was valid, but they are not currently trying to initiate a call.
//     * This is also returned if this client is already in a call with the friend.
//     */
//    TOXAV_ERR_ANSWER_FRIEND_NOT_CALLING,
//    /**
//     * Audio or video bit rate is invalid.
//     */
//    TOXAV_ERR_ANSWER_INVALID_BIT_RATE,
//} TOXAV_ERR_ANSWER;
type
  TToxAVErrAnswer = (
    (**
     * The function returned successfully.
     *)
    aveaOk,

    (**
     * Synchronization error occurred.
     *)
    aveaSync,

    (**
     * Failed to initialize codecs for call session. Note that codec initiation
     * will fail if there is no receive callback registered for either audio or
     * video.
     *)
    aveaCodecInitialization,

    (**
     * The friend number did not designate a valid friend.
     *)
    aveaFriendNotFound,

    (**
     * The friend was valid, but they are not currently trying to initiate a call.
     * This is also returned if this client is already in a call with the friend.
     *)
    aveaFriendNotCalling,

    (**
     * Audio or video bit rate is invalid.
     *)
    aveaInvalidBitrate
  );

(**
 * Accept an incoming call.
 *
 * If answering fails for any reason, the call will still be pending and it is
 * possible to try and answer it later. Audio and video receiving are both
 * enabled by default.
 *
 * @param friend_number The friend number of the friend that is calling.
 * @param audio_bit_rate Audio bit rate in Kb/sec. Set this to 0 to disable
 * audio sending.
 * @param video_bit_rate Video bit rate in Kb/sec. Set this to 0 to disable
 * video sending.
 *)
//bool toxav_answer(ToxAV *toxAV, uint32_t friend_number, uint32_t audio_bit_rate, uint32_t video_bit_rate,
//                  TOXAV_ERR_ANSWER *error);
function toxav_answer(toxAV: TToxAV; friend_number: Cardinal; audio_bit_rate: Cardinal;
  video_bit_rate: Cardinal; var error: TToxAVErrAnswer): Boolean; cdecl; external TOXAV_LIBRARY;



(*******************************************************************************
 *
 * :: Call state graph
 *
 ******************************************************************************)

//enum TOXAV_FRIEND_CALL_STATE {
//    /**
//     * Set by the AV core if an error occurred on the remote end or if friend
//     * timed out. This is the final state after which no more state
//     * transitions can occur for the call. This call state will never be triggered
//     * in combination with other call states.
//     */
//    TOXAV_FRIEND_CALL_STATE_ERROR = 1,
//    /**
//     * The call has finished. This is the final state after which no more state
//     * transitions can occur for the call. This call state will never be
//     * triggered in combination with other call states.
//     */
//    TOXAV_FRIEND_CALL_STATE_FINISHED = 2,
//    /**
//     * The flag that marks that friend is sending audio.
//     */
//    TOXAV_FRIEND_CALL_STATE_SENDING_A = 4,
//    /**
//     * The flag that marks that friend is sending video.
//     */
//    TOXAV_FRIEND_CALL_STATE_SENDING_V = 8,
//    /**
//     * The flag that marks that friend is receiving audio.
//     */
//    TOXAV_FRIEND_CALL_STATE_ACCEPTING_A = 16,
//    /**
//     * The flag that marks that friend is receiving video.
//     */
//    TOXAV_FRIEND_CALL_STATE_ACCEPTING_V = 32,
//};
type
  TToxAVFriendCallState = (
    (**
     * Set by the AV core if an error occurred on the remote end or if friend
     * timed out. This is the final state after which no more state
     * transitions can occur for the call. This call state will never be triggered
     * in combination with other call states.
     *)
    fcsError = 1,

    (**
     * The call has finished. This is the final state after which no more state
     * transitions can occur for the call. This call state will never be
     * triggered in combination with other call states.
     *)
    fcsFinished = 2,

    (**
     * The flag that marks that friend is sending audio.
     *)
    fcsSendingA = 4,

    (**
     * The flag that marks that friend is sending video.
     *)
    fcsSendingV = 8,

    (**
     * The flag that marks that friend is receiving audio.
     *)
    fcsAcceptingA = 16,

    (**
     * The flag that marks that friend is receiving video.
     *)
    fcsAcceptingV = 32
  );

(**
 * The function type for the call_state callback.
 *
 * @param friend_number The friend number for which the call state changed.
 * @param state The bitmask of the new call state which is guaranteed to be
 * different than the previous state. The state is set to 0 when the call is
 * paused. The bitmask represents all the activities currently performed by the
 * friend.
 *)
//typedef void toxav_call_state_cb(ToxAV *toxAV, uint32_t friend_number, uint32_t state, void *user_data);
type
  Ttoxav_call_state_cb = procedure(toxAV: TToxAV; friend_number: Cardinal;
    state: Cardinal; user_data: Pointer); cdecl;

(**
 * Set the callback for the `call_state` event. Pass NULL to unset.
 *
 *)
//void toxav_callback_call_state(ToxAV *toxAV, toxav_call_state_cb *callback, void *user_data);
procedure toxav_callback_call_state(toxAV: TToxAV; callback: Ttoxav_call_state_cb;
  user_data: Pointer); cdecl; external TOXAV_LIBRARY;



(*******************************************************************************
 *
 * :: Call control
 *
 ******************************************************************************)
//typedef enum TOXAV_CALL_CONTROL {
//    /**
//     * Resume a previously paused call. Only valid if the pause was caused by this
//     * client, if not, this control is ignored. Not valid before the call is accepted.
//     */
//    TOXAV_CALL_CONTROL_RESUME,
//    /**
//     * Put a call on hold. Not valid before the call is accepted.
//     */
//    TOXAV_CALL_CONTROL_PAUSE,
//    /**
//     * Reject a call if it was not answered, yet. Cancel a call after it was
//     * answered.
//     */
//    TOXAV_CALL_CONTROL_CANCEL,
//    /**
//     * Request that the friend stops sending audio. Regardless of the friend's
//     * compliance, this will cause the audio_receive_frame event to stop being
//     * triggered on receiving an audio frame from the friend.
//     */
//    TOXAV_CALL_CONTROL_MUTE_AUDIO,
//    /**
//     * Calling this control will notify client to start sending audio again.
//     */
//    TOXAV_CALL_CONTROL_UNMUTE_AUDIO,
//    /**
//     * Request that the friend stops sending video. Regardless of the friend's
//     * compliance, this will cause the video_receive_frame event to stop being
//     * triggered on receiving a video frame from the friend.
//     */
//    TOXAV_CALL_CONTROL_HIDE_VIDEO,
//    /**
//     * Calling this control will notify client to start sending video again.
//     */
//    TOXAV_CALL_CONTROL_SHOW_VIDEO,
//} TOXAV_CALL_CONTROL;
type
  TToxAVCallControl = (
    (**
     * Resume a previously paused call. Only valid if the pause was caused by this
     * client, if not, this control is ignored. Not valid before the call is accepted.
     *)
    avccResume,

    (**
     * Put a call on hold. Not valid before the call is accepted.
     *)
    avccPause,

    (**
     * Reject a call if it was not answered, yet. Cancel a call after it was
     * answered
     *)
    avccCancel,

    (**
     * Request that the friend stops sending audio. Regardless of the friend's
     * compliance, this will cause the audio_receive_frame event to stop being
     * triggered on receiving an audio frame from the friend.
     *)
    avccMuteAudio,

    (**
     * Calling this control will notify client to start sending audio again.
     *)
    avccUnmuteAudio,

    (**
     * Request that the friend stops sending video. Regardless of the friend's
     * compliance, this will cause the video_receive_frame event to stop being
     * triggered on receiving a video frame from the friend.
     *)
    avccHideVideo,

    (**
     * Calling this control will notify client to start sending video again.
     *)
    avccShowVideo
  );

//typedef enum TOXAV_ERR_CALL_CONTROL {
//    /**
//     * The function returned successfully.
//     */
//    TOXAV_ERR_CALL_CONTROL_OK,
//    /**
//     * Synchronization error occurred.
//     */
//    TOXAV_ERR_CALL_CONTROL_SYNC,
//    /**
//     * The friend_number passed did not designate a valid friend.
//     */
//    TOXAV_ERR_CALL_CONTROL_FRIEND_NOT_FOUND,
//    /**
//     * This client is currently not in a call with the friend. Before the call is
//     * answered, only CANCEL is a valid control.
//     */
//    TOXAV_ERR_CALL_CONTROL_FRIEND_NOT_IN_CALL,
//    /**
//     * Happens if user tried to pause an already paused call or if trying to
//     * resume a call that is not paused.
//     */
//    TOXAV_ERR_CALL_CONTROL_INVALID_TRANSITION,
//} TOXAV_ERR_CALL_CONTROL;
type
  TToxAVErrCallControl = (
    (**
     * The function returned successfully.
     *)
    eccOk,

    (**
     * Synchronization error occurred.
     *)
    eccSync,

    (**
     * The friend_number passed did not designate a valid friend.
     *)
    eccFriendNotFound,

    (**
     * This client is currently not in a call with the friend. Before the call is
     * answered, only CANCEL is a valid control.
     *)
    eccFriendNotInCall,

    (**
     * Happens if user tried to pause an already paused call or if trying to
     * resume a call that is not paused.
     *)
    eccInvalidTransition
  );

(**
 * Sends a call control command to a friend.
 *
 * @param friend_number The friend number of the friend this client is in a call
 * with.
 * @param control The control command to send.
 *
 * @return true on success.
 *)
//bool toxav_call_control(ToxAV *toxAV, uint32_t friend_number, TOXAV_CALL_CONTROL control,
//                        TOXAV_ERR_CALL_CONTROL *error);
function toxav_call_control(toxAV: TToxAV; friend_number: Cardinal;
  control: TToxAVCallControl; var Error: TToxAVErrCallControl): Boolean; cdecl; external TOXAV_LIBRARY;



(*******************************************************************************
 *
 * :: Controlling bit rates
 *
 ******************************************************************************)
//typedef enum TOXAV_ERR_BIT_RATE_SET {
//    /**
//     * The function returned successfully.
//     */
//    TOXAV_ERR_BIT_RATE_SET_OK,
//    /**
//     * Synchronization error occurred.
//     */
//    TOXAV_ERR_BIT_RATE_SET_SYNC,
//    /**
//     * The audio bit rate passed was not one of the supported values.
//     */
//    TOXAV_ERR_BIT_RATE_SET_INVALID_AUDIO_BIT_RATE,
//    /**
//     * The video bit rate passed was not one of the supported values.
//     */
//    TOXAV_ERR_BIT_RATE_SET_INVALID_VIDEO_BIT_RATE,
//    /**
//     * The friend_number passed did not designate a valid friend.
//     */
//    TOXAV_ERR_BIT_RATE_SET_FRIEND_NOT_FOUND,
//    /**
//     * This client is currently not in a call with the friend.
//     */
//    TOXAV_ERR_BIT_RATE_SET_FRIEND_NOT_IN_CALL,
//} TOXAV_ERR_BIT_RATE_SET;
type
  TToxAVErrBitRateSet = (
    (**
     * The function returned successfully.
     *)
    ebsOk,

    (**
     * Synchronization error occurred.
     *)
    ebsSync,

    (**
     * The audio bit rate passed was not one of the supported values.
     *)
    ebsInvalidAudioBitRate,

    (**
     * The video bit rate passed was not one of the supported values.
     *)
    ebsInvalidVideoBitRate,

    (**
     * The friend_number passed did not designate a valid friend.
     *)
    ebsFriendNotFound,

    (**
     * This client is currently not in a call with the friend.
     *)
    ebsFriendNotInCall
  );

(**
 * Set the bit rate to be used in subsequent audio/video frames.
 *
 * @param friend_number The friend number of the friend for which to set the
 * bit rate.
 * @param audio_bit_rate The new audio bit rate in Kb/sec. Set to 0 to disable
 * audio sending. Set to -1 to leave unchanged.
 * @param video_bit_rate The new video bit rate in Kb/sec. Set to 0 to disable
 * video sending. Set to -1 to leave unchanged.
 *
 *)
//bool toxav_bit_rate_set(ToxAV *toxAV, uint32_t friend_number, int32_t audio_bit_rate,
//                        int32_t video_bit_rate, TOXAV_ERR_BIT_RATE_SET *error);
function toxav_bit_rate_set(toxAV: TToxAV; friend_number: Cardinal; audio_bit_rate: Cardinal;
  video_bit_rate: Cardinal; var error: TToxAVErrBitRateSet): Boolean; cdecl; external TOXAV_LIBRARY;

(**
 * The function type for the bit_rate_status callback. The event is triggered
 * when the network becomes too saturated for current bit rates at which
 * point core suggests new bit rates.
 *
 * @param friend_number The friend number of the friend for which to set the
 * bit rate.
 * @param audio_bit_rate Suggested maximum audio bit rate in Kb/sec.
 * @param video_bit_rate Suggested maximum video bit rate in Kb/sec.
 *)
//typedef void toxav_bit_rate_status_cb(ToxAV *toxAV, uint32_t friend_number, uint32_t audio_bit_rate,
//                                      uint32_t video_bit_rate, void *user_data);
type
  Ttoxav_bit_rate_status_cb = procedure(toxAV: TToxAV; friend_number: Cardinal;
    audio_bit_rate: Cardinal; video_bit_rate: Cardinal; user_data: Pointer); cdecl;

(**
 * Set the callback for the `bit_rate_status` event. Pass NULL to unset.
 *
 *)
//void toxav_callback_bit_rate_status(ToxAV *toxAV, toxav_bit_rate_status_cb *callback, void *user_data);
procedure toxav_callback_bit_rate_status(toxAV: TToxAV; callback: Ttoxav_bit_rate_status_cb;
  user_data: Pointer); cdecl; external TOXAV_LIBRARY;



(*******************************************************************************
 *
 * :: A/V sending
 *
 ******************************************************************************)
//typedef enum TOXAV_ERR_SEND_FRAME {
//    /**
//     * The function returned successfully.
//     */
//    TOXAV_ERR_SEND_FRAME_OK,
//    /**
//     * In case of video, one of Y, U, or V was NULL. In case of audio, the samples
//     * data pointer was NULL.
//     */
//    TOXAV_ERR_SEND_FRAME_NULL,
//    /**
//     * The friend_number passed did not designate a valid friend.
//     */
//    TOXAV_ERR_SEND_FRAME_FRIEND_NOT_FOUND,
//    /**
//     * This client is currently not in a call with the friend.
//     */
//    TOXAV_ERR_SEND_FRAME_FRIEND_NOT_IN_CALL,
//    /**
//     * Synchronization error occurred.
//     */
//    TOXAV_ERR_SEND_FRAME_SYNC,
//    /**
//     * One of the frame parameters was invalid. E.g. the resolution may be too
//     * small or too large, or the audio sampling rate may be unsupported.
//     */
//    TOXAV_ERR_SEND_FRAME_INVALID,
//    /**
//     * Either friend turned off audio or video receiving or we turned off sending
//     * for the said payload.
//     */
//    TOXAV_ERR_SEND_FRAME_PAYLOAD_TYPE_DISABLED,
//    /**
//     * Failed to push frame through rtp interface.
//     */
//    TOXAV_ERR_SEND_FRAME_RTP_FAILED,
//} TOXAV_ERR_SEND_FRAME;
type
  TToxAVErrSendFrame = (
    (**
     * The function returned successfully.
     *)
    esfOk,

    (**
     * In case of video, one of Y, U, or V was NULL. In case of audio, the samples
     * data pointer was NULL.
     *)
    esfNULL,

    (**
     * The friend_number passed did not designate a valid friend.
     *)
    esfFriendNotFound,

    (**
     * This client is currently not in a call with the friend.
     *)
    esfFriendNotInCall,

    (**
     * Synchronization error occurred.
     *)
    esfSync,

    (**
     * One of the frame parameters was invalid. E.g. the resolution may be too
     * small or too large, or the audio sampling rate may be unsupported
     *)
    esfInvalid,

    (**
     * Either friend turned off audio or video receiving or we turned off sending
     * for the said payload
     *)
    esfPayloadTypeDisabled,

    (**
     * Failed to push frame through rtp interface.
     *)
    esfRTPFailed
  );

(**
 * Send an audio frame to a friend.
 *
 * The expected format of the PCM data is: [s1c1][s1c2][...][s2c1][s2c2][...]...
 * Meaning: sample 1 for channel 1, sample 1 for channel 2, ...
 * For mono audio, this has no meaning, every sample is subsequent. For stereo,
 * this means the expected format is LRLRLR... with samples for left and right
 * alternating.
 *
 * @param friend_number The friend number of the friend to which to send an
 * audio frame.
 * @param pcm An array of audio samples. The size of this array must be
 * sample_count * channels.
 * @param sample_count Number of samples in this frame. Valid numbers here are
 * ((sample rate) * (audio length) / 1000), where audio length can be
 * 2.5, 5, 10, 20, 40 or 60 millseconds.
 * @param channels Number of audio channels. Supported values are 1 and 2.
 * @param sampling_rate Audio sampling rate used in this frame. Valid sampling
 * rates are 8000, 12000, 16000, 24000, or 48000.
 *)
//bool toxav_audio_send_frame(ToxAV *toxAV, uint32_t friend_number, const int16_t *pcm,
//                            size_t sample_count, uint8_t channels, uint32_t sampling_rate,
//                            TOXAV_ERR_SEND_FRAME *error);
function toxav_audio_send_frame(toxAV: TToxAV; friend_number: Cardinal;
  const pcm: PWord; sample_count: NativeUInt; channels: Byte; sampling_rate: Cardinal;
  var error: TToxAVErrSendFrame): Boolean; cdecl; external TOXAV_LIBRARY;

(**
 * Send a video frame to a friend.
 *
 * Y - plane should be of size: height * width
 * U - plane should be of size: (height/2) * (width/2)
 * V - plane should be of size: (height/2) * (width/2)
 *
 * @param friend_number The friend number of the friend to which to send a video
 * frame.
 * @param width Width of the frame in pixels.
 * @param height Height of the frame in pixels.
 * @param y Y (Luminance) plane data.
 * @param u U (Chroma) plane data.
 * @param v V (Chroma) plane data.
 *)
//bool toxav_video_send_frame(ToxAV *toxAV, uint32_t friend_number, uint16_t width,
//                            uint16_t height, const uint8_t *y, const uint8_t *u, const uint8_t *v,
//                            TOXAV_ERR_SEND_FRAME *error);
function toxav_video_send_frame(toxAV: TToxAV; friend_number: Cardinal; width,
  height: Word; const y: PByte; const u: PByte; const v: PByte;
  var error: TToxAVErrSendFrame): Boolean; cdecl; external TOXAV_LIBRARY;



(*******************************************************************************
 *
 * :: A/V receiving
 *
 ******************************************************************************)
(**
 * The function type for the audio_receive_frame callback. The callback can be
 * called multiple times per single iteration depending on the amount of queued
 * frames in the buffer. The received format is the same as in send function.
 *
 * @param friend_number The friend number of the friend who sent an audio frame.
 * @param pcm An array of audio samples (sample_count * channels elements).
 * @param sample_count The number of audio samples per channel in the PCM array.
 * @param channels Number of audio channels.
 * @param sampling_rate Sampling rate used in this frame.
 *
 *)
//typedef void toxav_audio_receive_frame_cb(ToxAV *toxAV, uint32_t friend_number, const int16_t *pcm,
//        size_t sample_count, uint8_t channels, uint32_t sampling_rate,
//        void *user_data);
type
  Ttoxav_audio_receive_frame_cb = procedure(tox: TToxAV; friend_number: Cardinal;
    const pcm: PWord; sample_count: NativeUInt; channels: Byte;
    sampling_rate: Cardinal; user_data: Pointer); cdecl;

(**
 * Set the callback for the `audio_receive_frame` event. Pass NULL to unset.
 *
 *)
//void toxav_callback_audio_receive_frame(ToxAV *toxAV, toxav_audio_receive_frame_cb *callback, void *user_data);
procedure toxav_callback_audio_receive_frame(toxAV: TToxAV;
  callback: Ttoxav_audio_receive_frame_cb; user_data: Pointer); cdecl; external TOXAV_LIBRARY;

(**
 * The function type for the video_receive_frame callback.
 *
 * @param friend_number The friend number of the friend who sent a video frame.
 * @param width Width of the frame in pixels.
 * @param height Height of the frame in pixels.
 * @param y
 * @param u
 * @param v Plane data.
 *          The size of plane data is derived from width and height where
 *          Y = MAX(width, abs(ystride)) * height,
 *          U = MAX(width/2, abs(ustride)) * (height/2) and
 *          V = MAX(width/2, abs(vstride)) * (height/2).
 * @param ystride
 * @param ustride
 * @param vstride Strides data. Strides represent padding for each plane
 *                that may or may not be present. You must handle strides in
 *                your image processing code. Strides are negative if the
 *                image is bottom-up hence why you MUST abs() it when
 *                calculating plane buffer size.
 *)
//typedef void toxav_video_receive_frame_cb(ToxAV *toxAV, uint32_t friend_number, uint16_t width,
//        uint16_t height, const uint8_t *y, const uint8_t *u, const uint8_t *v,
//        int32_t ystride, int32_t ustride, int32_t vstride, void *user_data);
type
  Ttoxav_video_receive_frame_cb = procedure(toxAV: TToxAV; friend_number: Cardinal;
    width, height: Word; const y: PByte; const u: PByte; const v: PByte;
    ystride, ustride, vstride: Integer; user_data: Pointer); cdecl;

(**
 * Set the callback for the `video_receive_frame` event. Pass NULL to unset.
 *
 *)
//void toxav_callback_video_receive_frame(ToxAV *toxAV, toxav_video_receive_frame_cb *callback, void *user_data);
procedure toxav_callback_video_receive_frame(toxAV: TToxAV;
  callback: Ttoxav_video_receive_frame_cb; user_data: Pointer); cdecl; external TOXAV_LIBRARY;




(**
 * NOTE Compatibility with old toxav group calls TODO remove
 *)
(* Create a new toxav group.
 *
 * return group number on success.
 * return -1 on failure.
 *
 * Audio data callback format:
 *   audio_callback(Tox *tox, int groupnumber, int peernumber, const int16_t *pcm, unsigned int samples, uint8_t channels, unsigned int sample_rate, void *userdata)
 *
 * Note that total size of pcm in bytes is equal to (samples * channels * sizeof(int16_t)).
 *)
//int toxav_add_av_groupchat(Tox *tox, void (*audio_callback)(void *, int, int, const int16_t *, unsigned int, uint8_t,
//                           unsigned int, void *), void *userdata);
type
  TProcAddAVGroupchat = procedure(tox: TTox; groupnumber, peernumber: Integer;
    const pcm: PWord; samples: Cardinal; channels: Byte; sample_rate: Cardinal;
    userdata: Pointer); cdecl;

function toxav_add_av_groupchat(tox: TTox; callback: TProcAddAVGroupchat;
  userdata: Pointer): Integer; cdecl; external TOXAV_LIBRARY;

(* Join a AV group (you need to have been invited first.)
 *
 * returns group number on success
 * returns -1 on failure.
 *
 * Audio data callback format (same as the one for toxav_add_av_groupchat()):
 *   audio_callback(Tox *tox, int groupnumber, int peernumber, const int16_t *pcm, unsigned int samples, uint8_t channels, unsigned int sample_rate, void *userdata)
 *
 * Note that total size of pcm in bytes is equal to (samples * channels * sizeof(int16_t)).
 *)
//int toxav_join_av_groupchat(Tox *tox, int32_t friendnumber, const uint8_t *data, uint16_t length,
//                            void (*audio_callback)(void *, int, int, const int16_t *, unsigned int, uint8_t, unsigned int, void *), void *userdata);
type
  TProxJoinAVGroupchat = procedure(tox: TTox; groupnumber, peernumber: Integer;
    const pcm: PWord; samples: Cardinal; channels: Byte; sample_rate: Cardinal;
    userdata: Pointer); cdecl;

function toxav_join_av_groupchat(tox: TTox; friendnumber: Integer; const data: PByte;
  length: Word; callback: TProxJoinAVGroupchat; userdata: Pointer): Integer; cdecl; external TOXAV_LIBRARY;

(* Send audio to the group chat.
 *
 * return 0 on success.
 * return -1 on failure.
 *
 * Note that total size of pcm in bytes is equal to (samples * channels * sizeof(int16_t)).
 *
 * Valid number of samples are ((sample rate) * (audio length (Valid ones are: 2.5, 5, 10, 20, 40 or 60 ms)) / 1000)
 * Valid number of channels are 1 or 2.
 * Valid sample rates are 8000, 12000, 16000, 24000, or 48000.
 *
 * Recommended values are: samples = 960, channels = 1, sample_rate = 48000
 *)
//int toxav_group_send_audio(Tox *tox, int groupnumber, const int16_t *pcm, unsigned int samples, uint8_t channels,
//                           unsigned int sample_rate);
function toxav_group_send_audio(tox: TTox; groupnumber: Integer; const pcm: PWord;
  samples: Cardinal; channels: Byte; sample_rate: Cardinal): Integer; cdecl; external TOXAV_LIBRARY;







implementation

//  (TOX_VERSION_MAJOR == MAJOR &&                                \
  //   (TOX_VERSION_MINOR > MINOR ||                                \
  //    (TOX_VERSION_MINOR == MINOR &&                              \
  //     TOX_VERSION_PATCH >= PATCH)))
function TOX_VERSION_IS_API_COMPATIBLE(MAJOR, MINOR, PATCH: Integer): Boolean;
begin
  Result := ((TOX_VERSION_MAJOR_ = MAJOR) and
    ((TOX_VERSION_MINOR_ > MINOR) or
    ((TOX_VERSION_MINOR_ = MINOR) and
    (TOX_VERSION_PATCH_ >= PATCH))));
end;

function TOXES_VERSION_IS_API_COMPATIBLE(MAJOR, MINOR, PATCH: Integer): Boolean;
begin
  Result := ((TOXES_VERSION_MAJOR_ = MAJOR) and
    ((TOXES_VERSION_MINOR_ > MINOR) or
    ((TOXES_VERSION_MINOR_ = MINOR) and
    (TOXES_VERSION_PATCH_ >= PATCH))));
end;

function TOXES_VERSION_IS_ABI_COMPATIBLE: Boolean;
begin
  Result := toxes_version_is_compatible(TOXES_VERSION_MAJOR_,
    TOXES_VERSION_MINOR_, TOXES_VERSION_PATCH_)
end;

function TOXAV_VERSION_IS_API_COMPATIBLE(MAJOR, MINOR, PATCH: Integer): Boolean;
begin
  Result := ((TOXAV_VERSION_MAJOR_ = MAJOR) and
    ((TOXAV_VERSION_MINOR_ > MINOR) or
    ((TOXAV_VERSION_MINOR_ = MINOR) and
    (TOXAV_VERSION_PATCH_ >= PATCH))));
end;

function TOXAV_VERSION_IS_ABI_COMPATIBLE: Boolean;
begin
  Result := toxav_version_is_compatible(TOXAV_VERSION_MAJOR_,
    TOXAV_VERSION_MINOR_, TOXAV_VERSION_PATCH_);
end;

initialization

end.

