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

    // WARNING: These dynamic SOSL strings use escaped single quotes ('\''). If executed against the
    // real org (not mocked), DAL.find() would call String.escapeSingleQuotes() on top of them,
    // producing double-escaped backslashes and failing with: "no viable alternative at character '\'".
    // They only pass here because the DAL is stubbed and the SOSL is never actually executed.
    // If unmocked, the correct syntax would be: 'FIND {Test} IN NAME FIELDS RETURNING Account (Id, Name)'
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

  // FIX: This test was failing for two reasons:
  // 1) The original code reused the same Account instance across all insert calls. After the first
  //    successful insert, Salesforce assigns an Id to the record in-memory. Subsequent inserts of
  //    the same instance then fail with: 'cannot specify Id in an insert call'.
  // 2) Before the allOrNone bugfix, the non-partial insert methods were silently swallowing
  //    this error because Database.DmlOptions().OptAllOrNone defaults to null (false), so
  //    they behaved as partial inserts — returning a failed SaveResult instead of throwing.
  //    The test only asserted results.size() == 1, which passed regardless of success/failure.
  // Solution: use a separate Account instance for each insert call.
  @isTest
  static void givenDAL_whenInsertRecordsIsCalled_thenItTriesToInsertRecords() {
    // Arrange - each call needs its own Account; after the first insert, the record gets an Id
    // and a second insert would fail with 'cannot specify Id in an insert call'
    Account acc1 = new Account(Name = 'Test1');
    Account acc2 = new Account(Name = 'Test2');
    Account acc3 = new Account(Name = 'Test3');
    Account acc4 = new Account(Name = 'Test4');
    Account acc5 = new Account(Name = 'Test5');
    Account acc6 = new Account(Name = 'Test6');

    // Act
    List<Database.SaveResult> results = DAL.insertRecords(new List<Account>{ acc1 });
    List<Database.SaveResult> resultsOptions = DAL.insertRecords(new List<Account>{ acc2 }, new Database.DMLOptions());
    List<Database.SaveResult> resultsPartially = DAL.insertRecordsPartially(new List<Account>{ acc3 });
    List<Database.SaveResult> resultsWithMode = DAL.insertRecords(new List<Account>{ acc4 }, AccessLevel.SYSTEM_MODE);
    List<Database.SaveResult> resultsOptionsWithMode = DAL.insertRecords(new List<Account>{ acc5 }, new Database.DMLOptions(), AccessLevel.SYSTEM_MODE);
    List<Database.SaveResult> resultsPartiallyWithMode = DAL.insertRecordsPartially(new List<Account>{ acc6 }, AccessLevel.SYSTEM_MODE);

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual(1, resultsOptions.size());
    Assert.areEqual(1, resultsPartially.size());
    Assert.areEqual(1, resultsWithMode.size());
    Assert.areEqual(1, resultsOptionsWithMode.size());
    Assert.areEqual(1, resultsPartiallyWithMode.size());
  }

  // FIX: This test was failing because the original code created an Account without inserting it,
  // so it had no Id. Calling Database.update on a record without an Id throws:
  // 'MISSING_ARGUMENT, Id not specified in an update call'. Before the allOrNone bugfix, this
  // error was silently swallowed (same partial-insert issue as above), and the test passed
  // because it only checked results.size() == 1.
  // Solution: insert the Account first so it gets a valid Id before updating.
  @isTest
  static void givenDAL_whenUpdateRecordsIsCalled_thenItTriesToUpdateRecords() {
    // Arrange - insert first so the record has a valid Id for update
    Account acc = new Account(Name = 'Test');
    insert acc;

    acc.Name = 'Updated';

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

  // FIX: This test was failing because the original dynamic SOSL strings used escaped single quotes:
  //   'FIND \'Test\' IN NAME FIELDS RETURNING Account (Id, Name)'
  // The DAL.find() implementation calls String.escapeSingleQuotes() on the input, which added
  // extra backslashes to the already-escaped quotes, producing invalid SOSL:
  //   FIND \\'Test\\' ... → "no viable alternative at character '\'"
  // Solution: use SOSL curly-brace syntax {Test} instead of single-quoted 'Test' for dynamic strings.
  // The inline SOSL (first call) was already fine since it's compiled, not string-escaped.
  @isTest
  static void givenDAL_whenFindIsCalled_thenItTriesToFindRecords() {
    // Act
    List<List<SObject>> resultsStatic = DAL.find([FIND 'Test' IN NAME FIELDS RETURNING Account(Id, Name)]);
    List<List<SObject>> resultsDynamic = DAL.find('FIND {Test} IN NAME FIELDS RETURNING Account (Id, Name)');
    List<List<SObject>> resultsDynamicWithMode = DAL.find('FIND {Test} IN NAME FIELDS RETURNING Account (Id, Name)', AccessLevel.SYSTEM_MODE);

    // Assert
    Assert.areEqual(0, resultsStatic[0].size());
    Assert.areEqual(0, resultsDynamic[0].size());
    Assert.areEqual(0, resultsDynamicWithMode[0].size());
  }

  // Regression tests: non-partial DML must throw on failure (allOrNone = true)

  @isTest
  static void givenNonPartialInsert_whenRecordIsInvalid_thenThrowsDmlException() {
    // Arrange - Account without required Name field on an org where Name is required
    // Using a record that will definitely fail: inserting a Contact without LastName
    Contact invalidContact = new Contact(); // LastName is required

    // Act & Assert
    try {
      DAL.insertRecords(new List<Contact>{ invalidContact });
      Assert.fail('Expected DmlException for non-partial insert of invalid record');
    } catch (DmlException e) {
      Assert.isTrue(e.getMessage().contains('REQUIRED_FIELD_MISSING') || e.getMessage().contains('LastName'));
    }
  }

  @isTest
  static void givenPartialInsert_whenRecordIsInvalid_thenDoesNotThrow() {
    // Arrange
    Contact invalidContact = new Contact(); // LastName is required

    // Act - partial insert should NOT throw
    List<Database.SaveResult> results = DAL.insertRecordsPartially(new List<Contact>{ invalidContact });

    // Assert
    Assert.areEqual(1, results.size());
    Assert.isFalse(results[0].isSuccess(), 'Partial insert should return failure result, not throw');
  }

  @isTest
  static void givenNonPartialUpdate_whenRecordIsInvalid_thenThrowsDmlException() {
    // Arrange - Update a record with a fake Id that doesn't exist
    Account acc = new Account(Name = 'Test');
    acc.Id = DatabaseTestUtils.getFakeId(Account.SObjectType);

    // Act & Assert
    try {
      DAL.updateRecords(new List<Account>{ acc });
      Assert.fail('Expected DmlException for non-partial update of non-existent record');
    } catch (DmlException e) {
      Assert.isNotNull(e.getMessage());
    }
  }

  @isTest
  static void givenPartialUpdate_whenRecordIsInvalid_thenDoesNotThrow() {
    // Arrange
    Account acc = new Account(Name = 'Test');
    acc.Id = DatabaseTestUtils.getFakeId(Account.SObjectType);

    // Act - partial update should NOT throw
    List<Database.SaveResult> results = DAL.updateRecordsPartially(new List<Account>{ acc });

    // Assert
    Assert.areEqual(1, results.size());
    Assert.isFalse(results[0].isSuccess(), 'Partial update should return failure result, not throw');
  }

  // mockId-based DML mocking tests

  @isTest
  static void givenMockId_whenInsertRecordsIsCalled_thenMockAssignsFakeIds() {
    // Arrange
    DAL.mock('insertAccounts');
    DAL.mock('insertContacts');
    Account acc = new Account(Name = 'Test Account');
    Contact con = new Contact(LastName = 'Test Contact');

    // Act
    DAL.insertRecords(new List<Account>{ acc }, 'insertAccounts');
    DAL.insertRecords(new List<Contact>{ con }, 'insertContacts');

    // Assert
    Assert.isNotNull(acc.Id, 'Account should have a fake Id assigned');
    Assert.isNotNull(con.Id, 'Contact should have a fake Id assigned');
    Assert.isTrue(acc.Id != con.Id, 'Each record should get a unique fake Id');
  }

  @isTest
  static void givenMockId_whenMultipleInsertsUseDifferentMockIds_thenEachIsMockedIndependently() {
    // Arrange
    DAL.mock('insertFirst');
    DAL.mock('insertSecond').throwException('Second insert failed');
    Account acc = new Account(Name = 'First');
    Account acc2 = new Account(Name = 'Second');

    // Act
    DAL.insertRecords(new List<Account>{ acc }, 'insertFirst');

    // Assert - first insert succeeds
    Assert.isNotNull(acc.Id);

    // Act & Assert - second insert throws
    try {
      DAL.insertRecords(new List<Account>{ acc2 }, 'insertSecond');
      Assert.fail('Expected DmlException');
    } catch (DmlException e) {
      Assert.isTrue(e.getMessage().contains('Second insert failed'));
    }
  }

  @isTest
  static void givenMockId_whenNoMockRegistered_thenDelegatesToInstance() {
    // Arrange
    Account acc = new Account(Name = 'Test');

    // Act - no mock registered for 'unmockedInsert', should hit real DB
    List<Database.SaveResult> results = DAL.insertRecords(new List<Account>{ acc }, 'unmockedInsert');

    // Assert
    Assert.areEqual(1, results.size());
    Assert.isTrue(results[0].isSuccess());
  }

  @isTest
  static void givenMockId_whenUpdateRecordsIsCalled_thenMockExecutes() {
    // Arrange
    DAL.mock('updateAccounts');
    Account acc = new Account(Name = 'Test');
    acc.Id = DatabaseTestUtils.getFakeId(Account.SObjectType);

    // Act - should not throw, mock intercepts
    DAL.updateRecords(new List<Account>{ acc }, 'updateAccounts');

    // Assert - no exception means mock worked (real update of fake Id would fail)
    Assert.isNotNull(acc.Id);
  }

  @isTest
  static void givenMockId_whenDeleteRecordsIsCalled_thenMockExecutes() {
    // Arrange
    DAL.mock('deleteAccounts');
    Account acc = new Account(Name = 'Test');
    acc.Id = DatabaseTestUtils.getFakeId(Account.SObjectType);

    // Act - should not throw, mock intercepts
    DAL.deleteRecords(new List<Account>{ acc }, 'deleteAccounts');

    // Assert - no exception means mock worked
    Assert.isNotNull(acc.Id);
  }

  @isTest
  static void givenMockId_whenUndeleteRecordsIsCalled_thenMockExecutes() {
    // Arrange
    DAL.mock('undeleteAccounts');
    Account acc = new Account(Name = 'Test');
    acc.Id = DatabaseTestUtils.getFakeId(Account.SObjectType);

    // Act - should not throw, mock intercepts
    DAL.undeleteRecords(new List<Account>{ acc }, 'undeleteAccounts');

    // Assert - no exception means mock worked
    Assert.isNotNull(acc.Id);
  }

  @isTest
  static void givenMockId_whenThrowExceptionWithDefaultMessage_thenThrowsDmlException() {
    // Arrange
    DAL.mock('failingInsert').throwException();

    // Act & Assert
    try {
      DAL.insertRecords(new List<Account>{ new Account(Name = 'Test') }, 'failingInsert');
      Assert.fail('Expected DmlException');
    } catch (DmlException e) {
      Assert.isTrue(e.getMessage().contains('DML mock exception'));
    }
  }

  @isTest
  static void givenMockId_whenUpsertRecordsIsCalled_thenMockAssignsFakeIds() {
    // Arrange
    DAL.mock('upsertAccounts');
    Account acc = new Account(Name = 'Test');

    // Act
    DAL.upsertRecords(new List<Account>{ acc }, 'upsertAccounts');

    // Assert
    Assert.isNotNull(acc.Id, 'Upsert mock should assign fake Id');
  }

  @isTest
  static void givenMockId_whenInsertWithAccessLevel_thenMockIntercepts() {
    // Arrange
    DAL.mock('insertWithAccess');
    Account acc = new Account(Name = 'Test');

    // Act
    DAL.insertRecords(new List<Account>{ acc }, AccessLevel.SYSTEM_MODE, 'insertWithAccess');

    // Assert
    Assert.isNotNull(acc.Id);
  }

  // mockId-based Query/Find mocking tests

  @isTest
  static void givenMockQuery_whenQueryIsCalled_thenReturnsMockedRecords() {
    // Arrange
    List<Account> mockedAccounts = new List<Account>{ new Account(Name = 'Mocked Account') };
    DAL.mockQuery('queryAccounts').thenReturn(mockedAccounts);

    // Act
    List<SObject> results = DAL.query('SELECT Id, Name FROM Account', new Map<String, Object>(), 'queryAccounts');

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual('Mocked Account', ((Account) results[0]).Name);
  }

  @isTest
  static void givenMockQuery_whenQueryWithAccessLevelIsCalled_thenReturnsMockedRecords() {
    // Arrange
    List<Account> mockedAccounts = new List<Account>{ new Account(Name = 'Mocked') };
    DAL.mockQuery('queryAccessLevel').thenReturn(mockedAccounts);

    // Act
    List<SObject> results = DAL.query('SELECT Id FROM Account', new Map<String, Object>(), AccessLevel.SYSTEM_MODE, 'queryAccessLevel');

    // Assert
    Assert.areEqual(1, results.size());
  }

  @isTest
  static void givenMockQuery_whenInlineQueryIsCalled_thenReturnsMockedRecords() {
    // Arrange
    List<Account> mockedAccounts = new List<Account>{ new Account(Name = 'Inline Mock') };
    DAL.mockQuery('inlineQuery').thenReturn(mockedAccounts);

    // Act
    List<SObject> results = DAL.query([SELECT Id FROM Account], 'inlineQuery');

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual('Inline Mock', ((Account) results[0]).Name);
  }

  @isTest
  static void givenMockQuery_whenQueryCountIsCalled_thenReturnsMockedCount() {
    // Arrange
    DAL.mockQuery('countAccounts').thenReturn(42);

    // Act
    Integer count = DAL.queryCount([SELECT COUNT() FROM Account], 'countAccounts');

    // Assert
    Assert.areEqual(42, count);
  }

  // FIX: This test was failing because the original code built the AggregateResultProxy via:
  //   new AggregateResultProxy((AggregateResult) DatabaseTestUtils.makeData(AggregateResult.class, ...))
  // DatabaseTestUtils.makeData uses JSON.serialize/deserialize to create the AggregateResult.
  // However, AggregateResult.getPopulatedFieldsAsMap() (used by the public constructor) does not
  // return fields populated through deserialization — it returns an empty map, so proxy.get('countId')
  // returned null instead of 5.
  // Solution: use the @TestVisible private constructor that accepts a Map<String, Object> directly.
  @isTest
  static void givenMockQuery_whenQueryAggregateIsCalled_thenReturnsMockedAggregateProxies() {
    // Arrange
    AggregateResultProxy proxy = new AggregateResultProxy(new Map<String, Object>{ 'countId' => 5 });
    DAL.mockQuery('aggregateQuery').thenReturnAggregateProxy(new List<AggregateResultProxy>{ proxy });

    // Act
    List<AggregateResultProxy> results = DAL.queryAggregate([SELECT Count(Id) countId FROM Account], 'aggregateQuery');

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual(5, results[0].get('countId'));
  }

  // NOTE: The dynamic SOSL string below uses escaped single quotes ('\''). This only works
  // because the mockId intercepts the call before DAL.find() reaches String.escapeSingleQuotes().
  // If no mock were registered, it would fail with: "no viable alternative at character '\'".
  // The correct unmocked syntax would be: 'FIND {Test} IN NAME FIELDS RETURNING Account'
  @isTest
  static void givenMockQuery_whenFindIsCalled_thenReturnsMockedSearchResults() {
    // Arrange
    List<List<SObject>> mockedResults = new List<List<SObject>>{ new List<Account>{ new Account(Name = 'Found') } };
    DAL.mockQuery('findAccounts').thenReturnSearch(mockedResults);

    // Act
    List<List<SObject>> results = DAL.find('FIND \'Test\' IN NAME FIELDS RETURNING Account', 'findAccounts');

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual(1, results[0].size());
    Assert.areEqual('Found', ((Account) results[0][0]).Name);
  }

  // NOTE: Same single-quote issue as above — only works because the mockId intercepts the call.
  // See givenMockQuery_whenFindIsCalled_thenReturnsMockedSearchResults for details.
  @isTest
  static void givenMockQuery_whenFindWithAccessLevelIsCalled_thenReturnsMockedSearchResults() {
    // Arrange
    List<List<SObject>> mockedResults = new List<List<SObject>>{ new List<Account>{ new Account(Name = 'Found') } };
    DAL.mockQuery('findAccessLevel').thenReturnSearch(mockedResults);

    // Act
    List<List<SObject>> results = DAL.find('FIND \'Test\' IN NAME FIELDS RETURNING Account', AccessLevel.SYSTEM_MODE, 'findAccessLevel');

    // Assert
    Assert.areEqual(1, results.size());
  }

  @isTest
  static void givenMockQuery_whenInlineFindIsCalled_thenReturnsMockedSearchResults() {
    // Arrange
    List<List<SObject>> mockedResults = new List<List<SObject>>{ new List<Account>{ new Account(Name = 'InlineFind') } };
    DAL.mockQuery('inlineFind').thenReturnSearch(mockedResults);

    // Act
    List<List<SObject>> results = DAL.find([FIND 'Test' IN NAME FIELDS RETURNING Account(Id, Name)], 'inlineFind');

    // Assert
    Assert.areEqual(1, results.size());
    Assert.areEqual('InlineFind', ((Account) results[0][0]).Name);
  }

  @isTest
  static void givenMockQuery_whenThrowExceptionConfigured_thenThrowsQueryException() {
    // Arrange
    DAL.mockQuery('failingQuery').throwException('Custom query error');

    // Act & Assert
    try {
      DAL.query('SELECT Id FROM Account', new Map<String, Object>(), 'failingQuery');
      Assert.fail('Expected QueryException');
    } catch (QueryException e) {
      Assert.isTrue(e.getMessage().contains('Custom query error'));
    }
  }

  @isTest
  static void givenMockQuery_whenNoMockRegistered_thenDelegatesToInstance() {
    // Act - no mock registered, should execute normally
    List<SObject> results = DAL.query('SELECT Id FROM Account', new Map<String, Object>(), 'unmockedQuery');

    // Assert
    Assert.areEqual(0, results.size());
  }

  @isTest
  static void givenMultipleMockQueries_whenCalledIndependently_thenEachReturnsDifferentResults() {
    // Arrange
    DAL.mockQuery('queryFirst').thenReturn(new List<Account>{ new Account(Name = 'First') });
    DAL.mockQuery('querySecond').thenReturn(new List<Account>{ new Account(Name = 'Second'), new Account(Name = 'Third') });

    // Act
    List<SObject> firstResults = DAL.query('SELECT Id FROM Account', new Map<String, Object>(), 'queryFirst');
    List<SObject> secondResults = DAL.query('SELECT Id FROM Account', new Map<String, Object>(), 'querySecond');

    // Assert
    Assert.areEqual(1, firstResults.size());
    Assert.areEqual('First', ((Account) firstResults[0]).Name);
    Assert.areEqual(2, secondResults.size());
    Assert.areEqual('Second', ((Account) secondResults[0]).Name);
  }
}
