@isTest
private class DAL_TEST {
  @isTest
  static void givenDALisMocked_whenMockingAgain_thenMockIsReset() {
    // Arrange
    DAL.Stub dalStub = DAL.mock();
    IDAL dalInstance = DAL.instance;

    // Act
    DAL.Stub newdalStub = DAL.mock();

    // Assert
    Assert.isTrue(dalInstance !== DAL.instance);
    Assert.isTrue(dalStub !== newdalStub);
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
    MethodSpy queryAggregateSpy = dalStub.spyOnQueryAggregate();
    MethodSpy queryCountSpy = dalStub.spyOnQueryCount();
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
    Expect.that(queryAggregateSpy).hasNotBeenCalled();
    Expect.that(queryCountSpy).hasNotBeenCalled();
    Expect.that(findSpy).hasNotBeenCalled();

    // Act & Assert
    DAL.insertRecords(new List<Account>{ new Account(Name = 'test') });
    Expect.that(insertSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.insertRecords(new List<Account>{ new Account(Name = 'test') }, new Database.DMLOptions());
    Expect.that(insertSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), Argument.ofType(Database.DMLOptions.class));

    DAL.insertRecordsPartially(new List<Account>{ new Account(Name = 'test') });
    Expect.that(insertPartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.insertRecords(new List<Account>{ new Account(Name = 'test') }, AccessLevel.SYSTEM_MODE);
    Expect.that(insertSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), AccessLevel.SYSTEM_MODE);

    DAL.insertRecords(new List<Account>{ new Account(Name = 'test') }, new Database.DMLOptions(), AccessLevel.SYSTEM_MODE);
    Expect.that(insertSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), Argument.ofType(Database.DMLOptions.class), AccessLevel.SYSTEM_MODE);

