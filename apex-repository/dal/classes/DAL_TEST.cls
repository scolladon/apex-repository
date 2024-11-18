@isTest
private class DAL_TEST {
  /*@isTest
  static void givenDALisMocked_whenMockingAgain_thenMockIsReset() {
    // Arrange
    DAL.Stub dalStub = DAL.mock();
    RepositoryService repoService = DAL.repoService;

    // Act
    DAL.Stub newdalStub = DAL.mock();

    // Assert
    RepositoryService newRepoService = DAL.repoService;
    Assert.isTrue(repoService !== newRepoService);
    Assert.isTrue(dalStub !== newdalStub);
  }
@isTest
  static void givenDAL_whenModeisSet_thenItChangeMode() {
    // Arrange
    RepositoryService repoService = DAL.repoService;
    Assert.isNotNull(repoService);

    // Act & Assert
    repoService = DAL.repoService;
    DAL.setSystemMode();
    Assert.isTrue(repoService !== DAL.repoService);

    repoService = DAL.repoService;
    DAL.setDefaultMode();
    Assert.isTrue(repoService !== DAL.repoService);

    repoService = DAL.repoService;
    DAL.setSystemWithSharingMode();
    Assert.isTrue(repoService !== DAL.repoService);

    repoService = DAL.repoService;
    DAL.setUserMode();
    Assert.isTrue(repoService !== DAL.repoService);
  }*/

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
    MethodSpy updateSpy = dalStub.spyOnUpdate();
    MethodSpy upsertSpy = dalStub.spyOnUpsert();
    MethodSpy deleteSpy = dalStub.spyOnDelete();
    MethodSpy undeleteSpy = dalStub.spyOnUndelete();
    MethodSpy querySpy = dalStub.spyOnQuery();
    MethodSpy findSpy = dalStub.spyOnFind();
    Expect.that(insertSpy).hasNotBeenCalled();
    Expect.that(updateSpy).hasNotBeenCalled();
    Expect.that(upsertSpy).hasNotBeenCalled();
    Expect.that(deleteSpy).hasNotBeenCalled();
    Expect.that(undeleteSpy).hasNotBeenCalled();
    Expect.that(querySpy).hasNotBeenCalled();
    Expect.that(findSpy).hasNotBeenCalled();

    // Act & Assert
    DAL.insertRecords(new List<Account>{ new Account(Name = 'test') });
    Expect.that(insertSpy).hasBeenCalled();

    DAL.updateRecords(new List<Account>{ new Account(Name = 'test') });
    Expect.that(updateSpy).hasBeenCalled();

    DAL.upsertRecords(new List<Account>{ new Account(Name = 'test') }, Account.Id);
    Expect.that(upsertSpy).hasBeenCalled();

    DAL.deleteRecords(new List<Account>{ new Account(Name = 'test') });
    Expect.that(deleteSpy).hasBeenCalled();

    DAL.undeleteRecords(new List<Account>{ new Account(Name = 'test') });
    Expect.that(undeleteSpy).hasBeenCalled();

    DAL.query([SELECT Id FROM Account]);
    Expect.that(querySpy).hasBeenCalled();

    DAL.find([FIND 'Test' IN NAME FIELDS RETURNING Account(Id, Name)]);
    Expect.that(findSpy).hasBeenCalled();
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
