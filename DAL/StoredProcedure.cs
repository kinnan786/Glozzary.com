/// <summary>
///     Summary description for StoredProcedure
/// </summary>
public class StoredProcedure
{
    public enum Names
    {
        GetRateableemotionPlugin,
        GetGenerateScript,
        spRateableEmotionIntellisense,
        spUpdateRateableEmotion,
        spGetRateableEmotionByEmotionGroupId,
        spAddRateableEmotion,
        spGetRateableEmotion,
        spDeleteRateableEmotionGroup,
        spAddRateableEmotion_Emotion,
        spGetPremalinkEmotionsById,
        spSearchPremalink,
        spAddPremalinkimages,
        spGetUnParsedPremalik,
        spAddPremalinkMetaChar,
        spGetMetachars,
        spGetAllEmotion,
        spExplorehNewsFeed,
        spAddUserCoverImage,
        spUpdateUsercoverphoto,
        spUpdateUserProfileImage,
        spGetUserTagFeed,
        spGetUserPassword,
        spUpdatePassword,
        spGetEmoNewsFeed,
        spGetAllWebSite,
        spGetTagByWebsite,
        spGetEmotionByWebsite,
        spGetWebsiteFeed,
        spSearchWebsite,
        spGetIntellisense,
        //Tags
        spDeleteTag,
        spRegisterWebsiteAndUser,
        spGetPremalinkById,
        spGetWebsiteByName,
        spGetWebsiteTags,
        spGetTagNewsFeed,
        spAddTaggedEmotion,
        spAddTagged,
        spDecrementTaggedEmotion,
        spIncrementTaggedEmotion,
        spGetTaggedEmotion,
        spVoteTagged,
        spAssociateTag,
        spGetTag,
        IncrementTag,
        GetEmotions,

        AddEmotions
        ,

        spSearchTagIntellisense
        ,

        GetAllTags
        ,

        GetUserPassword
        ,

        SearchTags
        ,

        spVoteTag
        ,

        spWhatTagIntellisense
        ,

        spHowTagIntellisense
        ,

        spWhenTagIntellisense
        ,

        spWhereTagIntellisense
        ,

        spWhoTagIntellisense
        ,

        spWhyTagIntellisense
        ,

        spGetAllTag
        ,

        spGetAllTags
        ,

        spAddTag
        ,

        spGetTagId
        ,

        spGetTagsbyPremalink
        ,

        spTagIntellisense
        ,

        spGetUserTags
        ,

        spVoteUserTag
        ,

        spAddUserTag
        ,
        spGetExploreNewsFeed,

        spGetTagged,

        spGetTagById
        //Users
        ,

        RegisterUser
        ,

        spUpdateUser
        ,

        spAuthenticateUser
        ,

        spGetUserGeneralInfo
        ,

        UpdatePassword
        ,

        spVerifyEmail
        ,

        spAddUserImage
        ,

        spGetUserImage
        ,
        spGetTagByUser,

        spGetUserNewsFeed
        ,

        spUpdateUserImage
        ,

        spDeleteUserImage
        ,

        spVoteContent
        //Website
        ,

        spRegisterWebsite
        ,

        spUpdateWebsite
        ,

        spGetUserWebsite
        ,

        spGetWebsiteById
        ,

        spGetWebsiteType
        //Premalink
        ,

        spGetWebsitePremalink
        ,

        DeactivateTagToWebsite
        ,

        spGetPremalinkTagsById
        ,

        spGetTaggedpremaLink
        ,

        spAddPremalink

        //subscription
        ,

        spGetUserTagSubscription
        ,

        spDeleteUserTagSubscription
        ,

        spAddUserTagSubscription
        ,

        GetUserNewsFeed
        ,

        spFacebookAuthentication
        ,

        spGetTableCoulmns
        ,

        spGetAllPages

        //Emotions
        ,

        spGetPremalinkEmotions
        ,

        spIncrementEmotion
        ,

        spDecrementEmotion
        ,

        spEmotionIntellisense
        ,

        spAddEmotion
        ,

        spGetEmotionByUser
        ,

        spGetUserEmotion
        ,

        spIncrementUserEmotion
        ,

        spDecrementUserEmotion
        ,

        spAddUserEmotion

        //Taxonomy
        ,

        spGetTaxonomy
        ,

        spAddTaxonomy
        ,

        spUpdateTaxonomy
        ,
        spRegisterUser
    }
}