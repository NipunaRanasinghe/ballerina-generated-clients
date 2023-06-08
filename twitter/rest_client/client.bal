import ballerina/http;

# Twitter API v2 available endpoints
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api.twitter.com") returns error? {
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }
    # List Compliance Jobs
    #
    # + 'type - Type of Compliance Job to list.
    # + status - Status of Compliance Job to list.
    # + compliance_jobFields - A comma separated list of ComplianceJob fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/compliance/jobs("tweets"|"users" 'type, "created"|"in_progress"|"failed"|"complete"? status = (), ("created_at"|"download_expires_at"|"download_url"|"id"|"name"|"resumable"|"status"|"type"|"upload_expires_at"|"upload_url")[]? compliance_jobFields = ()) returns Get2ComplianceJobsResponse|error {
        string resourcePath = string `/2/compliance/jobs`;
        map<anydata> queryParam = {"type": 'type, "status": status, "compliance_job.fields": compliance_jobFields};
        map<Encoding> queryParamEncoding = {"compliance_job.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2ComplianceJobsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create compliance job
    #
    # + return - The request has succeeded. 
    resource isolated function post '2/compliance/jobs(CreateComplianceJobRequest payload) returns CreateComplianceJobResponse|error {
        string resourcePath = string `/2/compliance/jobs`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CreateComplianceJobResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get Compliance Job
    #
    # + id - The ID of the Compliance Job to retrieve.
    # + compliance_jobFields - A comma separated list of ComplianceJob fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/compliance/jobs/[JobId id](("created_at"|"download_expires_at"|"download_url"|"id"|"name"|"resumable"|"status"|"type"|"upload_expires_at"|"upload_url")[]? compliance_jobFields = ()) returns Get2ComplianceJobsIdResponse|error {
        string resourcePath = string `/2/compliance/jobs/${getEncodedUri(id)}`;
        map<anydata> queryParam = {"compliance_job.fields": compliance_jobFields};
        map<Encoding> queryParamEncoding = {"compliance_job.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2ComplianceJobsIdResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a new DM Conversation
    #
    # + return - The request has succeeded. 
    resource isolated function post '2/dm_conversations(CreateDmConversationRequest payload) returns CreateDmEventResponse|error {
        string resourcePath = string `/2/dm_conversations`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CreateDmEventResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get DM Events for a DM Conversation
    #
    # + participant_id - The ID of the participant user for the One to One DM conversation.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get a specified 'page' of results.
    # + event_types - The set of event_types to include in the results.
    # + dm_eventFields - A comma separated list of DmEvent fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/dm_conversations/with/[UserId participant_id]/dm_events(int:Signed32 max_results = 100, PaginationToken32? pagination_token = (), ("MessageCreate"|"ParticipantsJoin"|"ParticipantsLeave")[] event_types = ["MessageCreate","ParticipantsLeave","ParticipantsJoin"], ("attachments"|"created_at"|"dm_conversation_id"|"event_type"|"id"|"participant_ids"|"referenced_tweets"|"sender_id"|"text")[]? dm_eventFields = (), ("attachments.media_keys"|"participant_ids"|"referenced_tweets.id"|"sender_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2DmConversationsWithParticipantIdDmEventsResponse|error {
        string resourcePath = string `/2/dm_conversations/with/${getEncodedUri(participant_id)}/dm_events`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "event_types": event_types, "dm_event.fields": dm_eventFields, "expansions": expansions, "media.fields": mediaFields, "user.fields": userFields, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"event_types": {style: FORM, explode: false}, "dm_event.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2DmConversationsWithParticipantIdDmEventsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Send a new message to a user
    #
    # + participant_id - The ID of the recipient user that will receive the DM.
    # + return - The request has succeeded. 
    resource isolated function post '2/dm_conversations/with/[UserId participant_id]/messages(CreateMessageRequest payload) returns CreateDmEventResponse|error {
        string resourcePath = string `/2/dm_conversations/with/${getEncodedUri(participant_id)}/messages`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CreateDmEventResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Send a new message to a DM Conversation
    #
    # + dm_conversation_id - The DM Conversation ID.
    # + return - The request has succeeded. 
    resource isolated function post '2/dm_conversations/[string dm_conversation_id]/messages(CreateMessageRequest payload) returns CreateDmEventResponse|error {
        string resourcePath = string `/2/dm_conversations/${getEncodedUri(dm_conversation_id)}/messages`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        CreateDmEventResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get DM Events for a DM Conversation
    #
    # + id - The DM Conversation ID.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get a specified 'page' of results.
    # + event_types - The set of event_types to include in the results.
    # + dm_eventFields - A comma separated list of DmEvent fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/dm_conversations/[DmConversationId id]/dm_events(int:Signed32 max_results = 100, PaginationToken32? pagination_token = (), ("MessageCreate"|"ParticipantsJoin"|"ParticipantsLeave")[] event_types = ["MessageCreate","ParticipantsLeave","ParticipantsJoin"], ("attachments"|"created_at"|"dm_conversation_id"|"event_type"|"id"|"participant_ids"|"referenced_tweets"|"sender_id"|"text")[]? dm_eventFields = (), ("attachments.media_keys"|"participant_ids"|"referenced_tweets.id"|"sender_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2DmConversationsIdDmEventsResponse|error {
        string resourcePath = string `/2/dm_conversations/${getEncodedUri(id)}/dm_events`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "event_types": event_types, "dm_event.fields": dm_eventFields, "expansions": expansions, "media.fields": mediaFields, "user.fields": userFields, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"event_types": {style: FORM, explode: false}, "dm_event.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2DmConversationsIdDmEventsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get recent DM Events
    #
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get a specified 'page' of results.
    # + event_types - The set of event_types to include in the results.
    # + dm_eventFields - A comma separated list of DmEvent fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/dm_events(int:Signed32 max_results = 100, PaginationToken32? pagination_token = (), ("MessageCreate"|"ParticipantsJoin"|"ParticipantsLeave")[] event_types = ["MessageCreate","ParticipantsLeave","ParticipantsJoin"], ("attachments"|"created_at"|"dm_conversation_id"|"event_type"|"id"|"participant_ids"|"referenced_tweets"|"sender_id"|"text")[]? dm_eventFields = (), ("attachments.media_keys"|"participant_ids"|"referenced_tweets.id"|"sender_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2DmEventsResponse|error {
        string resourcePath = string `/2/dm_events`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "event_types": event_types, "dm_event.fields": dm_eventFields, "expansions": expansions, "media.fields": mediaFields, "user.fields": userFields, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"event_types": {style: FORM, explode: false}, "dm_event.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2DmEventsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create List
    #
    # + return - The request has succeeded. 
    resource isolated function post '2/lists(ListCreateRequest payload) returns ListCreateResponse|error {
        string resourcePath = string `/2/lists`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ListCreateResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # List lookup by List ID.
    #
    # + id - The ID of the List.
    # + listFields - A comma separated list of List fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + userFields - A comma separated list of User fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/lists/[ListId id](("created_at"|"description"|"follower_count"|"id"|"member_count"|"name"|"owner_id"|"private")[]? listFields = (), ("owner_id")[]? expansions = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = ()) returns Get2ListsIdResponse|error {
        string resourcePath = string `/2/lists/${getEncodedUri(id)}`;
        map<anydata> queryParam = {"list.fields": listFields, "expansions": expansions, "user.fields": userFields};
        map<Encoding> queryParamEncoding = {"list.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2ListsIdResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update List.
    #
    # + id - The ID of the List to modify.
    # + return - The request has succeeded. 
    resource isolated function put '2/lists/[ListId id](ListUpdateRequest payload) returns ListUpdateResponse|error {
        string resourcePath = string `/2/lists/${getEncodedUri(id)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ListUpdateResponse response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete List
    #
    # + id - The ID of the List to delete.
    # + return - The request has succeeded. 
    resource isolated function delete '2/lists/[ListId id]() returns ListDeleteResponse|error {
        string resourcePath = string `/2/lists/${getEncodedUri(id)}`;
        ListDeleteResponse response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Returns User objects that follow a List by the provided List ID
    #
    # + id - The ID of the List.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get a specified 'page' of results.
    # + userFields - A comma separated list of User fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/lists/[ListId id]/followers(int:Signed32 max_results = 100, PaginationTokenLong? pagination_token = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("pinned_tweet_id")[]? expansions = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2ListsIdFollowersResponse|error {
        string resourcePath = string `/2/lists/${getEncodedUri(id)}/followers`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "user.fields": userFields, "expansions": expansions, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"user.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2ListsIdFollowersResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Returns User objects that are members of a List by the provided List ID.
    #
    # + id - The ID of the List.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get a specified 'page' of results.
    # + userFields - A comma separated list of User fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/lists/[ListId id]/members(int:Signed32 max_results = 100, PaginationTokenLong? pagination_token = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("pinned_tweet_id")[]? expansions = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2ListsIdMembersResponse|error {
        string resourcePath = string `/2/lists/${getEncodedUri(id)}/members`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "user.fields": userFields, "expansions": expansions, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"user.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2ListsIdMembersResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add a List member
    #
    # + id - The ID of the List for which to add a member.
    # + return - The request has succeeded. 
    resource isolated function post '2/lists/[ListId id]/members(ListAddUserRequest payload) returns ListMutateResponse|error {
        string resourcePath = string `/2/lists/${getEncodedUri(id)}/members`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ListMutateResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Remove a List member
    #
    # + id - The ID of the List to remove a member.
    # + user_id - The ID of User that will be removed from the List.
    # + return - The request has succeeded. 
    resource isolated function delete '2/lists/[ListId id]/members/[UserId user_id]() returns ListMutateResponse|error {
        string resourcePath = string `/2/lists/${getEncodedUri(id)}/members/${getEncodedUri(user_id)}`;
        ListMutateResponse response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # List Tweets timeline by List ID.
    #
    # + id - The ID of the List.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get the next 'page' of results.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/lists/[ListId id]/tweets(int:Signed32 max_results = 100, PaginationToken36? pagination_token = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns Get2ListsIdTweetsResponse|error {
        string resourcePath = string `/2/lists/${getEncodedUri(id)}/tweets`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2ListsIdTweetsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Returns the OpenAPI Specification document.
    #
    # + return - The request was successful 
    resource isolated function get '2/'openapi\.json() returns json|error {
        string resourcePath = string `/2/openapi.json`;
        json response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Space lookup up Space IDs
    #
    # + ids - The list of Space IDs to return.
    # + spaceFields - A comma separated list of Space fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + userFields - A comma separated list of User fields to display.
    # + topicFields - A comma separated list of Topic fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/spaces(string[] ids, ("created_at"|"creator_id"|"ended_at"|"host_ids"|"id"|"invited_user_ids"|"is_ticketed"|"lang"|"participant_count"|"scheduled_start"|"speaker_ids"|"started_at"|"state"|"subscriber_count"|"title"|"topic_ids"|"updated_at")[]? spaceFields = (), ("creator_id"|"host_ids"|"invited_user_ids"|"speaker_ids"|"topic_ids")[]? expansions = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("description"|"id"|"name")[]? topicFields = ()) returns Get2SpacesResponse|error {
        string resourcePath = string `/2/spaces`;
        map<anydata> queryParam = {"ids": ids, "space.fields": spaceFields, "expansions": expansions, "user.fields": userFields, "topic.fields": topicFields};
        map<Encoding> queryParamEncoding = {"ids": {style: FORM, explode: true}, "space.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "topic.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2SpacesResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Space lookup by their creators
    #
    # + user_ids - The IDs of Users to search through.
    # + spaceFields - A comma separated list of Space fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + userFields - A comma separated list of User fields to display.
    # + topicFields - A comma separated list of Topic fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/spaces/'by/creator_ids(UserId[] user_ids, ("created_at"|"creator_id"|"ended_at"|"host_ids"|"id"|"invited_user_ids"|"is_ticketed"|"lang"|"participant_count"|"scheduled_start"|"speaker_ids"|"started_at"|"state"|"subscriber_count"|"title"|"topic_ids"|"updated_at")[]? spaceFields = (), ("creator_id"|"host_ids"|"invited_user_ids"|"speaker_ids"|"topic_ids")[]? expansions = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("description"|"id"|"name")[]? topicFields = ()) returns Get2SpacesByCreatorIdsResponse|error {
        string resourcePath = string `/2/spaces/by/creator_ids`;
        map<anydata> queryParam = {"user_ids": user_ids, "space.fields": spaceFields, "expansions": expansions, "user.fields": userFields, "topic.fields": topicFields};
        map<Encoding> queryParamEncoding = {"user_ids": {style: FORM, explode: true}, "space.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "topic.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2SpacesByCreatorIdsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Search for Spaces
    #
    # + query - The search query.
    # + state - The state of Spaces to search for.
    # + max_results - The number of results to return.
    # + spaceFields - A comma separated list of Space fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + userFields - A comma separated list of User fields to display.
    # + topicFields - A comma separated list of Topic fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/spaces/search(string query, "live"|"scheduled"|"all" state = "all", int:Signed32 max_results = 100, ("created_at"|"creator_id"|"ended_at"|"host_ids"|"id"|"invited_user_ids"|"is_ticketed"|"lang"|"participant_count"|"scheduled_start"|"speaker_ids"|"started_at"|"state"|"subscriber_count"|"title"|"topic_ids"|"updated_at")[]? spaceFields = (), ("creator_id"|"host_ids"|"invited_user_ids"|"speaker_ids"|"topic_ids")[]? expansions = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("description"|"id"|"name")[]? topicFields = ()) returns Get2SpacesSearchResponse|error {
        string resourcePath = string `/2/spaces/search`;
        map<anydata> queryParam = {"query": query, "state": state, "max_results": max_results, "space.fields": spaceFields, "expansions": expansions, "user.fields": userFields, "topic.fields": topicFields};
        map<Encoding> queryParamEncoding = {"space.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "topic.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2SpacesSearchResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Space lookup by Space ID
    #
    # + id - The ID of the Space to be retrieved.
    # + spaceFields - A comma separated list of Space fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + userFields - A comma separated list of User fields to display.
    # + topicFields - A comma separated list of Topic fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/spaces/[string id](("created_at"|"creator_id"|"ended_at"|"host_ids"|"id"|"invited_user_ids"|"is_ticketed"|"lang"|"participant_count"|"scheduled_start"|"speaker_ids"|"started_at"|"state"|"subscriber_count"|"title"|"topic_ids"|"updated_at")[]? spaceFields = (), ("creator_id"|"host_ids"|"invited_user_ids"|"speaker_ids"|"topic_ids")[]? expansions = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("description"|"id"|"name")[]? topicFields = ()) returns Get2SpacesIdResponse|error {
        string resourcePath = string `/2/spaces/${getEncodedUri(id)}`;
        map<anydata> queryParam = {"space.fields": spaceFields, "expansions": expansions, "user.fields": userFields, "topic.fields": topicFields};
        map<Encoding> queryParamEncoding = {"space.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "topic.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2SpacesIdResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Retrieve the list of Users who purchased a ticket to the given space
    #
    # + id - The ID of the Space to be retrieved.
    # + pagination_token - This parameter is used to get a specified 'page' of results.
    # + max_results - The maximum number of results.
    # + userFields - A comma separated list of User fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/spaces/[string id]/buyers(PaginationToken32? pagination_token = (), int:Signed32 max_results = 100, ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("pinned_tweet_id")[]? expansions = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2SpacesIdBuyersResponse|error {
        string resourcePath = string `/2/spaces/${getEncodedUri(id)}/buyers`;
        map<anydata> queryParam = {"pagination_token": pagination_token, "max_results": max_results, "user.fields": userFields, "expansions": expansions, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"user.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2SpacesIdBuyersResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Retrieve Tweets from a Space.
    #
    # + id - The ID of the Space to be retrieved.
    # + max_results - The number of Tweets to fetch from the provided space. If not provided, the value will default to the maximum of 100.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/spaces/[string id]/tweets(int:Signed32 max_results = 100, ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns Get2SpacesIdTweetsResponse|error {
        string resourcePath = string `/2/spaces/${getEncodedUri(id)}/tweets`;
        map<anydata> queryParam = {"max_results": max_results, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2SpacesIdTweetsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Tweet lookup by Tweet IDs
    #
    # + ids - A comma separated list of Tweet IDs. Up to 100 are allowed in a single request.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets(TweetId[] ids, ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns Get2TweetsResponse|error {
        string resourcePath = string `/2/tweets`;
        map<anydata> queryParam = {"ids": ids, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"ids": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2TweetsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Creation of a Tweet
    #
    # + return - The request has succeeded. 
    resource isolated function post '2/tweets(TweetCreateRequest payload) returns TweetCreateResponse|error {
        string resourcePath = string `/2/tweets`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TweetCreateResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Tweets Compliance stream
    #
    # + backfill_minutes - The number of minutes of backfill requested.
    # + partition - The partition number.
    # + start_time - YYYY-MM-DDTHH:mm:ssZ. The earliest UTC timestamp from which the Tweet Compliance events will be provided.
    # + end_time - YYYY-MM-DDTHH:mm:ssZ. The latest UTC timestamp to which the Tweet Compliance events will be provided.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/compliance/'stream(int:Signed32 partition, int:Signed32? backfill_minutes = (), string? start_time = (), string? end_time = ()) returns TweetComplianceStreamResponse|error {
        string resourcePath = string `/2/tweets/compliance/stream`;
        map<anydata> queryParam = {"backfill_minutes": backfill_minutes, "partition": partition, "start_time": start_time, "end_time": end_time};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        TweetComplianceStreamResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Full archive search counts
    #
    # + query - One query/rule/filter for matching Tweets. Refer to https://t.co/rulelength to identify the max query length.
    # + start_time - YYYY-MM-DDTHH:mm:ssZ. The oldest UTC timestamp (from most recent 7 days) from which the Tweets will be provided. Timestamp is in second granularity and is inclusive (i.e. 12:00:01 includes the first second of the minute).
    # + end_time - YYYY-MM-DDTHH:mm:ssZ. The newest, most recent UTC timestamp to which the Tweets will be provided. Timestamp is in second granularity and is exclusive (i.e. 12:00:01 excludes the first second of the minute).
    # + since_id - Returns results with a Tweet ID greater than (that is, more recent than) the specified ID.
    # + until_id - Returns results with a Tweet ID less than (that is, older than) the specified ID.
    # + next_token - This parameter is used to get the next 'page' of results. The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.
    # + pagination_token - This parameter is used to get the next 'page' of results. The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.
    # + granularity - The granularity for the search counts results.
    # + search_countFields - A comma separated list of SearchCount fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/counts/all(string query, string? start_time = (), string? end_time = (), TweetId? since_id = (), TweetId? until_id = (), PaginationToken36? next_token = (), PaginationToken36? pagination_token = (), "minute"|"hour"|"day" granularity = "hour", ("end"|"start"|"tweet_count")[]? search_countFields = ()) returns Get2TweetsCountsAllResponse|error {
        string resourcePath = string `/2/tweets/counts/all`;
        map<anydata> queryParam = {"query": query, "start_time": start_time, "end_time": end_time, "since_id": since_id, "until_id": until_id, "next_token": next_token, "pagination_token": pagination_token, "granularity": granularity, "search_count.fields": search_countFields};
        map<Encoding> queryParamEncoding = {"search_count.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2TweetsCountsAllResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Recent search counts
    #
    # + query - One query/rule/filter for matching Tweets. Refer to https://t.co/rulelength to identify the max query length.
    # + start_time - YYYY-MM-DDTHH:mm:ssZ. The oldest UTC timestamp (from most recent 7 days) from which the Tweets will be provided. Timestamp is in second granularity and is inclusive (i.e. 12:00:01 includes the first second of the minute).
    # + end_time - YYYY-MM-DDTHH:mm:ssZ. The newest, most recent UTC timestamp to which the Tweets will be provided. Timestamp is in second granularity and is exclusive (i.e. 12:00:01 excludes the first second of the minute).
    # + since_id - Returns results with a Tweet ID greater than (that is, more recent than) the specified ID.
    # + until_id - Returns results with a Tweet ID less than (that is, older than) the specified ID.
    # + next_token - This parameter is used to get the next 'page' of results. The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.
    # + pagination_token - This parameter is used to get the next 'page' of results. The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.
    # + granularity - The granularity for the search counts results.
    # + search_countFields - A comma separated list of SearchCount fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/counts/recent(string query, string? start_time = (), string? end_time = (), TweetId? since_id = (), TweetId? until_id = (), PaginationToken36? next_token = (), PaginationToken36? pagination_token = (), "minute"|"hour"|"day" granularity = "hour", ("end"|"start"|"tweet_count")[]? search_countFields = ()) returns Get2TweetsCountsRecentResponse|error {
        string resourcePath = string `/2/tweets/counts/recent`;
        map<anydata> queryParam = {"query": query, "start_time": start_time, "end_time": end_time, "since_id": since_id, "until_id": until_id, "next_token": next_token, "pagination_token": pagination_token, "granularity": granularity, "search_count.fields": search_countFields};
        map<Encoding> queryParamEncoding = {"search_count.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2TweetsCountsRecentResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Firehose stream
    #
    # + backfill_minutes - The number of minutes of backfill requested.
    # + partition - The partition number.
    # + start_time - YYYY-MM-DDTHH:mm:ssZ. The earliest UTC timestamp to which the Tweets will be provided.
    # + end_time - YYYY-MM-DDTHH:mm:ssZ. The latest UTC timestamp to which the Tweets will be provided.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/firehose/'stream(int:Signed32 partition, int:Signed32? backfill_minutes = (), string? start_time = (), string? end_time = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns StreamingTweetResponse|error {
        string resourcePath = string `/2/tweets/firehose/stream`;
        map<anydata> queryParam = {"backfill_minutes": backfill_minutes, "partition": partition, "start_time": start_time, "end_time": end_time, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        StreamingTweetResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Tweets Label stream
    #
    # + backfill_minutes - The number of minutes of backfill requested.
    # + start_time - YYYY-MM-DDTHH:mm:ssZ. The earliest UTC timestamp from which the Tweet labels will be provided.
    # + end_time - YYYY-MM-DDTHH:mm:ssZ. The latest UTC timestamp from which the Tweet labels will be provided.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/label/'stream(int:Signed32? backfill_minutes = (), string? start_time = (), string? end_time = ()) returns TweetLabelStreamResponse|error {
        string resourcePath = string `/2/tweets/label/stream`;
        map<anydata> queryParam = {"backfill_minutes": backfill_minutes, "start_time": start_time, "end_time": end_time};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        TweetLabelStreamResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Sample stream
    #
    # + backfill_minutes - The number of minutes of backfill requested.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/sample/'stream(int:Signed32? backfill_minutes = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns StreamingTweetResponse|error {
        string resourcePath = string `/2/tweets/sample/stream`;
        map<anydata> queryParam = {"backfill_minutes": backfill_minutes, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        StreamingTweetResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Sample 10% stream
    #
    # + backfill_minutes - The number of minutes of backfill requested.
    # + partition - The partition number.
    # + start_time - YYYY-MM-DDTHH:mm:ssZ. The earliest UTC timestamp to which the Tweets will be provided.
    # + end_time - YYYY-MM-DDTHH:mm:ssZ. The latest UTC timestamp to which the Tweets will be provided.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/sample10/'stream(int:Signed32 partition, int:Signed32? backfill_minutes = (), string? start_time = (), string? end_time = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns Get2TweetsSample10StreamResponse|error {
        string resourcePath = string `/2/tweets/sample10/stream`;
        map<anydata> queryParam = {"backfill_minutes": backfill_minutes, "partition": partition, "start_time": start_time, "end_time": end_time, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2TweetsSample10StreamResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Full-archive search
    #
    # + query - One query/rule/filter for matching Tweets. Refer to https://t.co/rulelength to identify the max query length.
    # + start_time - YYYY-MM-DDTHH:mm:ssZ. The oldest UTC timestamp from which the Tweets will be provided. Timestamp is in second granularity and is inclusive (i.e. 12:00:01 includes the first second of the minute).
    # + end_time - YYYY-MM-DDTHH:mm:ssZ. The newest, most recent UTC timestamp to which the Tweets will be provided. Timestamp is in second granularity and is exclusive (i.e. 12:00:01 excludes the first second of the minute).
    # + since_id - Returns results with a Tweet ID greater than (that is, more recent than) the specified ID.
    # + until_id - Returns results with a Tweet ID less than (that is, older than) the specified ID.
    # + max_results - The maximum number of search results to be returned by a request.
    # + next_token - This parameter is used to get the next 'page' of results. The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.
    # + pagination_token - This parameter is used to get the next 'page' of results. The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.
    # + sort_order - This order in which to return results.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/search/all(string query, string? start_time = (), string? end_time = (), TweetId? since_id = (), TweetId? until_id = (), int:Signed32 max_results = 10, PaginationToken36? next_token = (), PaginationToken36? pagination_token = (), "recency"|"relevancy"? sort_order = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns Get2TweetsSearchAllResponse|error {
        string resourcePath = string `/2/tweets/search/all`;
        map<anydata> queryParam = {"query": query, "start_time": start_time, "end_time": end_time, "since_id": since_id, "until_id": until_id, "max_results": max_results, "next_token": next_token, "pagination_token": pagination_token, "sort_order": sort_order, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2TweetsSearchAllResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Recent search
    #
    # + query - One query/rule/filter for matching Tweets. Refer to https://t.co/rulelength to identify the max query length.
    # + start_time - YYYY-MM-DDTHH:mm:ssZ. The oldest UTC timestamp from which the Tweets will be provided. Timestamp is in second granularity and is inclusive (i.e. 12:00:01 includes the first second of the minute).
    # + end_time - YYYY-MM-DDTHH:mm:ssZ. The newest, most recent UTC timestamp to which the Tweets will be provided. Timestamp is in second granularity and is exclusive (i.e. 12:00:01 excludes the first second of the minute).
    # + since_id - Returns results with a Tweet ID greater than (that is, more recent than) the specified ID.
    # + until_id - Returns results with a Tweet ID less than (that is, older than) the specified ID.
    # + max_results - The maximum number of search results to be returned by a request.
    # + next_token - This parameter is used to get the next 'page' of results. The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.
    # + pagination_token - This parameter is used to get the next 'page' of results. The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.
    # + sort_order - This order in which to return results.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/search/recent(string query, string? start_time = (), string? end_time = (), TweetId? since_id = (), TweetId? until_id = (), int:Signed32 max_results = 10, PaginationToken36? next_token = (), PaginationToken36? pagination_token = (), "recency"|"relevancy"? sort_order = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns Get2TweetsSearchRecentResponse|error {
        string resourcePath = string `/2/tweets/search/recent`;
        map<anydata> queryParam = {"query": query, "start_time": start_time, "end_time": end_time, "since_id": since_id, "until_id": until_id, "max_results": max_results, "next_token": next_token, "pagination_token": pagination_token, "sort_order": sort_order, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2TweetsSearchRecentResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Filtered stream
    #
    # + backfill_minutes - The number of minutes of backfill requested.
    # + start_time - YYYY-MM-DDTHH:mm:ssZ. The earliest UTC timestamp from which the Tweets will be provided.
    # + end_time - YYYY-MM-DDTHH:mm:ssZ. The latest UTC timestamp to which the Tweets will be provided.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/search/'stream(int:Signed32? backfill_minutes = (), string? start_time = (), string? end_time = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns FilteredStreamingTweetResponse|error {
        string resourcePath = string `/2/tweets/search/stream`;
        map<anydata> queryParam = {"backfill_minutes": backfill_minutes, "start_time": start_time, "end_time": end_time, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        FilteredStreamingTweetResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Rules lookup
    #
    # + ids - A comma-separated list of Rule IDs.
    # + max_results - The maximum number of results.
    # + pagination_token - This value is populated by passing the 'next_token' returned in a request to paginate through results.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/search/'stream/rules(RuleId[]? ids = (), int:Signed32 max_results = 1000, string? pagination_token = ()) returns RulesLookupResponse|error {
        string resourcePath = string `/2/tweets/search/stream/rules`;
        map<anydata> queryParam = {"ids": ids, "max_results": max_results, "pagination_token": pagination_token};
        map<Encoding> queryParamEncoding = {"ids": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        RulesLookupResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add/Delete rules
    #
    # + dry_run - Dry Run can be used with both the add and delete action, with the expected result given, but without actually taking any action in the system (meaning the end state will always be as it was when the request was submitted). This is particularly useful to validate rule changes.
    # + return - The request has succeeded. 
    resource isolated function post '2/tweets/search/'stream/rules(AddOrDeleteRulesRequest payload, boolean? dry_run = ()) returns AddOrDeleteRulesResponse|error {
        string resourcePath = string `/2/tweets/search/stream/rules`;
        map<anydata> queryParam = {"dry_run": dry_run};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        AddOrDeleteRulesResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Tweet lookup by Tweet ID
    #
    # + id - A single Tweet ID.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/[TweetId id](("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns Get2TweetsIdResponse|error {
        string resourcePath = string `/2/tweets/${getEncodedUri(id)}`;
        map<anydata> queryParam = {"tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2TweetsIdResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Tweet delete by Tweet ID
    #
    # + id - The ID of the Tweet to be deleted.
    # + return - The request has succeeded. 
    resource isolated function delete '2/tweets/[TweetId id]() returns TweetDeleteResponse|error {
        string resourcePath = string `/2/tweets/${getEncodedUri(id)}`;
        TweetDeleteResponse response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Returns User objects that have liked the provided Tweet ID
    #
    # + id - A single Tweet ID.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get the next 'page' of results.
    # + userFields - A comma separated list of User fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/[TweetId id]/liking_users(int:Signed32 max_results = 100, PaginationToken36? pagination_token = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("pinned_tweet_id")[]? expansions = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2TweetsIdLikingUsersResponse|error {
        string resourcePath = string `/2/tweets/${getEncodedUri(id)}/liking_users`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "user.fields": userFields, "expansions": expansions, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"user.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2TweetsIdLikingUsersResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Retrieve Tweets that quote a Tweet.
    #
    # + id - A single Tweet ID.
    # + max_results - The maximum number of results to be returned.
    # + pagination_token - This parameter is used to get a specified 'page' of results.
    # + exclude - The set of entities to exclude (e.g. 'replies' or 'retweets').
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/[TweetId id]/quote_tweets(int:Signed32 max_results = 10, PaginationToken36? pagination_token = (), ("replies"|"retweets")[]? exclude = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns Get2TweetsIdQuoteTweetsResponse|error {
        string resourcePath = string `/2/tweets/${getEncodedUri(id)}/quote_tweets`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "exclude": exclude, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"exclude": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2TweetsIdQuoteTweetsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Returns User objects that have retweeted the provided Tweet ID
    #
    # + id - A single Tweet ID.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get the next 'page' of results.
    # + userFields - A comma separated list of User fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/tweets/[TweetId id]/retweeted_by(int:Signed32 max_results = 100, PaginationToken36? pagination_token = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("pinned_tweet_id")[]? expansions = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2TweetsIdRetweetedByResponse|error {
        string resourcePath = string `/2/tweets/${getEncodedUri(id)}/retweeted_by`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "user.fields": userFields, "expansions": expansions, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"user.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2TweetsIdRetweetedByResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Hide replies
    #
    # + tweet_id - The ID of the reply that you want to hide or unhide.
    # + return - The request has succeeded. 
    resource isolated function put '2/tweets/[TweetId tweet_id]/hidden(TweetHideRequest payload) returns TweetHideResponse|error {
        string resourcePath = string `/2/tweets/${getEncodedUri(tweet_id)}/hidden`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        TweetHideResponse response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # User lookup by IDs
    #
    # + ids - A list of User IDs, comma-separated. You can specify up to 100 IDs.
    # + userFields - A comma separated list of User fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users(UserId[] ids, ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("pinned_tweet_id")[]? expansions = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2UsersResponse|error {
        string resourcePath = string `/2/users`;
        map<anydata> queryParam = {"ids": ids, "user.fields": userFields, "expansions": expansions, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"ids": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # User lookup by usernames
    #
    # + usernames - A list of usernames, comma-separated.
    # + userFields - A comma separated list of User fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/'by(string[] usernames, ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("pinned_tweet_id")[]? expansions = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2UsersByResponse|error {
        string resourcePath = string `/2/users/by`;
        map<anydata> queryParam = {"usernames": usernames, "user.fields": userFields, "expansions": expansions, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"usernames": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersByResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # User lookup by username
    #
    # + username - A username.
    # + userFields - A comma separated list of User fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/'by/username/[string username](("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("pinned_tweet_id")[]? expansions = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2UsersByUsernameUsernameResponse|error {
        string resourcePath = string `/2/users/by/username/${getEncodedUri(username)}`;
        map<anydata> queryParam = {"user.fields": userFields, "expansions": expansions, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"user.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersByUsernameUsernameResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Users Compliance stream
    #
    # + backfill_minutes - The number of minutes of backfill requested.
    # + partition - The partition number.
    # + start_time - YYYY-MM-DDTHH:mm:ssZ. The earliest UTC timestamp from which the User Compliance events will be provided.
    # + end_time - YYYY-MM-DDTHH:mm:ssZ. The latest UTC timestamp from which the User Compliance events will be provided.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/compliance/'stream(int:Signed32 partition, int:Signed32? backfill_minutes = (), string? start_time = (), string? end_time = ()) returns UserComplianceStreamResponse|error {
        string resourcePath = string `/2/users/compliance/stream`;
        map<anydata> queryParam = {"backfill_minutes": backfill_minutes, "partition": partition, "start_time": start_time, "end_time": end_time};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        UserComplianceStreamResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # User lookup me
    #
    # + userFields - A comma separated list of User fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/me(("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("pinned_tweet_id")[]? expansions = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2UsersMeResponse|error {
        string resourcePath = string `/2/users/me`;
        map<anydata> queryParam = {"user.fields": userFields, "expansions": expansions, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"user.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersMeResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # User lookup by ID
    #
    # + id - The ID of the User to lookup.
    # + userFields - A comma separated list of User fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/[UserId id](("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("pinned_tweet_id")[]? expansions = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2UsersIdResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}`;
        map<anydata> queryParam = {"user.fields": userFields, "expansions": expansions, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"user.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersIdResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Returns User objects that are blocked by provided User ID
    #
    # + id - The ID of the authenticated source User for whom to return results.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get a specified 'page' of results.
    # + userFields - A comma separated list of User fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/[UserIdMatchesAuthenticatedUser id]/blocking(int:Signed32? max_results = (), PaginationToken32? pagination_token = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("pinned_tweet_id")[]? expansions = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2UsersIdBlockingResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/blocking`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "user.fields": userFields, "expansions": expansions, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"user.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersIdBlockingResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Block User by User ID
    #
    # + id - The ID of the authenticated source User that is requesting to block the target User.
    # + return - The request has succeeded. 
    resource isolated function post '2/users/[UserIdMatchesAuthenticatedUser id]/blocking(BlockUserRequest payload) returns BlockUserMutationResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/blocking`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        BlockUserMutationResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Bookmarks by User
    #
    # + id - The ID of the authenticated source User for whom to return results.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get the next 'page' of results.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/[UserIdMatchesAuthenticatedUser id]/bookmarks(int:Signed32? max_results = (), PaginationToken36? pagination_token = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns Get2UsersIdBookmarksResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/bookmarks`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersIdBookmarksResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add Tweet to Bookmarks
    #
    # + id - The ID of the authenticated source User for whom to add bookmarks.
    # + return - The request has succeeded. 
    resource isolated function post '2/users/[UserIdMatchesAuthenticatedUser id]/bookmarks(BookmarkAddRequest payload) returns BookmarkMutationResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/bookmarks`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        BookmarkMutationResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Remove a bookmarked Tweet
    #
    # + id - The ID of the authenticated source User whose bookmark is to be removed.
    # + tweet_id - The ID of the Tweet that the source User is removing from bookmarks.
    # + return - The request has succeeded. 
    resource isolated function delete '2/users/[UserIdMatchesAuthenticatedUser id]/bookmarks/[TweetId tweet_id]() returns BookmarkMutationResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/bookmarks/${getEncodedUri(tweet_id)}`;
        BookmarkMutationResponse response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Get User's Followed Lists
    #
    # + id - The ID of the User to lookup.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get a specified 'page' of results.
    # + listFields - A comma separated list of List fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + userFields - A comma separated list of User fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/[UserId id]/followed_lists(int:Signed32 max_results = 100, PaginationTokenLong? pagination_token = (), ("created_at"|"description"|"follower_count"|"id"|"member_count"|"name"|"owner_id"|"private")[]? listFields = (), ("owner_id")[]? expansions = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = ()) returns Get2UsersIdFollowedListsResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/followed_lists`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "list.fields": listFields, "expansions": expansions, "user.fields": userFields};
        map<Encoding> queryParamEncoding = {"list.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersIdFollowedListsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Follow a List
    #
    # + id - The ID of the authenticated source User that will follow the List.
    # + return - The request has succeeded. 
    resource isolated function post '2/users/[UserIdMatchesAuthenticatedUser id]/followed_lists(ListFollowedRequest payload) returns ListFollowedResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/followed_lists`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ListFollowedResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Unfollow a List
    #
    # + id - The ID of the authenticated source User that will unfollow the List.
    # + list_id - The ID of the List to unfollow.
    # + return - The request has succeeded. 
    resource isolated function delete '2/users/[UserIdMatchesAuthenticatedUser id]/followed_lists/[ListId list_id]() returns ListFollowedResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/followed_lists/${getEncodedUri(list_id)}`;
        ListFollowedResponse response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Followers by User ID
    #
    # + id - The ID of the User to lookup.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get a specified 'page' of results.
    # + userFields - A comma separated list of User fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/[UserId id]/followers(int:Signed32? max_results = (), PaginationToken32? pagination_token = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("pinned_tweet_id")[]? expansions = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2UsersIdFollowersResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/followers`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "user.fields": userFields, "expansions": expansions, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"user.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersIdFollowersResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Following by User ID
    #
    # + id - The ID of the User to lookup.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get a specified 'page' of results.
    # + userFields - A comma separated list of User fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/[UserId id]/following(int:Signed32? max_results = (), PaginationToken32? pagination_token = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("pinned_tweet_id")[]? expansions = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2UsersIdFollowingResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/following`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "user.fields": userFields, "expansions": expansions, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"user.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersIdFollowingResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Follow User
    #
    # + id - The ID of the authenticated source User that is requesting to follow the target User.
    # + return - The request has succeeded. 
    resource isolated function post '2/users/[UserIdMatchesAuthenticatedUser id]/following(UsersFollowingCreateRequest payload) returns UsersFollowingCreateResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/following`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        UsersFollowingCreateResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Returns Tweet objects liked by the provided User ID
    #
    # + id - The ID of the User to lookup.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get the next 'page' of results.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/[UserId id]/liked_tweets(int:Signed32? max_results = (), PaginationToken36? pagination_token = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns Get2UsersIdLikedTweetsResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/liked_tweets`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersIdLikedTweetsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Causes the User (in the path) to like the specified Tweet
    #
    # + id - The ID of the authenticated source User that is requesting to like the Tweet.
    # + return - The request has succeeded. 
    resource isolated function post '2/users/[UserIdMatchesAuthenticatedUser id]/likes(UsersLikesCreateRequest payload) returns UsersLikesCreateResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/likes`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        UsersLikesCreateResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Causes the User (in the path) to unlike the specified Tweet
    #
    # + id - The ID of the authenticated source User that is requesting to unlike the Tweet.
    # + tweet_id - The ID of the Tweet that the User is requesting to unlike.
    # + return - The request has succeeded. 
    resource isolated function delete '2/users/[UserIdMatchesAuthenticatedUser id]/likes/[TweetId tweet_id]() returns UsersLikesDeleteResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/likes/${getEncodedUri(tweet_id)}`;
        UsersLikesDeleteResponse response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Get a User's List Memberships
    #
    # + id - The ID of the User to lookup.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get a specified 'page' of results.
    # + listFields - A comma separated list of List fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + userFields - A comma separated list of User fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/[UserId id]/list_memberships(int:Signed32 max_results = 100, PaginationTokenLong? pagination_token = (), ("created_at"|"description"|"follower_count"|"id"|"member_count"|"name"|"owner_id"|"private")[]? listFields = (), ("owner_id")[]? expansions = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = ()) returns Get2UsersIdListMembershipsResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/list_memberships`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "list.fields": listFields, "expansions": expansions, "user.fields": userFields};
        map<Encoding> queryParamEncoding = {"list.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersIdListMembershipsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # User mention timeline by User ID
    #
    # + id - The ID of the User to lookup.
    # + since_id - The minimum Tweet ID to be included in the result set. This parameter takes precedence over start_time if both are specified.
    # + until_id - The maximum Tweet ID to be included in the result set. This parameter takes precedence over end_time if both are specified.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get the next 'page' of results.
    # + start_time - YYYY-MM-DDTHH:mm:ssZ. The earliest UTC timestamp from which the Tweets will be provided. The since_id parameter takes precedence if it is also specified.
    # + end_time - YYYY-MM-DDTHH:mm:ssZ. The latest UTC timestamp to which the Tweets will be provided. The until_id parameter takes precedence if it is also specified.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/[UserId id]/mentions(TweetId? since_id = (), TweetId? until_id = (), int:Signed32? max_results = (), PaginationToken36? pagination_token = (), string? start_time = (), string? end_time = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns Get2UsersIdMentionsResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/mentions`;
        map<anydata> queryParam = {"since_id": since_id, "until_id": until_id, "max_results": max_results, "pagination_token": pagination_token, "start_time": start_time, "end_time": end_time, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersIdMentionsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Returns User objects that are muted by the provided User ID
    #
    # + id - The ID of the authenticated source User for whom to return results.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get the next 'page' of results.
    # + userFields - A comma separated list of User fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/[UserIdMatchesAuthenticatedUser id]/muting(int:Signed32 max_results = 100, PaginationTokenLong? pagination_token = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("pinned_tweet_id")[]? expansions = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = ()) returns Get2UsersIdMutingResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/muting`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "user.fields": userFields, "expansions": expansions, "tweet.fields": tweetFields};
        map<Encoding> queryParamEncoding = {"user.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersIdMutingResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Mute User by User ID.
    #
    # + id - The ID of the authenticated source User that is requesting to mute the target User.
    # + return - The request has succeeded. 
    resource isolated function post '2/users/[UserIdMatchesAuthenticatedUser id]/muting(MuteUserRequest payload) returns MuteUserMutationResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/muting`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        MuteUserMutationResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a User's Owned Lists.
    #
    # + id - The ID of the User to lookup.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get a specified 'page' of results.
    # + listFields - A comma separated list of List fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + userFields - A comma separated list of User fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/[UserId id]/owned_lists(int:Signed32 max_results = 100, PaginationTokenLong? pagination_token = (), ("created_at"|"description"|"follower_count"|"id"|"member_count"|"name"|"owner_id"|"private")[]? listFields = (), ("owner_id")[]? expansions = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = ()) returns Get2UsersIdOwnedListsResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/owned_lists`;
        map<anydata> queryParam = {"max_results": max_results, "pagination_token": pagination_token, "list.fields": listFields, "expansions": expansions, "user.fields": userFields};
        map<Encoding> queryParamEncoding = {"list.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersIdOwnedListsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a User's Pinned Lists
    #
    # + id - The ID of the authenticated source User for whom to return results.
    # + listFields - A comma separated list of List fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + userFields - A comma separated list of User fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/[UserIdMatchesAuthenticatedUser id]/pinned_lists(("created_at"|"description"|"follower_count"|"id"|"member_count"|"name"|"owner_id"|"private")[]? listFields = (), ("owner_id")[]? expansions = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = ()) returns Get2UsersIdPinnedListsResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/pinned_lists`;
        map<anydata> queryParam = {"list.fields": listFields, "expansions": expansions, "user.fields": userFields};
        map<Encoding> queryParamEncoding = {"list.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersIdPinnedListsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Pin a List
    #
    # + id - The ID of the authenticated source User that will pin the List.
    # + return - The request has succeeded. 
    resource isolated function post '2/users/[UserIdMatchesAuthenticatedUser id]/pinned_lists(ListPinnedRequest payload) returns ListPinnedResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/pinned_lists`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        ListPinnedResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Unpin a List
    #
    # + id - The ID of the authenticated source User for whom to return results.
    # + list_id - The ID of the List to unpin.
    # + return - The request has succeeded. 
    resource isolated function delete '2/users/[UserIdMatchesAuthenticatedUser id]/pinned_lists/[ListId list_id]() returns ListUnpinResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/pinned_lists/${getEncodedUri(list_id)}`;
        ListUnpinResponse response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Causes the User (in the path) to retweet the specified Tweet.
    #
    # + id - The ID of the authenticated source User that is requesting to retweet the Tweet.
    # + return - The request has succeeded. 
    resource isolated function post '2/users/[UserIdMatchesAuthenticatedUser id]/retweets(UsersRetweetsCreateRequest payload) returns UsersRetweetsCreateResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/retweets`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        UsersRetweetsCreateResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Causes the User (in the path) to unretweet the specified Tweet
    #
    # + id - The ID of the authenticated source User that is requesting to retweet the Tweet.
    # + source_tweet_id - The ID of the Tweet that the User is requesting to unretweet.
    # + return - The request has succeeded. 
    resource isolated function delete '2/users/[UserIdMatchesAuthenticatedUser id]/retweets/[TweetId source_tweet_id]() returns UsersRetweetsDeleteResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/retweets/${getEncodedUri(source_tweet_id)}`;
        UsersRetweetsDeleteResponse response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # User home timeline by User ID
    #
    # + id - The ID of the authenticated source User to list Reverse Chronological Timeline Tweets of.
    # + since_id - The minimum Tweet ID to be included in the result set. This parameter takes precedence over start_time if both are specified.
    # + until_id - The maximum Tweet ID to be included in the result set. This parameter takes precedence over end_time if both are specified.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get the next 'page' of results.
    # + exclude - The set of entities to exclude (e.g. 'replies' or 'retweets').
    # + start_time - YYYY-MM-DDTHH:mm:ssZ. The earliest UTC timestamp from which the Tweets will be provided. The since_id parameter takes precedence if it is also specified.
    # + end_time - YYYY-MM-DDTHH:mm:ssZ. The latest UTC timestamp to which the Tweets will be provided. The until_id parameter takes precedence if it is also specified.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/[UserIdMatchesAuthenticatedUser id]/timelines/reverse_chronological(TweetId? since_id = (), TweetId? until_id = (), int:Signed32? max_results = (), PaginationToken36? pagination_token = (), ("replies"|"retweets")[]? exclude = (), string? start_time = (), string? end_time = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns Get2UsersIdTimelinesReverseChronologicalResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/timelines/reverse_chronological`;
        map<anydata> queryParam = {"since_id": since_id, "until_id": until_id, "max_results": max_results, "pagination_token": pagination_token, "exclude": exclude, "start_time": start_time, "end_time": end_time, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"exclude": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersIdTimelinesReverseChronologicalResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # User Tweets timeline by User ID
    #
    # + id - The ID of the User to lookup.
    # + since_id - The minimum Tweet ID to be included in the result set. This parameter takes precedence over start_time if both are specified.
    # + until_id - The maximum Tweet ID to be included in the result set. This parameter takes precedence over end_time if both are specified.
    # + max_results - The maximum number of results.
    # + pagination_token - This parameter is used to get the next 'page' of results.
    # + exclude - The set of entities to exclude (e.g. 'replies' or 'retweets').
    # + start_time - YYYY-MM-DDTHH:mm:ssZ. The earliest UTC timestamp from which the Tweets will be provided. The since_id parameter takes precedence if it is also specified.
    # + end_time - YYYY-MM-DDTHH:mm:ssZ. The latest UTC timestamp to which the Tweets will be provided. The until_id parameter takes precedence if it is also specified.
    # + tweetFields - A comma separated list of Tweet fields to display.
    # + expansions - A comma separated list of fields to expand.
    # + mediaFields - A comma separated list of Media fields to display.
    # + pollFields - A comma separated list of Poll fields to display.
    # + userFields - A comma separated list of User fields to display.
    # + placeFields - A comma separated list of Place fields to display.
    # + return - The request has succeeded. 
    resource isolated function get '2/users/[UserId id]/tweets(TweetId? since_id = (), TweetId? until_id = (), int:Signed32? max_results = (), PaginationToken36? pagination_token = (), ("replies"|"retweets")[]? exclude = (), string? start_time = (), string? end_time = (), ("attachments"|"author_id"|"context_annotations"|"conversation_id"|"created_at"|"edit_controls"|"edit_history_tweet_ids"|"entities"|"geo"|"id"|"in_reply_to_user_id"|"lang"|"non_public_metrics"|"organic_metrics"|"possibly_sensitive"|"promoted_metrics"|"public_metrics"|"referenced_tweets"|"reply_settings"|"source"|"text"|"withheld")[]? tweetFields = (), ("attachments.media_keys"|"attachments.poll_ids"|"author_id"|"edit_history_tweet_ids"|"entities.mentions.username"|"geo.place_id"|"in_reply_to_user_id"|"referenced_tweets.id"|"referenced_tweets.id.author_id")[]? expansions = (), ("alt_text"|"duration_ms"|"height"|"media_key"|"non_public_metrics"|"organic_metrics"|"preview_image_url"|"promoted_metrics"|"public_metrics"|"type"|"url"|"variants"|"width")[]? mediaFields = (), ("duration_minutes"|"end_datetime"|"id"|"options"|"voting_status")[]? pollFields = (), ("created_at"|"description"|"entities"|"id"|"location"|"name"|"pinned_tweet_id"|"profile_image_url"|"protected"|"public_metrics"|"url"|"username"|"verified"|"verified_type"|"withheld")[]? userFields = (), ("contained_within"|"country"|"country_code"|"full_name"|"geo"|"id"|"name"|"place_type")[]? placeFields = ()) returns Get2UsersIdTweetsResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(id)}/tweets`;
        map<anydata> queryParam = {"since_id": since_id, "until_id": until_id, "max_results": max_results, "pagination_token": pagination_token, "exclude": exclude, "start_time": start_time, "end_time": end_time, "tweet.fields": tweetFields, "expansions": expansions, "media.fields": mediaFields, "poll.fields": pollFields, "user.fields": userFields, "place.fields": placeFields};
        map<Encoding> queryParamEncoding = {"exclude": {style: FORM, explode: false}, "tweet.fields": {style: FORM, explode: false}, "expansions": {style: FORM, explode: false}, "media.fields": {style: FORM, explode: false}, "poll.fields": {style: FORM, explode: false}, "user.fields": {style: FORM, explode: false}, "place.fields": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        Get2UsersIdTweetsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Unblock User by User ID
    #
    # + source_user_id - The ID of the authenticated source User that is requesting to unblock the target User.
    # + target_user_id - The ID of the User that the source User is requesting to unblock.
    # + return - The request has succeeded. 
    resource isolated function delete '2/users/[UserIdMatchesAuthenticatedUser source_user_id]/blocking/[UserId target_user_id]() returns BlockUserMutationResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(source_user_id)}/blocking/${getEncodedUri(target_user_id)}`;
        BlockUserMutationResponse response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Unfollow User
    #
    # + source_user_id - The ID of the authenticated source User that is requesting to unfollow the target User.
    # + target_user_id - The ID of the User that the source User is requesting to unfollow.
    # + return - The request has succeeded. 
    resource isolated function delete '2/users/[UserIdMatchesAuthenticatedUser source_user_id]/following/[UserId target_user_id]() returns UsersFollowingDeleteResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(source_user_id)}/following/${getEncodedUri(target_user_id)}`;
        UsersFollowingDeleteResponse response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Unmute User by User ID
    #
    # + source_user_id - The ID of the authenticated source User that is requesting to unmute the target User.
    # + target_user_id - The ID of the User that the source User is requesting to unmute.
    # + return - The request has succeeded. 
    resource isolated function delete '2/users/[UserIdMatchesAuthenticatedUser source_user_id]/muting/[UserId target_user_id]() returns MuteUserMutationResponse|error {
        string resourcePath = string `/2/users/${getEncodedUri(source_user_id)}/muting/${getEncodedUri(target_user_id)}`;
        MuteUserMutationResponse response = check self.clientEp-> delete(resourcePath);
        return response;
    }
}
