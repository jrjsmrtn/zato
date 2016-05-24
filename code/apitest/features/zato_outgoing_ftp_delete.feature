@outgoing
@outgoing.ftp
Feature: zato.outgoing.ftp.delete
  Deletes an outgoing FTP connection by its ID.

  @outgoing.ftp.delete
    Scenario: Create FTP definition
    Given address "$ZATO_API_TEST_SERVER"
    Given Basic Auth "$ZATO_API_TEST_PUBAPI_USER" "$ZATO_API_TEST_PUBAPI_PASSWORD"

    Given URL path "/zato/json/zato.outgoing.ftp.create"

    Given format "JSON"
    Given request is "{}"
    Given JSON Pointer "/cluster_id" in request is "$ZATO_API_TEST_CLUSTER_ID"
    Given JSON Pointer "/name" in request is a random string
    Given JSON Pointer "/is_active" in request is "true"
    Given JSON Pointer "/host" in request is "ftp.gnupg.dk"
    Given JSON Pointer "/port" in request is "21"
    Given JSON Pointer "/dircache" in request is "true"
    Given JSON Pointer "/user" in request is "anonymous"
    Given JSON Pointer "/timeout" in request is "2000"

    When the URL is invoked

    Then status is "200"
    And JSON Pointer "/zato_env/result" is "ZATO_OK"

    And I store "/zato_outgoing_ftp_create_response/id" from response under "def_id"
    And JSON Pointer "/zato_outgoing_ftp_create_response/id" is any integer
    And I sleep for "2"


  @outgoing.ftp.delete
  Scenario: Delete created ftp connection

    Given address "$ZATO_API_TEST_SERVER"
    Given Basic Auth "$ZATO_API_TEST_PUBAPI_USER" "$ZATO_API_TEST_PUBAPI_PASSWORD"

    Given URL path "/zato/json/zato.outgoing.ftp.delete"
    Given format "JSON"
    Given request is "{}"
    Given JSON Pointer "/id" in request is "#def_id"

    When the URL is invoked

    Then status is "200"
    And JSON Pointer "/zato_env/result" is "ZATO_OK"