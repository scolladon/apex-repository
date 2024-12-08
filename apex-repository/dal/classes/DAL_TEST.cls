@isTest
private class DAL_TEST {
  @isTest
  static void givenDALisMocked_whenMockingAgain_thenMockIsReset() {
    // Arrange
    DAL.Stub dalStub = DAL.mock();
    IDAL repoServiceProxy = DAL.repoServiceProxy;

    // Act
    DAL.Stub newdalStub = DAL.mock();

    // Assert
    Assert.isTrue(repoServiceProxy !== DAL.repoServiceProxy);
    Assert.isTrue(dalStub !== newdalStub);
  }

  @isTest
  static void givenDAL_whenModeisSet_thenItChangeMode() {
    // Arrange
    RepositoryService repoService = DAL.repoServiceProxy.getRepositoryService();
    Assert.isNotNull(repoService);

    // Act & Assert
    repoService = DAL.repoServiceProxy.getRepositoryService();
    DAL.setSystemWithSharingMode();
    Assert.isTrue(repoService !== DAL.repoServiceProxy.getRepositoryService());

    repoService = DAL.repoServiceProxy.getRepositoryService();
    DAL.setSystemMode();
    Assert.isTrue(repoService !== DAL.repoServiceProxy.getRepositoryService());

    repoService = DAL.repoServiceProxy.getRepositoryService();
    DAL.setUserMode();
    Assert.isTrue(repoService !== DAL.repoServiceProxy.getRepositoryService());

    repoService = DAL.repoServiceProxy.getRepositoryService();
    DAL.setDefaultMode();
    Assert.isTrue(repoService !== DAL.repoServiceProxy.getRepositoryService());
  }

  @isTest
  static void givenDAL_whenCallingMethods_thenItResetDefaultMode() {
    // Arrange
    DAL.setDefaultMode();
    RepositoryService defaultModeRepoService = DAL.repoServiceProxy.getRepositoryService();
    Assert.isNotNull(defaultModeRepoService);

    // Act & Assert
    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.insertRecords(new List<SObject>());
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.insertRecords(new List<SObject>(), new Database.DMLOptions());
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.insertRecordsPartially(new List<SObject>());
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.updateRecords(new List<SObject>());
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.updateRecords(new List<SObject>(), new Database.DMLOptions());
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.updateRecordsPartially(new List<SObject>());
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.upsertRecords(new List<SObject>(), Account.Id);
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.upsertRecordsPartially(new List<SObject>(), Account.Id);
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.deleteRecords(new List<SObject>());
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.deleteRecordsPartially(new List<SObject>());
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.undeleteRecords(new List<SObject>());
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.undeleteRecordsPartially(new List<SObject>());
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.query([SELECT Id FROM Account]);
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.query('SELECT Id FROM Account', new Map<String, Object>());
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.find([FIND 'Test' IN NAME FIELDS RETURNING Account(Id, Name)]);
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());

