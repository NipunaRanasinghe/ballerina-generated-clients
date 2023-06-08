import ballerina/http;
import ballerina/constraint;

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Configurations related to client authentication
    http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
|};

# Provides settings related to HTTP/1.x protocol.
public type ClientHttp1Settings record {|
    # Specifies whether to reuse a connection for multiple requests
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    # The chunking behaviour of the request
    http:Chunking chunking = http:CHUNKING_AUTO;
    # Proxy server related options
    ProxyConfig proxy?;
|};

# Proxy server configurations to be used with the HTTP client endpoint.
public type ProxyConfig record {|
    # Host name of the proxy server
    string host = "";
    # Proxy server port
    int port = 0;
    # Proxy server username
    string userName = "";
    # Proxy server password
    @display {label: "", kind: "password"}
    string password = "";
|};

# OAuth2 Refresh Token Grant Configs
public type OAuth2RefreshTokenGrantConfig record {|
    *http:OAuth2RefreshTokenGrantConfig;
    # Refresh URL
    string refreshUrl = "https://api.twitter.com/2/oauth2/token";
|};

public type FulltextentitiesAnnotationsItemsNull record {
    *EntityIndicesInclusiveInclusive;
    # Text used to determine annotation.
    string normalized_text?;
    # Confidence factor for annotation type.
    @constraint:Number {minValue: 0, maxValue: 1}
    decimal probability?;
    # Annotation type.
    string 'type?;
};

@constraint:Number {minValue: -180, maxValue: 180}
public type GeoBboxItemsNumber decimal;

@constraint:String {maxLength: 25, minLength: 1}
public type Tweetcreaterequest_pollOptionsItemsString string;

public type Get2DmConversationsIdDmEventsResponse_meta record {
    # The next token.
    NextToken next_token?;
    # The previous token.
    PreviousToken previous_token?;
    # The number of results returned in this response.
    ResultCount result_count?;
};

# The previous token.
@constraint:String {minLength: 1}
public type PreviousToken string;

# Creation time of the compliance job.
public type CreatedAt string;

public type UsersFollowingCreateResponse_data record {
    boolean following?;
    boolean pending_follow?;
};

public type ListPinnedRequest record {
    # The unique identifier of this List.
    ListId list_id;
};

public type UserComplianceSchema record {
    # Event time.
    string event_at;
    UserComplianceSchema_user user;
};

public type Get2SpacesIdResponse record {
    # 
    Space data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};

public type TweetUnviewableSchema record {
    TweetUnviewable public_tweet_unviewable;
};

public type Tweet_edit_controls record {
    # Time when Tweet is no longer editable.
    string editable_until;
    # Number of times this Tweet can be edited.
    int edits_remaining;
    # Indicates if this Tweet is eligible to be edited.
    boolean is_edit_eligible;
};

# HTTP Status Code.
@constraint:Int {minValue: 100, maxValue: 599}
public type HttpStatusCode int;

public type ListUpdateResponse_data record {
    boolean updated?;
};

# Specifies the type of attachments (if any) present in this Tweet.
public type Tweet_attachments record {
    # A list of Media Keys for each one of the media attachments (if media are attached).
    @constraint:Array {minLength: 1}
    MediaKey[] media_keys?;
    # A list of poll IDs (if polls are attached).
    @constraint:Array {minLength: 1}
    PollId[] poll_ids?;
};

# Tweet label data.
public type TweetLabelData TweetNoticeSchema|TweetUnviewableSchema;

public type UserScrubGeoObjectSchema record {
    # Event time.
    string event_at;
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId up_to_tweet_id;
    UserComplianceSchema_user user;
};

# A request to create a new batch compliance job.
public type CreateComplianceJobRequest record {
    # User-provided name for a compliance job.
    ComplianceJobName name?;
    # If true, this endpoint will return a pre-signed URL with resumable uploads enabled.
    boolean resumable?;
    # Type of compliance job to list.
    "tweets"|"users" 'type;
};

# 
public type Space record {
    # Creation time of the Space.
    string created_at?;
    # Unique identifier of this User. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    UserId creator_id?;
    # End time of the Space.
    string ended_at?;
    # The user ids for the hosts of the Space.
    UserId[] host_ids?;
    # The unique identifier of this Space.
    SpaceId id;
    # An array of user ids for people who were invited to a Space.
    UserId[] invited_user_ids?;
    # Denotes if the Space is a ticketed Space.
    boolean is_ticketed?;
    # The language of the Space.
    string lang?;
    # The number of participants in a Space.
    int:Signed32 participant_count?;
    # A date time stamp for when a Space is scheduled to begin.
    string scheduled_start?;
    # An array of user ids for people who were speakers in a Space.
    UserId[] speaker_ids?;
    # When the Space was started as a date string.
    string started_at?;
    # The current state of the Space.
    "live"|"scheduled"|"ended" state;
    # The number of people who have either purchased a ticket or set a reminder for this Space.
    int:Signed32 subscriber_count?;
    # The title of the Space.
    string title?;
    # The topics of a Space, as selected by its creator.
    Space_topics[] topics?;
    # When the Space was last updated.
    string updated_at?;
};

# Expanded details for the URL specified in the User's profile, with start and end indices.
public type User_entities_url record {
    @constraint:Array {minLength: 1}
    UrlEntity[] urls?;
};

# Engagement metrics for the Media at the time of the request.
public type Video_public_metrics record {
    # Number of times this video has been viewed.
    int:Signed32 view_count?;
};

public type UsersRetweetsCreateRequest record {
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId tweet_id;
};

# A response from deleting user-specified stream filtering rules.
public type DeleteRulesRequest record {
    # IDs and values of all deleted user-specified stream filtering rules.
    DeleteRulesRequest_delete delete;
};

# A request to add a user-specified stream filtering rule.
public type AddRulesRequest record {
    RuleNoId[] add;
};

# Place ID being attached to the Tweet for geo location.
public type TweetCreateRequest_geo record {|
    string place_id?;
|};

# Annotation inferred from the Tweet text.
public type ContextAnnotation record {
    # Represents the data for the context annotation domain.
    ContextAnnotationDomainFields domain;
    # Represents the data for the context annotation entity.
    ContextAnnotationEntityFields entity;
};

