User usr = [
    SELECT Id, UserPreferencesLightningExperiencePreferred
    FROM User
    WHERE UserPreferencesLightningExperiencePreferred = true
    AND IsActive = true
    AND Id = :UserInfo.getUserId() LIMIT 1
];
usr.UserPreferencesLightningExperiencePreferred = false;
update usr;