    DAL.insertRecordsPartially(new List<Account>{ new Account(Name = 'test') }, AccessLevel.SYSTEM_MODE);
    Expect.that(insertPartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), AccessLevel.SYSTEM_MODE);

    DAL.updateRecords(new List<Account>{ new Account(Name = 'test') });
    Expect.that(updateSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.updateRecords(new List<Account>{ new Account(Name = 'test') }, new Database.DMLOptions());
    Expect.that(updateSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), Argument.ofType(Database.DMLOptions.class));

    DAL.updateRecordsPartially(new List<Account>{ new Account(Name = 'test') });
    Expect.that(updatePartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.updateRecords(new List<Account>{ new Account(Name = 'test') }, AccessLevel.SYSTEM_MODE);
    Expect.that(updateSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), AccessLevel.SYSTEM_MODE);

    DAL.updateRecords(new List<Account>{ new Account(Name = 'test') }, new Database.DMLOptions(), AccessLevel.SYSTEM_MODE);
    Expect.that(updateSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), Argument.ofType(Database.DMLOptions.class), AccessLevel.SYSTEM_MODE);

    DAL.updateRecordsPartially(new List<Account>{ new Account(Name = 'test') }, AccessLevel.SYSTEM_MODE);
    Expect.that(updatePartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), AccessLevel.SYSTEM_MODE);

    DAL.upsertRecords(new List<Account>{ new Account(Name = 'test') }, Account.Id);
    Expect.that(upsertSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), Argument.ofType(Schema.SObjectField.class));

    DAL.upsertRecordsPartially(new List<Account>{ new Account(Name = 'test') }, Account.Id);
    Expect.that(upsertPartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), Argument.ofType(Schema.SObjectField.class));

    DAL.upsertRecords(new List<Account>{ new Account(Name = 'test') }, Account.Id, AccessLevel.SYSTEM_MODE);
    Expect.that(upsertSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), Argument.ofType(Schema.SObjectField.class), AccessLevel.SYSTEM_MODE);

    DAL.upsertRecordsPartially(new List<Account>{ new Account(Name = 'test') }, Account.Id, AccessLevel.SYSTEM_MODE);
    Expect.that(upsertPartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), Argument.ofType(Schema.SObjectField.class), AccessLevel.SYSTEM_MODE);

    DAL.deleteRecords(new List<Account>{ new Account(Name = 'test') });
    Expect.that(deleteSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.deleteRecordsPartially(new List<Account>{ new Account(Name = 'test') });
    Expect.that(deletePartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.deleteRecords(new List<Account>{ new Account(Name = 'test') }, AccessLevel.SYSTEM_MODE);
    Expect.that(deleteSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), AccessLevel.SYSTEM_MODE);

    DAL.deleteRecordsPartially(new List<Account>{ new Account(Name = 'test') }, AccessLevel.SYSTEM_MODE);
    Expect.that(deletePartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), AccessLevel.SYSTEM_MODE);

    DAL.undeleteRecords(new List<Account>{ new Account(Name = 'test') });
    Expect.that(undeleteSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.undeleteRecordsPartially(new List<Account>{ new Account(Name = 'test') });
    Expect.that(undeletePartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.undeleteRecords(new List<Account>{ new Account(Name = 'test') }, AccessLevel.SYSTEM_MODE);
    Expect.that(undeleteSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), AccessLevel.SYSTEM_MODE);

    DAL.undeleteRecordsPartially(new List<Account>{ new Account(Name = 'test') }, AccessLevel.SYSTEM_MODE);
    Expect.that(undeletePartiallySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class), AccessLevel.SYSTEM_MODE);

    DAL.query([SELECT Id FROM Account]);
    Expect.that(querySpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));

    DAL.query('SELECT Id FROM Account', new Map<String, Object>());
    Expect.that(querySpy).hasBeenCalledWith(Argument.ofType(String.class), Argument.ofType(Map<String, Object>.class));

    DAL.query('SELECT Id FROM Account', new Map<String, Object>(), AccessLevel.SYSTEM_MODE);
    Expect.that(querySpy).hasBeenCalledWith(Argument.ofType(String.class), Argument.ofType(Map<String, Object>.class), AccessLevel.SYSTEM_MODE);

    DAL.queryAggregate([SELECT Count(Id) countId FROM Account]);
    Expect.that(queryAggregateSpy).hasBeenCalledWith(Argument.ofType(List<AggregateResult>.class));

    DAL.queryCount([SELECT COUNT() FROM Account]);
    Expect.that(queryCountSpy).hasBeenCalledWith(Argument.ofType(Integer.class));

    DAL.find([FIND 'Test' IN NAME FIELDS RETURNING Account(Id, Name)]);
    Expect.that(findSpy).hasBeenCalledWith(Argument.ofType(List<List<Account>>.class));

    DAL.find('FIND \'Test\' IN NAME FIELDS RETURNING Account (Id, Name)');
    Expect.that(findSpy).hasBeenCalledWith(Argument.ofType(String.class));

    DAL.find('FIND \'Test\' IN NAME FIELDS RETURNING Account (Id, Name)', AccessLevel.SYSTEM_MODE);
    Expect.that(findSpy).hasBeenCalledWith(Argument.ofType(String.class), AccessLevel.SYSTEM_MODE);
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
    List<Database.SaveResult> resultsWithMode = DAL.insertRecords(new List<Account>{ acc }, AccessLevel.SYSTEM_MODE);
    List<Database.SaveResult> resultsOptionsWithMode = DAL.insertRecords(new List<Account>{ acc }, new Database.DMLOptions(), AccessLevel.SYSTEM_MODE);
    List<Database.SaveResult> resultsPartiallyWithMode = DAL.insertRecordsPartially(new List<Account>{ acc }, AccessLevel.SYSTEM_MODE);

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual(1, resultsOptions.size());
    Assert.areEqual(1, resultsPartially.size());
    Assert.areEqual(1, resultsWithMode.size());
    Assert.areEqual(1, resultsOptionsWithMode.size());
    Assert.areEqual(1, resultsPartiallyWithMode.size());
  }

  @isTest
  static void givenDAL_whenUpdateRecordsIsCalled_thenItTriesToUpdateRecords() {
    // Arrange
    Account acc = new Account(Name = 'Test');

    // Act
    List<Database.SaveResult> results = DAL.updateRecords(new List<Account>{ acc });
    List<Database.SaveResult> resultsOptions = DAL.updateRecords(new List<Account>{ acc }, new Database.DMLOptions());
    List<Database.SaveResult> resultsPartially = DAL.updateRecordsPartially(new List<Account>{ acc });
    List<Database.SaveResult> resultsWithMode = DAL.updateRecords(new List<Account>{ acc }, AccessLevel.SYSTEM_MODE);
    List<Database.SaveResult> resultsOptionsWithMode = DAL.updateRecords(new List<Account>{ acc }, new Database.DMLOptions(), AccessLevel.SYSTEM_MODE);
    List<Database.SaveResult> resultsPartiallyWithMode = DAL.updateRecordsPartially(new List<Account>{ acc }, AccessLevel.SYSTEM_MODE);

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual(1, resultsOptions.size());
    Assert.areEqual(1, resultsPartially.size());
    Assert.areEqual(1, resultsWithMode.size());
    Assert.areEqual(1, resultsOptionsWithMode.size());
    Assert.areEqual(1, resultsPartiallyWithMode.size());
  }

  /*
  @isTest
  static void givenDAL_whenUpsertRecordsIsCalled_thenItTriesToUpsertRecords() {
    // Arrange
    Account acc = new Account(Name = 'Test');

    // Act
    List<Database.UpsertResult> results = DAL.upsertRecords(new List<Account>{ acc }, Account.Id);
    List<Database.UpsertResult> resultsPartially = DAL.upsertRecordsPartially(new List<Account>{ acc }, Account.Id);
    List<Database.UpsertResult> resultsWithMode = DAL.upsertRecords(new List<Account>{ acc }, Account.Id, AccessLevel.SYSTEM_MODE);
    List<Database.UpsertResult> resultsPartiallyWithMode = DAL.upsertRecordsPartially(new List<Account>{ acc }, Account.Id, AccessLevel.SYSTEM_MODE);

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual(1, resultsPartially.size());
    Assert.areEqual(1, resultsWithMode.size());
    Assert.areEqual(1, resultsPartiallyWithMode.size());
  }

  @isTest
  static void givenDAL_whenDeleteRecordsIsCalled_thenItTriesToDeleteRecords() {
    // Arrange
    Account acc = new Account(Name = 'Test', Email='test@test.com');
    Account accMode = new Account(Name = 'Test', Email='test@test.com');
    insert new List<Account>{ acc, accMode };

    // Act
    List<Database.DeleteResult> results = DAL.deleteRecords(new List<Account>{ acc });
    List<Database.DeleteResult> resultsPartially = DAL.deleteRecordsPartially(new List<Account>{ acc });
    List<Database.DeleteResult> resultsWithMode = DAL.deleteRecords(new List<Account>{ accMode }, AccessLevel.SYSTEM_MODE);
    List<Database.DeleteResult> resultsPartiallyWithMode = DAL.deleteRecordsPartially(new List<Account>{ accMode }, AccessLevel.SYSTEM_MODE);

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual(1, resultsPartially.size());
    Assert.areEqual(1, resultsWithMode.size());
    Assert.areEqual(1, resultsPartiallyWithMode.size());
  }

  @isTest
  static void givenDAL_whenUndeleteRecordsIsCalled_thenItTriesToUndeleteRecords() {
    // Arrange

    Account acc = new Account(Name = 'Test');
    Account accMode = new Account(Name = 'Test');
    insert new List<Account>{ acc, accMode };
    delete new List<Account>{ acc, accMode };

    // Act
    List<Database.UndeleteResult> results = DAL.undeleteRecords(new List<Account>{ acc });
    List<Database.UndeleteResult> resultsPartially = DAL.undeleteRecordsPartially(new List<Account>{ acc });
    List<Database.UndeleteResult> resultsWithMode = DAL.undeleteRecords(new List<Account>{ accMode }, AccessLevel.SYSTEM_MODE);
    List<Database.UndeleteResult> resultsPartiallyWithMode = DAL.undeleteRecordsPartially(new List<Account>{ accMode }, AccessLevel.SYSTEM_MODE);

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual(1, resultsPartially.size());
    Assert.areEqual(1, resultsWithMode.size());
    Assert.areEqual(1, resultsPartiallyWithMode.size());
  }
  */

  @isTest
  static void givenDAL_whenQueryIsCalled_thenItTriesToQueryRecords() {
    // Act
    List<SObject> resultsStatic = DAL.query([SELECT Id FROM Account]);
    List<SObject> resultsDynamic = DAL.query('SELECT Id FROM Account', new Map<String, Object>());
    List<SObject> resultsDynamicWithMode = DAL.query('SELECT Id FROM Account', new Map<String, Object>(), AccessLevel.SYSTEM_MODE);

    // Assert
    Assert.areEqual(0, resultsStatic.size());
    Assert.areEqual(0, resultsDynamic.size());
    Assert.areEqual(0, resultsDynamicWithMode.size());
  }

  @isTest
  static void givenDAL_whenQueryAggregateIsCalled_thenItTriesToQueryRecords() {
    // Act
    List<AggregateResultProxy> resultsAggregate = DAL.queryAggregate([SELECT Count(Id) countId FROM Account]);

    // Assert
    Assert.areEqual(1, resultsAggregate.size());
  }

  @isTest
  static void givenDAL_whenQueryCountIsCalled_thenItTriesToReturnsCount() {
    // Act
    Integer count = DAL.queryCount([SELECT COUNT() FROM Account]);

    // Assert
    Assert.areEqual(0, count);
  }

  @isTest
  static void givenDAL_whenFindIsCalled_thenItTriesToFindRecords() {
    // Act
    List<List<SObject>> resultsStatic = DAL.find([FIND 'Test' IN NAME FIELDS RETURNING Account(Id, Name)]);
    List<List<SObject>> resultsDynamic = DAL.find('FIND \'Test\' IN NAME FIELDS RETURNING Account (Id, Name)');
    List<List<SObject>> resultsDynamicWithMode = DAL.find('FIND \'Test\' IN NAME FIELDS RETURNING Account (Id, Name)', AccessLevel.SYSTEM_MODE);

    // Assert
    Assert.areEqual(0, resultsStatic[0].size());
    Assert.areEqual(0, resultsDynamic[0].size());
    Assert.areEqual(0, resultsDynamicWithMode[0].size());
  }
}