    DAL.setUserMode();
    Assert.isTrue(defaultModeRepoService !== DAL.repoServiceProxy.getRepositoryService());
    DAL.find('FIND \'Test\' IN NAME FIELDS RETURNING Account (Id, Name)');
    Assert.isTrue(defaultModeRepoService === DAL.repoServiceProxy.getRepositoryService());
  }

  @isTest
  static void givenDAL_whenCallingMethodsWithMode_thenItResetDefaultMode() {
    // Arrange
    DAL.Stub dalStub = DAL.mock();
    MethodSpy setRepoSpy = dalStub.spyOnSetRepositoryService();
    MethodSpy insertSpy = dalStub.spyOnInsert();
    MethodSpy insertPartiallySpy = dalStub.spyOnInsertPartially();
    MethodSpy updateSpy = dalStub.spyOnUpdate();
    MethodSpy updatePartiallySpy = dalStub.spyOnUpdatePartially();
    MethodSpy upsertSpy = dalStub.spyOnUpsert();
    MethodSpy upsertPartiallySpy = dalStub.spyOnUpsertPartially();
    MethodSpy deleteSpy = dalStub.spyOnDelete();
    MethodSpy deletePartiallySpy = dalStub.spyOnDeletePartially();
    MethodSpy undeleteSpy = dalStub.spyOnUndelete();
    MethodSpy undeletePartiallySpy = dalStub.spyOnUndeletePartially();
    MethodSpy querySpy = dalStub.spyOnQuery();
    MethodSpy findSpy = dalStub.spyOnFind();
    Integer callCount = 0;

    // Act & Assert
    DAL.insertRecords(new List<SObject>(), DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(insertSpy).hasBeenCalledWith(Argument.ofType(List<SObject>.class));

    DAL.insertRecords(new List<SObject>(), new Database.DMLOptions(), DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(insertSpy).hasBeenCalledWith(Argument.ofType(List<SObject>.class));

    DAL.insertRecordsPartially(new List<SObject>(), DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(insertPartiallySpy).hasBeenCalledWith(Argument.ofType(List<SObject>.class));

    DAL.updateRecords(new List<SObject>(), DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(updateSpy).hasBeenCalledWith(Argument.ofType(List<SObject>.class));

    DAL.updateRecords(new List<SObject>(), new Database.DMLOptions(), DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(updateSpy).hasBeenCalledWith(Argument.ofType(List<SObject>.class));

    DAL.updateRecordsPartially(new List<SObject>(), DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(updatePartiallySpy).hasBeenCalledWith(Argument.ofType(List<SObject>.class));

    DAL.upsertRecords(new List<SObject>(), Account.Id, DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(upsertSpy).hasBeenCalledWith(Argument.ofType(List<SObject>.class), Argument.ofType(SObjectField.class));

    DAL.upsertRecordsPartially(new List<SObject>(), Account.Id, DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(upsertPartiallySpy).hasBeenCalledWith(Argument.ofType(List<SObject>.class), Argument.ofType(SObjectField.class));

    DAL.deleteRecords(new List<SObject>(), DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(deleteSpy).hasBeenCalledWith(Argument.ofType(List<SObject>.class));

    DAL.deleteRecordsPartially(new List<SObject>(), DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(deletePartiallySpy).hasBeenCalledWith(Argument.ofType(List<SObject>.class));

    DAL.undeleteRecords(new List<SObject>(), DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(undeleteSpy).hasBeenCalledWith(Argument.ofType(List<SObject>.class));

    DAL.undeleteRecordsPartially(new List<SObject>(), DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(undeletePartiallySpy).hasBeenCalledWith(Argument.ofType(List<SObject>.class));

    DAL.query([SELECT Id FROM Account], DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(querySpy).hasBeenCalledWith(Argument.ofType(List<SObject>.class));

    DAL.query('SELECT Id FROM Account', new Map<String, Object>(), DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(querySpy).hasBeenCalledWith(Argument.ofType(String.class), Argument.ofType(Map<String, Object>.class));

    DAL.find([FIND 'Test' IN NAME FIELDS RETURNING Account(Id, Name)], DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(findSpy).hasBeenCalledWith(Argument.ofType(List<List<SObject>>.class));

    DAL.find('FIND \'Test\' IN NAME FIELDS RETURNING Account (Id, Name)', DAL.DALMode.USER_MODE);
    callCount += 2;
    Expect.that(setRepoSpy).hasBeenCalledTimes(callCount);
    Expect.that(findSpy).hasBeenCalledWith(Argument.ofType(String.class));
  }

  @isTest
  static void givenDALisMocked_whenChangingMode_thenMockStillApplies() {
    // Arrange
    DAL.Stub dalStub = DAL.mock();
    MethodSpy insertSpy = dalStub.spyOnInsert();
    DAL.setDefaultMode();
    Expect.that(insertSpy).hasNotBeenCalled();

    // Act
    DAL.insertRecords(new List<Account>{ new Account(Name = 'test') });

    // Assert
    Expect.that(insertSpy).hasBeenCalledTimes(1);
  }

  @isTest
  static void givenDALisMocked_whenCallingAPI_thenItCallsMock() {
    // Arrange
    DAL.Stub dalStub = DAL.mock();
    MethodSpy insertSpy = dalStub.spyOnInsert();
    MethodSpy insertPartiallySpy = dalStub.spyOnInsertPartially();
    MethodSpy updateSpy = dalStub.spyOnUpdate();
    MethodSpy updatePartiallySpy = dalStub.spyOnUpdatePartially();
    MethodSpy upsertSpy = dalStub.spyOnUpsert();
    MethodSpy upsertPartiallySpy = dalStub.spyOnUpsertPartially();
    MethodSpy deleteSpy = dalStub.spyOnDelete();
    MethodSpy deletePartiallySpy = dalStub.spyOnDeletePartially();
    MethodSpy undeleteSpy = dalStub.spyOnUndelete();
    MethodSpy undeletePartiallySpy = dalStub.spyOnUndeletePartially();
    MethodSpy querySpy = dalStub.spyOnQuery();
    MethodSpy findSpy = dalStub.spyOnFind();
    Expect.that(insertSpy).hasNotBeenCalled();
    Expect.that(insertPartiallySpy).hasNotBeenCalled();
    Expect.that(updateSpy).hasNotBeenCalled();
    Expect.that(updatePartiallySpy).hasNotBeenCalled();
    Expect.that(upsertSpy).hasNotBeenCalled();
    Expect.that(upsertPartiallySpy).hasNotBeenCalled();
    Expect.that(deleteSpy).hasNotBeenCalled();
    Expect.that(deletePartiallySpy).hasNotBeenCalled();
    Expect.that(undeleteSpy).hasNotBeenCalled();
    Expect.that(undeletePartiallySpy).hasNotBeenCalled();
    Expect.that(querySpy).hasNotBeenCalled();
    Expect.that(findSpy).hasNotBeenCalled();

    // Act & Assert
    DAL.insertRecords(new List<Account>{ new Account(Name = 'test') });
    Expect.that(insertSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.insertRecordsPartially(new List<Account>{ new Account(Name = 'test') });
    Expect.that(insertPartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.updateRecords(new List<Account>{ new Account(Name = 'test') });
    Expect.that(updateSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.updateRecordsPartially(new List<Account>{ new Account(Name = 'test') });
    Expect.that(updatePartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.upsertRecords(new List<Account>{ new Account(Name = 'test') }, Account.Id);
    Expect.that(upsertSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), Argument.ofType(Schema.SObjectField.class));

    DAL.upsertRecordsPartially(new List<Account>{ new Account(Name = 'test') }, Account.Id);
    Expect.that(upsertPartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), Argument.ofType(Schema.SObjectField.class));

    DAL.deleteRecords(new List<Account>{ new Account(Name = 'test') });
    Expect.that(deleteSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.deleteRecordsPartially(new List<Account>{ new Account(Name = 'test') });
    Expect.that(deletePartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.undeleteRecords(new List<Account>{ new Account(Name = 'test') });
    Expect.that(undeleteSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.undeleteRecordsPartially(new List<Account>{ new Account(Name = 'test') });
    Expect.that(undeletePartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.query([SELECT Id FROM Account]);
    Expect.that(querySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.find([FIND 'Test' IN NAME FIELDS RETURNING Account(Id, Name)]);
    Expect.that(findSpy).hasBeenCalledWith(Argument.ofType(List<List<Account>>.class));
  }

  @isTest
  static void givenDALisMocked_whenUnmocking_thenMockStopApplying() {
    // Arrange
    DAL.Stub dalStub = DAL.mock();
    MethodSpy insertSpy = dalStub.spyOnInsert();
    Expect.that(insertSpy).hasNotBeenCalled();
    DAL.unmock();

    // Act
    DAL.insertRecords(new List<Account>{ new Account(Name = 'test') });

    // Assert
    Expect.that(insertSpy).hasNotBeenCalled();
  }

  @isTest
  static void givenDAL_whenInsertRecordsIsCalled_thenItTriesToInsertRecords() {
    // Arrange
    Account acc = new Account(Name = 'Test');

    // Act
    List<Database.SaveResult> results = DAL.insertRecords(new List<Account>{ acc });
    List<Database.SaveResult> resultsOptions = DAL.insertRecords(new List<Account>{ acc }, new Database.DMLOptions());
    List<Database.SaveResult> resultsPartially = DAL.insertRecordsPartially(new List<Account>{ acc });

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual(1, resultsOptions.size());
    Assert.areEqual(1, resultsPartially.size());
  }

  @isTest
  static void givenDAL_whenUpdateRecordsIsCalled_thenItTriesToUpdateRecords() {
    // Arrange
    Account acc = new Account(Name = 'Test');

    // Act
    List<Database.SaveResult> results = DAL.updateRecords(new List<Account>{ acc });
    List<Database.SaveResult> resultsOptions = DAL.updateRecords(new List<Account>{ acc }, new Database.DMLOptions());
    List<Database.SaveResult> resultsPartially = DAL.updateRecordsPartially(new List<Account>{ acc });

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual(1, resultsOptions.size());
    Assert.areEqual(1, resultsPartially.size());
  }

  @isTest
  static void givenDAL_whenUpsertRecordsIsCalled_thenItTriesToUpsertRecords() {
    // Arrange
    Account acc = new Account(Name = 'Test');

    // Act
    List<Database.UpsertResult> results = DAL.upsertRecords(new List<Account>{ acc }, Account.Id);
    List<Database.UpsertResult> resultsPartially = DAL.upsertRecordsPartially(new List<Account>{ acc }, Account.Id);

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual(1, resultsPartially.size());
  }

  @isTest
  static void givenDAL_whenDeleteRecordsIsCalled_thenItTriesToDeleteRecords() {
    // Arrange
    Account acc = new Account(Name = 'Test');
    insert acc;

    // Act
    List<Database.DeleteResult> results = DAL.deleteRecords(new List<Account>{ acc });
    List<Database.DeleteResult> resultsPartially = DAL.deleteRecordsPartially(new List<Account>{ acc });

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual(1, resultsPartially.size());
  }

  @isTest
  static void givenDAL_whenUndeleteRecordsIsCalled_thenItTriesToUndeleteRecords() {
    // Arrange
    Account acc = new Account(Name = 'Test');
    insert acc;
    delete acc;

    // Act
    List<Database.UndeleteResult> results = DAL.undeleteRecords(new List<Account>{ acc });
    List<Database.UndeleteResult> resultsPartially = DAL.undeleteRecordsPartially(new List<Account>{ acc });

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual(1, resultsPartially.size());
  }

  @isTest
  static void givenDAL_whenQueryIsCalled_thenItTriesToQueryRecords() {
    // Act
    List<SObject> resultsStatic = DAL.query([SELECT Id FROM Account]);
    List<SObject> resultsDynamic = DAL.query('SELECT Id FROM Account', new Map<String, Object>());

    // Assert
    Assert.areEqual(0, resultsStatic.size());
    Assert.areEqual(0, resultsDynamic.size());
  }

  @isTest
  static void givenDAL_whenFindIsCalled_thenItTriesToFindRecords() {
    // Act
    List<List<SObject>> resultsStatic = DAL.find([FIND 'Test' IN NAME FIELDS RETURNING Account(Id, Name)]);
    List<List<SObject>> resultsDynamic = DAL.find('FIND \'Test\' IN NAME FIELDS RETURNING Account (Id, Name)');

    // Assert
    Assert.areEqual(0, resultsStatic[0].size());
    Assert.areEqual(0, resultsDynamic[0].size());
  }
}
