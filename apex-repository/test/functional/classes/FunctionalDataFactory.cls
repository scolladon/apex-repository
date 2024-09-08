@isTest
public class FunctionalDataFactory {
  static User canonicalUser = new User(EmailEncodingKey = 'UTF-8', LocaleSidKey = 'en_US', TimeZoneSidKey = 'Europe/Paris', LanguageLocaleKey = 'en_US');
  static Id ADMIN_PROFILE_ID = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;
  static Id MINIMUM_ACCESS_PROFILE_ID = [SELECT Id FROM Profile WHERE Name = 'Minimum Access - Salesforce'].Id;
  static Id TESTSUBJECT_PSET_ID = [SELECT Id FROM PermissionSet WHERE Name = 'RepositoryTestSubject_Access'].Id;

  public User getAdminUser() {
    return this.getUser('admin@test.io', FunctionalDataFactory.ADMIN_PROFILE_ID);
  }

  public User getMinimalAccessUser() {
    return this.getUser('min-access@test.io', FunctionalDataFactory.MINIMUM_ACCESS_PROFILE_ID);
  }

  private User getUser(final String userName, final Id profileId) {
    final User[] users = [SELECT Id FROM User WHERE UserName = :userName LIMIT 1];
    if (users.size() == 1) {
      return users[0];
    }
    final User aUser = FunctionalDataFactory.canonicalUser.clone(false);
    aUser.Alias = userName.left(8);
    aUser.LastName = userName;
    aUser.Email = userName;
    aUser.UserName = userName;
    aUser.ProfileId = profileId;
    insert aUser;

    PermissionSetAssignment assignment = new PermissionSetAssignment(AssigneeId = aUser.Id, PermissionSetId = TESTSUBJECT_PSET_ID);
    insert assignment;

    return aUser;
  }

  public RepositoryTestSubject__c buildTestSubject() {
    return new RepositoryTestSubject__c(Name = 'TestSubject');
  }
}