public type Get2ListsIdMembersResponse record {
    @constraint:Array {minLength: 1}
    User[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

public type UsersFollowingCreateResponse record {
    UsersFollowingCreateResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

public type UserComplianceSchema_user record {
    # Unique identifier of this User. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    UserId id;
};

# Represent the portion of text recognized as a URL, and its start and end position within the text.
public type UrlEntity record {
    *EntityIndicesInclusiveExclusive;
    *UrlFields;
};

# Represent the portion of text recognized as a User mention, and its start and end position within the text.
public type MentionFields record {
    # Unique identifier of this User. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    UserId id?;
    # The Twitter handle (screen name) of this user.
    UserName username;
};

public type CreateDmConversationRequest record {|
    # The conversation type that is being created.
    "Group" conversation_type;
    CreateMessageRequest message;
    # Participants for the DM Conversation.
    DmParticipants participant_ids;
|};

# A problem that indicates that the resource requested violates the precepts of this API.
public type DisallowedResourceProblem record {
    *Problem;
    string resource_id;
    "user"|"tweet"|"media"|"list"|"space" resource_type;
    "data"|"includes" section;
};

public type ListUpdateResponse record {
    ListUpdateResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

public type Get2TweetsSearchStreamResponse record {
    Tweet data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};

# Represents the data for the context annotation entity.
public type ContextAnnotationEntityFields record {
    # Description of the context annotation entity.
    string description?;
    # The unique id for a context annotation entity.
    @constraint:String {pattern: re `^[0-9]{1,19}$`}
    string id;
    # Name of the context annotation entity.
    string name?;
};

public type ListPinnedResponse_data record {
    boolean pinned?;
};

# A problem that indicates a particular Tweet, User, etc. is not available to you.
public type ResourceUnavailableProblem record {
    *Problem;
    @constraint:String {minLength: 1}
    string 'parameter;
    string resource_id;
    "user"|"tweet"|"media"|"list"|"space" resource_type;
};

# A problem that indicates that a given Tweet, User, etc. does not exist.
public type ResourceNotFoundProblem record {
    *Problem;
    @constraint:String {minLength: 1}
    string 'parameter;
    string resource_id;
    "user"|"tweet"|"media"|"list"|"space" resource_type;
    # Value will match the schema of the field.
    string value;
};

# A problem that indicates your client is forbidden from making this request.
public type ClientForbiddenProblem record {
    *Problem;
    "official-client-forbidden"|"client-not-enrolled" reason?;
    string registration_url?;
};

public type Get2UsersByUsernameUsernameResponse record {
    # The Twitter User object.
    User data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};

public type ListCreateResponse record {
    # A Twitter List is a curated group of accounts.
    ListCreateResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

public type CreateDmEventResponse record {
    CreateDmEventResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

# Unique identifier of a DM Event.
@constraint:String {pattern: re `^[0-9]{1,19}$`}
public type DmEventId string;

# A problem that indicates that you are not allowed to see a particular field on a Tweet, User, etc.
public type FieldUnauthorizedProblem record {
    *Problem;
    string 'field;
    "user"|"tweet"|"media"|"list"|"space" resource_type;
    "data"|"includes" section;
};

public type DmEvent record {
    # Specifies the type of attachments (if any) present in this DM.
    DmEvent_attachments attachments?;
    string created_at?;
    # Unique identifier of a DM conversation. This can either be a numeric string, or a pair of numeric strings separated by a '-' character in the case of one-on-one DM Conversations.
    DmConversationId dm_conversation_id?;
    string event_type;
    # Unique identifier of a DM Event.
    DmEventId id;
    # A list of participants for a ParticipantsJoin or ParticipantsLeave event_type.
    @constraint:Array {minLength: 1}
    UserId[] participant_ids?;
    # A list of Tweets this DM refers to.
    @constraint:Array {minLength: 1}
    DmEvent_referenced_tweets[] referenced_tweets?;
    # Unique identifier of this User. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    UserId sender_id?;
    string text?;
};

public type UsersRetweetsCreateResponse record {
    UsersRetweetsCreateResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

public type Get2TweetsResponse record {
    @constraint:Array {minLength: 1}
    Tweet[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};

public type DmEvent_referenced_tweets record {
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId id;
};

# Specifies the type of attachments (if any) present in this DM.
public type DmEvent_attachments record {
    # A list of card IDs (if cards are attached).
    @constraint:Array {minLength: 1}
    string[] card_ids?;
    # A list of Media Keys for each one of the media attachments (if media are attached).
    @constraint:Array {minLength: 1}
    MediaKey[] media_keys?;
};

public type UsersLikesDeleteResponse record {
    UsersLikesCreateResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

public type Get2ListsIdFollowersResponse record {
    @constraint:Array {minLength: 1}
    User[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

public type BlockUserRequest record {
    # Unique identifier of this User. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    UserId target_user_id;
};

public type Expansions record {
    @constraint:Array {minLength: 1}
    Media[] media?;
    @constraint:Array {minLength: 1}
    Place[] places?;
    @constraint:Array {minLength: 1}
    Poll[] polls?;
    @constraint:Array {minLength: 1}
    Topic[] topics?;
    @constraint:Array {minLength: 1}
    Tweet[] tweets?;
    @constraint:Array {minLength: 1}
    User[] users?;
};

# Organic nonpublic engagement metrics for the Media at the time of the request.
public type Video_organic_metrics record {
    # Number of users who made it through 0% of the video.
    int:Signed32 playback_0_count?;
    # Number of users who made it through 100% of the video.
    int:Signed32 playback_100_count?;
    # Number of users who made it through 25% of the video.
    int:Signed32 playback_25_count?;
    # Number of users who made it through 50% of the video.
    int:Signed32 playback_50_count?;
    # Number of users who made it through 75% of the video.
    int:Signed32 playback_75_count?;
    # Number of times this video has been viewed.
    int:Signed32 view_count?;
};

# A problem that indicates you are not allowed to see a particular Tweet, User, etc.
public type ResourceUnauthorizedProblem record {
    *Problem;
    string 'parameter;
    string resource_id;
    "user"|"tweet"|"media"|"list"|"space" resource_type;
    "data"|"includes" section;
    string value;
};

public type TweetCreateResponse_data record {
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId id;
    # The content of the Tweet.
    TweetText text;
};

public type UserDeleteComplianceSchema record {
    UserComplianceSchema user_delete;
};

# Unique identifier of this User. The value must be the same as the authenticated user.
public type UserIdMatchesAuthenticatedUser string;

public type Get2TweetsIdQuoteTweetsResponse record {
    @constraint:Array {minLength: 1}
    Tweet[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2TweetsIdQuoteTweetsResponse_meta meta?;
};

public type Get2TweetsCountsAllResponse record {
    @constraint:Array {minLength: 1}
    SearchCount[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Get2TweetsCountsAllResponse_meta meta?;
};

# The sum of results returned in this response.
public type Aggregate int:Signed32;

# User-provided name for a compliance job.
@constraint:String {maxLength: 64}
public type ComplianceJobName string;

public type Get2DmConversationsWithParticipantIdDmEventsResponse record {
    @constraint:Array {minLength: 1}
    DmEvent[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

public type TweetDropComplianceSchema record {
    TweetComplianceSchema drop;
};

# Nonpublic engagement metrics for the Tweet at the time of the request.
public type Tweet_non_public_metrics record {
    # Number of times this Tweet has been viewed.
    int:Signed32 impression_count?;
};

public type Tweet_referenced_tweets record {
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId id;
    "retweeted"|"quoted"|"replied_to" 'type;
};

public type Get2UsersIdFollowedListsResponse record {
    @constraint:Array {minLength: 1}
    List[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

public type ListUpdateRequest record {
    @constraint:String {maxLength: 100}
    string description?;
    @constraint:String {maxLength: 25, minLength: 1}
    string name?;
    boolean 'private?;
};

public type Place record {
    @constraint:Array {minLength: 1}
    PlaceId[] contained_within?;
    # The full name of the county in which this place exists.
    string country?;
    # A two-letter ISO 3166-1 alpha-2 country code.
    CountryCode country_code?;
    # The full name of this place.
    string full_name;
    Geo geo?;
    # The identifier for this place.
    PlaceId id;
    # The human readable name of this place.
    string name?;
    PlaceType place_type?;
};

public type AnimatedGif record {
    *Media;
    string preview_image_url?;
    # An array of all available variants of the media.
    Variants variants?;
};

# User compliance stream events.
public type UserComplianceStreamResponse record {
    # User compliance data.
    UserComplianceData data;
}|record {@constraint:Array {minLength: 1}
    Problem[] errors;};

public type UserUnprotectComplianceSchema record {
    UserComplianceSchema user_unprotect;
};

public type PlaceType "poi"|"neighborhood"|"city"|"admin"|"country"|"unknown";

# The start time of the bucket.
public type Start string;

public type Tweet record {
    # Specifies the type of attachments (if any) present in this Tweet.
    Tweet_attachments attachments?;
    # Unique identifier of this User. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    UserId author_id?;
    @constraint:Array {minLength: 1}
    ContextAnnotation[] context_annotations?;
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId conversation_id?;
    # Creation time of the Tweet.
    string created_at?;
    Tweet_edit_controls edit_controls?;
    # A list of Tweet Ids in this Tweet chain.
    @constraint:Array {minLength: 1}
    TweetId[] edit_history_tweet_ids;
    FullTextEntities entities?;
    # The location tagged on the Tweet, if the user provided one.
    Tweet_geo geo?;
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId id;
    # Unique identifier of this User. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    UserId in_reply_to_user_id?;
    # Language of the Tweet, if detected by Twitter. Returned as a BCP47 language tag.
    string lang?;
    # Nonpublic engagement metrics for the Tweet at the time of the request.
    Tweet_non_public_metrics non_public_metrics?;
    # Organic nonpublic engagement metrics for the Tweet at the time of the request.
    Tweet_organic_metrics organic_metrics?;
    # Indicates if this Tweet contains URLs marked as sensitive, for example content suitable for mature audiences.
    boolean possibly_sensitive?;
    # Promoted nonpublic engagement metrics for the Tweet at the time of the request.
    Tweet_promoted_metrics promoted_metrics?;
    # Engagement metrics for the Tweet at the time of the request.
    Tweet_public_metrics public_metrics?;
    # A list of Tweets this Tweet refers to. For example, if the parent Tweet is a Retweet, a Quoted Tweet or a Reply, it will include the related Tweet referenced to by its parent.
    @constraint:Array {minLength: 1}
    Tweet_referenced_tweets[] referenced_tweets?;
    # Shows who can reply a Tweet. Fields returned are everyone, mentioned_users, and following.
    ReplySettings reply_settings?;
    # This is deprecated.
    string 'source?;
    # The content of the Tweet.
    TweetText text;
    # Indicates withholding details for [withheld content](https://help.twitter.com/en/rules-and-policies/tweet-withheld-by-country).
    TweetWithheld withheld?;
};

# Type of compliance job to list.
public type ComplianceJobType "tweets"|"users";

public type Photo record {
    *Media;
    string alt_text?;
    string url?;
};

# You have exceeded the maximum number of rules.
public type RulesCapProblem Problem;

# A generic problem with no additional information beyond that provided by the HTTP status code.
public type GenericProblem Problem;

# A base32 pagination token.
@constraint:String {minLength: 16}
public type PaginationToken32 string;

public type TweetDeleteResponse_data record {
    boolean deleted;
};

# Participants for the DM Conversation.
@constraint:Array {maxLength: 49, minLength: 2}
public type DmParticipants UserId[];

# Represent the portion of text recognized as a Hashtag, and its start and end position within the text.
public type HashtagFields record {
    # The text of the Hashtag.
    string tag;
};

public type ListMutateResponse_data record {
    boolean is_member?;
};

# A Twitter List is a curated group of accounts.
public type List record {
    string created_at?;
    string description?;
    int follower_count?;
    # The unique identifier of this List.
    ListId id;
    int member_count?;
    # The name of this List.
    string name;
    # Unique identifier of this User. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    UserId owner_id?;
    boolean 'private?;
};

# A problem that indicates this request is invalid.
public type InvalidRequestProblem record {
    *Problem;
    @constraint:Array {minLength: 1}
    InvalidRequestProblem_errors[] errors?;
};

public type TweetWithheldComplianceSchema record {
    TweetTakedownComplianceSchema withheld;
};

# URL from which the user will retrieve their compliance results.
public type DownloadUrl string;

# A user-provided stream filtering rule.
public type RuleNoId record {
    # A tag meant for the labeling of user provided rules.
    RuleTag tag?;
    # The filterlang value of the rule.
    RuleValue value;
};

public type UserProfileModificationObjectSchema record {
    # Event time.
    string event_at;
    string new_value;
    string profile_field;
    UserComplianceSchema_user user;
};

public type Get2TweetsSampleStreamResponse record {
    Tweet data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};

public type Get2UsersByResponse record {
    @constraint:Array {minLength: 1}
    User[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};

public type ListFollowedResponse record {
    ListFollowedResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

public type Get2TweetsCountsRecentResponse record {
    @constraint:Array {minLength: 1}
    SearchCount[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Get2TweetsCountsAllResponse_meta meta?;
};

# The unique identifier of this Media.
@constraint:String {pattern: re `^[0-9]{1,19}$`}
public type MediaId string;

public type Video record {
    *Media;
    int duration_ms?;
    # Nonpublic engagement metrics for the Media at the time of the request.
    Video_non_public_metrics non_public_metrics?;
    # Organic nonpublic engagement metrics for the Media at the time of the request.
    Video_organic_metrics organic_metrics?;
    string preview_image_url?;
    # Promoted nonpublic engagement metrics for the Media at the time of the request.
    Video_promoted_metrics promoted_metrics?;
    # Engagement metrics for the Media at the time of the request.
    Video_public_metrics public_metrics?;
    # An array of all available variants of the media.
    Variants variants?;
};

public type Get2UsersIdFollowingResponse record {
    @constraint:Array {minLength: 1}
    User[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

# The end time of the bucket.
public type End string;

# An HTTP Problem Details object, as defined in IETF RFC 7807 (https://tools.ietf.org/html/rfc7807).
public type Problem record {
    string detail?;
    int status?;
    string title;
    string 'type;
};

public type FilteredStreamingTweetResponse_matching_rules record {
    # Unique identifier of this rule.
    RuleId id;
    # A tag meant for the labeling of user provided rules.
    RuleTag tag?;
};

public type MuteUserRequest record {
    # Unique identifier of this User. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    UserId target_user_id;
};

# Shows who can reply a Tweet. Fields returned are everyone, mentioned_users, and following.
@constraint:String {pattern: re `^[A-Za-z]{1,12}$`}
public type ReplySettings "everyone"|"mentionedUsers"|"following"|"other";

# URL to which the user will upload their Tweet or user IDs.
public type UploadUrl string;

# A list of metadata found in the User's profile description.
public type User_entities record {
    FullTextEntities description?;
    # Expanded details for the URL specified in the User's profile, with start and end indices.
    User_entities_url url?;
};

public type RulesResponseMetadata record {
    # The next token.
    NextToken next_token?;
    # Number of Rules in result set.
    int:Signed32 result_count?;
    string sent;
    RulesRequestSummary summary?;
};

# You cannot create a new job if one is already in progress.
public type ConflictProblem Problem;

# The content of the Tweet.
public type TweetText string;

# Promoted nonpublic engagement metrics for the Tweet at the time of the request.
public type Tweet_promoted_metrics record {
    # Number of times this Tweet has been viewed.
    int:Signed32 impression_count?;
    # Number of times this Tweet has been liked.
    int:Signed32 like_count?;
    # Number of times this Tweet has been replied to.
    int:Signed32 reply_count?;
    # Number of times this Tweet has been Retweeted.
    int:Signed32 retweet_count?;
};

# A list of metrics for this User.
public type User_public_metrics record {
    # Number of Users who are following this User.
    int followers_count;
    # Number of Users this User is following.
    int following_count;
    # The number of lists that include this User.
    int listed_count;
    # The number of Tweets (including Retweets) posted by this User.
    int tweet_count;
};

public type TweetComplianceSchema_tweet record {
    # Unique identifier of this User. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    UserId author_id;
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId id;
};

public type ListAddUserRequest record {
    # Unique identifier of this User. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    UserId user_id;
};

public type AddOrDeleteRulesRequest AddRulesRequest|DeleteRulesRequest;

# The text of a poll choice.
@constraint:String {maxLength: 25, minLength: 1}
public type PollOptionLabel string;

public type TweetHideRequest record {
    boolean hidden;
};

public type RulesLookupResponse record {
    Rule[] data?;
    RulesResponseMetadata meta;
};

# Nonpublic engagement metrics for the Media at the time of the request.
public type Video_non_public_metrics record {
    # Number of users who made it through 0% of the video.
    int:Signed32 playback_0_count?;
    # Number of users who made it through 100% of the video.
    int:Signed32 playback_100_count?;
    # Number of users who made it through 25% of the video.
    int:Signed32 playback_25_count?;
    # Number of users who made it through 50% of the video.
    int:Signed32 playback_50_count?;
    # Number of users who made it through 75% of the video.
    int:Signed32 playback_75_count?;
};

public type ListUnpinResponse record {
    ListPinnedResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

public type UsersLikesCreateResponse record {
    UsersLikesCreateResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

public type CreateDmEventResponse_data record {
    # Unique identifier of a DM conversation. This can either be a numeric string, or a pair of numeric strings separated by a '-' character in the case of one-on-one DM Conversations.
    DmConversationId dm_conversation_id;
    # Unique identifier of a DM Event.
    DmEventId dm_event_id;
};

public type Get2SpacesResponse record {
    @constraint:Array {minLength: 1}
    Space[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};

public type FullTextEntities record {
    @constraint:Array {minLength: 1}
    record {
        *EntityIndicesInclusiveInclusive;
        # Text used to determine annotation.
        string normalized_text?;
        # Confidence factor for annotation type.
        @constraint:Number {minValue: 0, maxValue: 1}
        decimal probability?;
        # Annotation type.
        string 'type?;
    }[] annotations?;
    @constraint:Array {minLength: 1}
    CashtagEntity[] cashtags?;
    @constraint:Array {minLength: 1}
    HashtagEntity[] hashtags?;
    @constraint:Array {minLength: 1}
    MentionEntity[] mentions?;
    @constraint:Array {minLength: 1}
    UrlEntity[] urls?;
};

public type BlockUserMutationResponse_data record {
    boolean blocking?;
};

# Represent a boundary range (start and end index) for a recognized entity (for example a hashtag or a mention). `start` must be smaller than `end`.  The start index is inclusive, the end index is exclusive.
public type EntityIndicesInclusiveExclusive record {
    # Index (zero-based) at which position this entity ends.  The index is exclusive.
    @constraint:Int {minValue: 0}
    int end;
    # Index (zero-based) at which position this entity starts.  The index is inclusive.
    @constraint:Int {minValue: 0}
    int 'start;
};

# Describes a choice in a Poll object.
public type PollOption record {
    # The text of a poll choice.
    PollOptionLabel label;
    # Position of this choice in the poll.
    int position;
    # Number of users who voted for this choice.
    int votes;
};

public type ListFollowedResponse_data record {
    boolean following?;
};

# The Twitter handle (screen name) of this user.
@constraint:String {pattern: re `^[A-Za-z0-9_]{1,15}$`}
public type UserName string;

public type UsersFollowingDeleteResponse record {
    ListFollowedResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

# The Twitter Topic object.
public type Space_topics record {
    # The description of the given topic.
    string description?;
    # An ID suitable for use in the REST API.
    string id;
    # The name of the given topic.
    string name;
};

public type Get2ComplianceJobsResponse record {
    @constraint:Array {minLength: 1}
    ComplianceJob[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Get2ComplianceJobsResponse_meta meta?;
};

public type UsersFollowingCreateRequest record {
    # Unique identifier of this User. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    UserId target_user_id;
};

# Tweet information of the Tweet being replied to.
public type TweetCreateRequest_reply record {|
    # A list of User Ids to be excluded from the reply Tweet.
    UserId[] exclude_reply_user_ids?;
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId in_reply_to_tweet_id;
|};

public type CreateAttachmentsMessageRequest record {
    # Attachments to a DM Event.
    DmAttachments attachments;
    # Text of the message.
    @constraint:String {minLength: 1}
    string text?;
};

public type StreamingTweetResponse record {
    Tweet data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};

public type Get2TweetsFirehoseStreamResponse record {
    Tweet data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};

public type Get2TweetsIdResponse record {
    Tweet data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};

public type TweetHideResponse_data record {
    boolean hidden?;
};

# Indicates withholding details for [withheld content](https://help.twitter.com/en/rules-and-policies/tweet-withheld-by-country).
public type TweetWithheld record {
    # Indicates if the content is being withheld for on the basis of copyright infringement.
    boolean copyright;
    # Provides a list of countries where this content is not available.
    @constraint:Array {minLength: 1}
    CountryCode[] country_codes;
    # Indicates whether the content being withheld is the `tweet` or a `user`.
    "tweet"|"user" scope?;
};

# IDs and values of all deleted user-specified stream filtering rules.
public type DeleteRulesRequest_delete record {
    # IDs of all deleted user-specified stream filtering rules.
    RuleId[] ids?;
    # Values of all deleted user-specified stream filtering rules.
    RuleValue[] values?;
};

public type UserProtectComplianceSchema record {
    UserComplianceSchema user_protect;
};

# Tweet compliance stream events.
public type TweetComplianceStreamResponse record {
    # Tweet compliance data.
    TweetComplianceData data;
}|record {@constraint:Array {minLength: 1}
    Problem[] errors;};

public type Get2SpacesIdBuyersResponse record {
    @constraint:Array {minLength: 1}
    User[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

public type UserWithheldComplianceSchema record {
    UserTakedownComplianceSchema user_withheld;
};

public type DmMediaAttachment record {
    # The unique identifier of this Media.
    MediaId media_id;
};

public type Get2UsersIdBlockingResponse record {
    @constraint:Array {minLength: 1}
    User[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

public type Get2UsersIdFollowersResponse record {
    @constraint:Array {minLength: 1}
    User[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

# The number of results returned in this response.
public type ResultCount int:Signed32;

public type UserSuspendComplianceSchema record {
    UserComplianceSchema user_suspend;
};

public type Get2TweetsIdLikingUsersResponse record {
    @constraint:Array {minLength: 1}
    User[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

public type CashtagEntity record {
    *EntityIndicesInclusiveExclusive;
    *CashtagFields;
};

# A problem that indicates your client application does not have the required OAuth1 permissions for the requested endpoint.
public type Oauth1PermissionsProblem Problem;

# A problem that indicates something is wrong with the connection.
public type ConnectionExceptionProblem record {
    *Problem;
    "TooManyConnections"|"ProvisioningSubscription"|"RuleConfigurationIssue"|"RulesInvalidIssue" connection_issue?;
};

# Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
@constraint:String {pattern: re `^[0-9]{1,19}$`}
public type TweetId string;

public type UsersLikesCreateResponse_data record {
    boolean liked?;
};

public type HashtagEntity record {
    *EntityIndicesInclusiveExclusive;
    *HashtagFields;
};

# Organic nonpublic engagement metrics for the Tweet at the time of the request.
public type Tweet_organic_metrics record {
    # Number of times this Tweet has been viewed.
    int impression_count;
    # Number of times this Tweet has been liked.
    int like_count;
    # Number of times this Tweet has been replied to.
    int reply_count;
    # Number of times this Tweet has been Retweeted.
    int retweet_count;
};

# Expiration time of the download URL.
public type DownloadExpiration string;

public type UserUndeleteComplianceSchema record {
    UserComplianceSchema user_undelete;
};

public type Get2ListsIdResponse record {
    # A Twitter List is a curated group of accounts.
    List data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};

public type ComplianceJob record {
    # Creation time of the compliance job.
    CreatedAt created_at;
    # Expiration time of the download URL.
    DownloadExpiration download_expires_at;
    # URL from which the user will retrieve their compliance results.
    DownloadUrl download_url;
    # Compliance Job ID.
    JobId id;
    # User-provided name for a compliance job.
    ComplianceJobName name?;
    # Status of a compliance job.
    ComplianceJobStatus status;
    # Type of compliance job to list.
    ComplianceJobType 'type;
    # Expiration time of the upload URL.
    UploadExpiration upload_expires_at;
    # URL to which the user will upload their Tweet or user IDs.
    UploadUrl upload_url;
};

public type BlockUserMutationResponse record {
    BlockUserMutationResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

# A [GeoJson Position](https://tools.ietf.org/html/rfc7946#section-3.1.1) in the format `[longitude,latitude]`.
@constraint:Array {maxLength: 2, minLength: 2}
public type Position decimal[];

public type BookmarkMutationResponse record {
    BookmarkMutationResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

public type Geo record {
    @constraint:Array {maxLength: 4, minLength: 4}
    GeoBboxItemsNumber[] bbox;
    # A [GeoJson Point](https://tools.ietf.org/html/rfc7946#section-3.1.2) geometry object.
    Point geometry?;
    record {} properties;
    "Feature" 'type;
};

public type Variant record {
    # The bit rate of the media.
    int bit_rate?;
    # The content type of the media.
    string content_type?;
    # The url to the media.
    string url?;
};

public type Get2UsersIdTweetsResponse record {
    @constraint:Array {minLength: 1}
    Tweet[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2UsersIdMentionsResponse_meta meta?;
};

public type Get2UsersMeResponse record {
    # The Twitter User object.
    User data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};

public type TweetEditComplianceObjectSchema record {
    @constraint:Array {minLength: 1}
    TweetId[] edit_tweet_ids;
    # Event time.
    string event_at;
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId initial_tweet_id;
    DmEvent_referenced_tweets tweet;
};

# Tweet compliance data.
public type TweetComplianceData TweetDeleteComplianceSchema|TweetWithheldComplianceSchema|TweetDropComplianceSchema|TweetUndropComplianceSchema|TweetEditComplianceSchema;

public type MuteUserMutationResponse record {
    MuteUserMutationResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

# A user-provided stream filtering rule.
public type Rule record {
    # Unique identifier of this rule.
    RuleId id?;
    # A tag meant for the labeling of user provided rules.
    RuleTag tag?;
    # The filterlang value of the rule.
    RuleValue value;
};

public type ListFollowedRequest record {
    # The unique identifier of this List.
    ListId list_id;
};

public type RulesRequestSummary record {
    # Number of user-specified stream filtering rules that were created.
    int:Signed32 created;
    # Number of invalid user-specified stream filtering rules.
    int:Signed32 invalid;
    # Number of user-specified stream filtering rules that were not created.
    int:Signed32 not_created;
    # Number of valid user-specified stream filtering rules.
    int:Signed32 valid;
}|record {
    # Number of user-specified stream filtering rules that were deleted.
    int:Signed32 deleted;
    # Number of user-specified stream filtering rules that were not deleted.
    int:Signed32 not_deleted;
};

# A Twitter List is a curated group of accounts.
public type ListCreateResponse_data record {
    # The unique identifier of this List.
    ListId id;
    # The name of this List.
    string name;
};

public type ListDeleteResponse_data record {
    boolean deleted?;
};

public type TweetNoticeSchema record {
    TweetNotice public_tweet_notice;
};

# A problem that indicates that a usage cap has been exceeded.
public type UsageCapExceededProblem record {
    *Problem;
    "Daily"|"Monthly" period?;
    "Account"|"Product" scope?;
};

# User compliance data.
public type UserComplianceData UserProtectComplianceSchema|UserUnprotectComplianceSchema|UserDeleteComplianceSchema|UserUndeleteComplianceSchema|UserSuspendComplianceSchema|UserUnsuspendComplianceSchema|UserWithheldComplianceSchema|UserScrubGeoSchema|UserProfileModificationComplianceSchema;

public type ListPinnedResponse record {
    ListPinnedResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

public type TweetNotice record {
    # If the label is being applied or removed. Possible values are ‘apply’ or ‘remove’.
    string application;
    # Information shown on the Tweet label
    string details?;
    # Event time.
    string event_at;
    # The type of label on the Tweet
    string event_type;
    # Link to more information about this kind of label
    string extended_details_url?;
    # Title/header of the Tweet label
    string label_title?;
    TweetComplianceSchema_tweet tweet;
};

# A validly formatted URL.
public type Url string;

public type CreateTextMessageRequest record {
    # Attachments to a DM Event.
    DmAttachments attachments?;
    # Text of the message.
    @constraint:String {minLength: 1}
    string text;
};

# Promoted nonpublic engagement metrics for the Media at the time of the request.
public type Video_promoted_metrics record {
    # Number of users who made it through 0% of the video.
    int:Signed32 playback_0_count?;
    # Number of users who made it through 100% of the video.
    int:Signed32 playback_100_count?;
    # Number of users who made it through 25% of the video.
    int:Signed32 playback_25_count?;
    # Number of users who made it through 50% of the video.
    int:Signed32 playback_50_count?;
    # Number of users who made it through 75% of the video.
    int:Signed32 playback_75_count?;
    # Number of times this video has been viewed.
    int:Signed32 view_count?;
};

public type Get2SpacesIdTweetsResponse record {
    @constraint:Array {minLength: 1}
    Tweet[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

# The count for the bucket.
public type TweetCount int;

# A tag meant for the labeling of user provided rules.
public type RuleTag string;

# The rule you have submitted is invalid.
public type InvalidRuleProblem Problem;

public type Get2TweetsIdRetweetedByResponse record {
    @constraint:Array {minLength: 1}
    User[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

# Represent the portion of text recognized as a URL.
public type UrlFields record {
    # Description of the URL landing page.
    string description?;
    # The URL as displayed in the Twitter client.
    string display_url?;
    # A validly formatted URL.
    Url expanded_url?;
    @constraint:Array {minLength: 1}
    UrlImage[] images?;
    # The Media Key identifier for this attachment.
    MediaKey media_key?;
    # HTTP Status Code.
    HttpStatusCode status?;
    # Title of the page the URL points to.
    string title?;
    # Fully resolved url.
    string unwound_url?;
    # A validly formatted URL.
    Url url;
};

public type Get2UsersIdListMembershipsResponse record {
    @constraint:Array {minLength: 1}
    List[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

public type TweetCreateRequest record {|
    # Card Uri Parameter. This is mutually exclusive from Quote Tweet Id, Poll, Media, and Direct Message Deep Link.
    string card_uri?;
    # Link to take the conversation from the public timeline to a private Direct Message.
    string direct_message_deep_link?;
    # Exclusive Tweet for super followers.
    boolean for_super_followers_only?;
    # Place ID being attached to the Tweet for geo location.
    TweetCreateRequest_geo geo?;
    # Media information being attached to created Tweet. This is mutually exclusive from Quote Tweet Id, Poll, and Card URI.
    TweetCreateRequest_media media?;
    # Nullcasted (promoted-only) Tweets do not appear in the public timeline and are not served to followers.
    boolean nullcast?;
    # Poll options for a Tweet with a poll. This is mutually exclusive from Media, Quote Tweet Id, and Card URI.
    TweetCreateRequest_poll poll?;
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId quote_tweet_id?;
    # Tweet information of the Tweet being replied to.
    TweetCreateRequest_reply reply?;
    # Settings to indicate who can reply to the Tweet.
    "following"|"mentionedUsers" reply_settings?;
    # The content of the Tweet.
    TweetText text?;
|};

public type Get2SpacesSearchResponse record {
    @constraint:Array {minLength: 1}
    Space[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2ComplianceJobsResponse_meta meta?;
};

public type TweetDeleteComplianceSchema record {
    TweetComplianceSchema delete;
};

public type MuteUserMutationResponse_data record {
    boolean muting?;
};

# A problem that indicates that the authentication used is not supported.
public type UnsupportedAuthenticationProblem Problem;

public type TweetComplianceSchema record {
    # Event time.
    string event_at;
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId quote_tweet_id?;
    TweetComplianceSchema_tweet tweet;
};

# A base36 pagination token.
@constraint:String {minLength: 1}
public type PaginationToken36 string;

# Engagement metrics for the Tweet at the time of the request.
public type Tweet_public_metrics record {
    # Number of times this Tweet has been viewed.
    int:Signed32 impression_count;
    # Number of times this Tweet has been liked.
    int like_count;
    # Number of times this Tweet has been quoted.
    int quote_count?;
    # Number of times this Tweet has been replied to.
    int reply_count;
    # Number of times this Tweet has been Retweeted.
    int retweet_count;
};

# Your client has gone away.
public type ClientDisconnectedProblem Problem;

# Represent a boundary range (start and end index) for a recognized entity (for example a hashtag or a mention). `start` must be smaller than `end`.  The start index is inclusive, the end index is inclusive.
public type EntityIndicesInclusiveInclusive record {
    # Index (zero-based) at which position this entity ends.  The index is inclusive.
    @constraint:Int {minValue: 0}
    int end;
    # Index (zero-based) at which position this entity starts.  The index is inclusive.
    @constraint:Int {minValue: 0}
    int 'start;
};

public type BookmarkAddRequest record {
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId tweet_id;
};

public type Get2TweetsSearchAllResponse record {
    @constraint:Array {minLength: 1}
    Tweet[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2TweetsSearchAllResponse_meta meta?;
};

public type TweetTakedownComplianceSchema record {
    # Event time.
    string event_at;
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId quote_tweet_id?;
    TweetComplianceSchema_tweet tweet;
    @constraint:Array {minLength: 1}
    CountryCode[] withheld_in_countries;
};

public type Get2TweetsSample10StreamResponse record {
    Tweet data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};

public type ListMutateResponse record {
    ListMutateResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

# Represent the information for the URL image.
public type UrlImage record {
    # The height of the media in pixels.
    MediaHeight height?;
    # A validly formatted URL.
    Url url?;
    # The width of the media in pixels.
    MediaWidth width?;
};

# The newest id in this response.
public type NewestId string;

public type Get2UsersIdLikedTweetsResponse record {
    @constraint:Array {minLength: 1}
    Tweet[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

public type Get2TweetsSearchRecentResponse record {
    @constraint:Array {minLength: 1}
    Tweet[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2TweetsSearchAllResponse_meta meta?;
};

# Unique identifier of this poll.
@constraint:String {pattern: re `^[0-9]{1,19}$`}
public type PollId string;

# Attachments to a DM Event.
public type DmAttachments DmMediaAttachment[];

# The filterlang value of the rule.
public type RuleValue string;

# Represent the portion of text recognized as a Cashtag, and its start and end position within the text.
public type CashtagFields record {
    string tag;
};

# Unique identifier of a DM conversation. This can either be a numeric string, or a pair of numeric strings separated by a '-' character in the case of one-on-one DM Conversations.
public type DmConversationId string;

public type UserScrubGeoSchema record {
    UserScrubGeoObjectSchema scrub_geo;
};

public type Get2DmEventsResponse record {
    @constraint:Array {minLength: 1}
    DmEvent[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

# A problem that indicates the user's rule set is not compliant.
public type NonCompliantRulesProblem Problem;

public type Get2TweetsIdQuoteTweetsResponse_meta record {
    # The next token.
    NextToken next_token?;
    # The number of results returned in this response.
    ResultCount result_count?;
};

public type TweetHideResponse record {
    TweetHideResponse_data data?;
};

public type Get2UsersIdBookmarksResponse record {
    @constraint:Array {minLength: 1}
    Tweet[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

public type Get2UsersIdMentionsResponse_meta record {
    # The newest id in this response.
    NewestId newest_id?;
    # The next token.
    NextToken next_token?;
    # The oldest id in this response.
    OldestId oldest_id?;
    # The previous token.
    PreviousToken previous_token?;
    # The number of results returned in this response.
    ResultCount result_count?;
};

# The width of the media in pixels.
@constraint:Int {minValue: 0}
public type MediaWidth int;

public type BookmarkMutationResponse_data record {
    boolean bookmarked?;
};

# Media information being attached to created Tweet. This is mutually exclusive from Quote Tweet Id, Poll, and Card URI.
public type TweetCreateRequest_media record {|
    # A list of Media Ids to be attached to a created Tweet.
    @constraint:Array {maxLength: 4, minLength: 1}
    MediaId[] media_ids;
    # A list of User Ids to be tagged in the media for created Tweet.
    @constraint:Array {maxLength: 10}
    UserId[] tagged_user_ids?;
|};

public type Get2SpacesByCreatorIdsResponse record {
    @constraint:Array {minLength: 1}
    Space[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2ComplianceJobsResponse_meta meta?;
};

public type Get2UsersIdOwnedListsResponse record {
    @constraint:Array {minLength: 1}
    List[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

# The oldest id in this response.
public type OldestId string;

public type CreateComplianceJobResponse record {
    ComplianceJob data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

# Represent a Search Count Result.
public type SearchCount record {
    # The end time of the bucket.
    End end;
    # The start time of the bucket.
    Start 'start;
    # The count for the bucket.
    TweetCount tweet_count;
};

# Represents the data for the context annotation domain.
public type ContextAnnotationDomainFields record {
    # Description of the context annotation domain.
    string description?;
    # The unique id for a context annotation domain.
    @constraint:String {pattern: re `^[0-9]{1,19}$`}
    string id;
    # Name of the context annotation domain.
    string name?;
};

# The identifier for this place.
public type PlaceId string;

public type Get2UsersIdTimelinesReverseChronologicalResponse record {
    @constraint:Array {minLength: 1}
    Tweet[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2UsersIdMentionsResponse_meta meta?;
};

public type Get2TweetsSearchAllResponse_meta record {
    # The newest id in this response.
    NewestId newest_id?;
    # The next token.
    NextToken next_token?;
    # The oldest id in this response.
    OldestId oldest_id?;
    # The number of results returned in this response.
    ResultCount result_count?;
};

public type Media record {
    # The height of the media in pixels.
    MediaHeight height?;
    # The Media Key identifier for this attachment.
    MediaKey media_key?;
    string 'type;
    # The width of the media in pixels.
    MediaWidth width?;
};

# A 'long' pagination token.
@constraint:String {maxLength: 19, minLength: 1}
public type PaginationTokenLong string;

public type UsersRetweetsDeleteResponse record {
    UsersRetweetsCreateResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

# A response from modifying user-specified stream filtering rules.
public type AddOrDeleteRulesResponse record {
    # All user-specified stream filtering rules that were created.
    Rule[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    RulesResponseMetadata meta;
};

public type Get2ComplianceJobsIdResponse record {
    ComplianceJob data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

# The location tagged on the Tweet, if the user provided one.
public type Tweet_geo record {
    # A [GeoJson Point](https://tools.ietf.org/html/rfc7946#section-3.1.2) geometry object.
    Point coordinates?;
    # The identifier for this place.
    PlaceId place_id?;
};

# Status of a compliance job.
public type ComplianceJobStatus "created"|"in_progress"|"failed"|"complete"|"expired";

public type CreateMessageRequest CreateTextMessageRequest|CreateAttachmentsMessageRequest;

public type TweetCreateResponse record {
    TweetCreateResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

# Poll options for a Tweet with a poll. This is mutually exclusive from Media, Quote Tweet Id, and Card URI.
public type TweetCreateRequest_poll record {|
    # Duration of the poll in minutes.
    @constraint:Int {minValue: 5, maxValue: 10080}
    int:Signed32 duration_minutes;
    @constraint:Array {maxLength: 4, minLength: 2}
    Tweetcreaterequest_pollOptionsItemsString[] options;
    # Settings to indicate who can reply to the Tweet.
    "following"|"mentionedUsers" reply_settings?;
|};

# The height of the media in pixels.
@constraint:Int {minValue: 0}
public type MediaHeight int;

public type TweetUndropComplianceSchema record {
    TweetComplianceSchema undrop;
};

public type Get2UsersIdResponse record {
    # The Twitter User object.
    User data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};

# A Tweet or error that can be returned by the streaming Tweet API. The values returned with a successful streamed Tweet includes the user provided rules that the Tweet matched.
public type FilteredStreamingTweetResponse record {
    Tweet data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    # The list of rules which matched the Tweet
    FilteredStreamingTweetResponse_matching_rules[] matching_rules?;
};

# Tweet label stream events.
public type TweetLabelStreamResponse record {
    # Tweet label data.
    TweetLabelData data;
}|record {@constraint:Array {minLength: 1}
    Problem[] errors;};

# The Twitter User object.
public type User record {
    # Creation time of this User.
    string created_at?;
    # The text of this User's profile description (also known as bio), if the User provided one.
    string description?;
    # A list of metadata found in the User's profile description.
    User_entities entities?;
    # Unique identifier of this User. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    UserId id;
    # The location specified in the User's profile, if the User provided one. As this is a freeform value, it may not indicate a valid location, but it may be fuzzily evaluated when performing searches with location queries.
    string location?;
    # The friendly name of this User, as shown on their profile.
    string name;
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId pinned_tweet_id?;
    # The URL to the profile image for this User.
    string profile_image_url?;
    # Indicates if this User has chosen to protect their Tweets (in other words, if this User's Tweets are private).
    boolean protected?;
    # A list of metrics for this User.
    User_public_metrics public_metrics?;
    # The URL specified in the User's profile.
    string url?;
    # The Twitter handle (screen name) of this user.
    UserName username;
    # Indicate if this User is a verified Twitter User.
    boolean verified?;
    # The Twitter Blue verified type of the user, eg: blue, government, business or none.
    string verified_type?;
    # Indicates withholding details for [withheld content](https://help.twitter.com/en/rules-and-policies/tweet-withheld-by-country).
    UserWithheld withheld?;
};

# The next token.
@constraint:String {minLength: 1}
public type NextToken string;

# Unique identifier of this rule.
@constraint:String {pattern: re `^[0-9]{1,19}$`}
public type RuleId string;

# The rule you have submitted is a duplicate.
public type DuplicateRuleProblem record {
    *Problem;
    string id?;
    string value?;
};

public type UsersRetweetsCreateResponse_data record {
    boolean retweeted?;
};

public type UserTakedownComplianceSchema record {
    # Event time.
    string event_at;
    UserComplianceSchema_user user;
    @constraint:Array {minLength: 1}
    CountryCode[] withheld_in_countries;
};

public type Get2UsersIdMutingResponse record {
    @constraint:Array {minLength: 1}
    User[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

# The Media Key identifier for this attachment.
@constraint:String {pattern: re `^([0-9]+)_([0-9]+)$`}
public type MediaKey string;

# The unique identifier of this List.
@constraint:String {pattern: re `^[0-9]{1,19}$`}
public type ListId string;

public type Get2DmConversationsIdDmEventsResponse record {
    @constraint:Array {minLength: 1}
    DmEvent[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

public type InvalidRequestProblem_errors record {
    string message?;
    record {|string[]...;|} parameters?;
};

public type UserUnsuspendComplianceSchema record {
    UserComplianceSchema user_unsuspend;
};

# Unique identifier of this Topic.
public type TopicId string;

public type TweetEditComplianceSchema record {
    TweetEditComplianceObjectSchema tweet_edit;
};

# You have been disconnected for operational reasons.
public type OperationalDisconnectProblem record {
    *Problem;
    "OperationalDisconnect"|"UpstreamOperationalDisconnect"|"ForceDisconnect"|"UpstreamUncleanDisconnect"|"SlowReader"|"InternalError"|"ClientApplicationStateDegraded"|"InvalidRules" disconnect_type?;
};

# A two-letter ISO 3166-1 alpha-2 country code.
@constraint:String {pattern: re `^[A-Z]{2}$`}
public type CountryCode string;

# The topic of a Space, as selected by its creator.
public type Topic record {
    # The description of the given topic.
    string description?;
    # Unique identifier of this Topic.
    TopicId id;
    # The name of the given topic.
    string name;
};

# Compliance Job ID.
@constraint:String {pattern: re `^[0-9]{1,19}$`}
public type JobId string;

public type TweetUnviewable record {
    # If the label is being applied or removed. Possible values are ‘apply’ or ‘remove’.
    string application;
    # Event time.
    string event_at;
    TweetComplianceSchema_tweet tweet;
};

public type UserProfileModificationComplianceSchema record {
    UserProfileModificationObjectSchema user_profile_modification;
};

public type Get2UsersIdPinnedListsResponse record {
    @constraint:Array {minLength: 1}
    List[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2ComplianceJobsResponse_meta meta?;
};

public type MentionEntity record {
    *EntityIndicesInclusiveExclusive;
    *MentionFields;
};

public type Get2TweetsCountsAllResponse_meta record {
    # The newest id in this response.
    NewestId newest_id?;
    # The next token.
    NextToken next_token?;
    # The oldest id in this response.
    OldestId oldest_id?;
    # The sum of results returned in this response.
    Aggregate total_tweet_count?;
};

public type UsersLikesCreateRequest record {
    # Unique identifier of this Tweet. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
    TweetId tweet_id;
};

public type ListDeleteResponse record {
    ListDeleteResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

# The unique identifier of this Space.
@constraint:String {pattern: re `^[a-zA-Z0-9]{1,13}$`}
public type SpaceId string;

public type TweetDeleteResponse record {
    TweetDeleteResponse_data data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
};

public type Error record {
    int:Signed32 code;
    string message;
};

# Expiration time of the upload URL.
public type UploadExpiration string;

# A [GeoJson Point](https://tools.ietf.org/html/rfc7946#section-3.1.2) geometry object.
public type Point record {
    # A [GeoJson Position](https://tools.ietf.org/html/rfc7946#section-3.1.1) in the format `[longitude,latitude]`.
    Position coordinates;
    "Point" 'type;
};

public type Get2UsersIdMentionsResponse record {
    @constraint:Array {minLength: 1}
    Tweet[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2UsersIdMentionsResponse_meta meta?;
};

public type Get2ListsIdTweetsResponse record {
    @constraint:Array {minLength: 1}
    Tweet[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
    Get2DmConversationsIdDmEventsResponse_meta meta?;
};

public type Get2ComplianceJobsResponse_meta record {
    # The number of results returned in this response.
    ResultCount result_count?;
};

# An array of all available variants of the media.
public type Variants Variant[];

public type ListCreateRequest record {
    @constraint:String {maxLength: 100}
    string description?;
    @constraint:String {maxLength: 25, minLength: 1}
    string name;
    boolean 'private = false;
};

# Unique identifier of this User. This is returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
@constraint:String {pattern: re `^[0-9]{1,19}$`}
public type UserId string;

# Represent a Poll attached to a Tweet.
public type Poll record {
    @constraint:Int {minValue: 5, maxValue: 10080}
    int:Signed32 duration_minutes?;
    string end_datetime?;
    # Unique identifier of this poll.
    PollId id;
    @constraint:Array {maxLength: 4, minLength: 2}
    PollOption[] options;
    "open"|"closed" voting_status?;
};

# Indicates withholding details for [withheld content](https://help.twitter.com/en/rules-and-policies/tweet-withheld-by-country).
public type UserWithheld record {
    # Provides a list of countries where this content is not available.
    @constraint:Array {minLength: 1}
    CountryCode[] country_codes;
    # Indicates that the content being withheld is a `user`.
    "user" scope?;
};

public type Get2UsersResponse record {
    @constraint:Array {minLength: 1}
    User[] data?;
    @constraint:Array {minLength: 1}
    Problem[] errors?;
    Expansions includes?;
};
