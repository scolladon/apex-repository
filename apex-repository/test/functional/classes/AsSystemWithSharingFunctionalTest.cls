@isTest
private class AsSystemWithSharingFunctionalTest {
  @isTest
  static void insert_thenRecordIsInserted() {
    // Arrange
    final FunctionalDataFactory dataFactory = new FunctionalDataFactory();
    final RepositoryFactory repoFactory = new RepositoryFactory();
    final RepositoryService sut = repoFactory.asSystemWithSharing();
    System.runAs(dataFactory.getMinimalAccessUser()) {
      RepositoryTestSubject__c testSubject = dataFactory.buildTestSubject();
      // Act
      final List<Database.SaveResult> results = sut.insertRecords(new List<SObject>{ testSubject }, new Database.DmlOptions());

      // Assert
      for (Database.SaveResult result : results) {
        Assert.isTrue(result.isSuccess(), 'DML operation should succeed but: ' + result);
      }
    }
  }

  @isTest
  static void whenRecordIsAccessible_update_thenRecordIsUpdated() {
    // Arrange
    final FunctionalDataFactory dataFactory = new FunctionalDataFactory();
    final RepositoryFactory repoFactory = new RepositoryFactory();
    final RepositoryService sut = repoFactory.asSystemWithSharing();
    RepositoryTestSubject__c testSubject = dataFactory.buildTestSubject();

    System.runAs(dataFactory.getMinimalAccessUser()) {
      insert testSubject;
      testSubject.put('Name', 'Other Name');
      // Act
      final List<Database.SaveResult> results = sut.updateRecords(new List<SObject>{ testSubject }, new Database.DmlOptions());

      // Assert
      for (Database.SaveResult result : results) {
        Assert.isTrue(result.isSuccess(), 'DML operation should succeed but: ' + result);
      }
    }
  }

  @isTest
  static void whenRecordIsNotAccessible_update_thenRecordIsNotUpdated() {
    // Arrange
    final FunctionalDataFactory dataFactory = new FunctionalDataFactory();
    final RepositoryFactory repoFactory = new RepositoryFactory();
    final RepositoryService sut = repoFactory.asSystemWithSharing();
    RepositoryTestSubject__c testSubject = dataFactory.buildTestSubject();
    System.runAs(dataFactory.getAdminUser()) {
      insert testSubject;
    }
    testSubject.put('Name', 'Other Name');

    System.runAs(dataFactory.getMinimalAccessUser()) {
      // Act
      final List<Database.SaveResult> results = sut.updateRecords(new List<SObject>{ testSubject }, new Database.DmlOptions());

      // Assert
      for (Database.SaveResult result : results) {
        Assert.isFalse(result.isSuccess(), 'DML operation should succeed but: ' + result);
      }
    }
  }

  @isTest
  static void whenRecordIsAccessible_upsert_thenRecordIsUpserted() {
    // Arrange
    final FunctionalDataFactory dataFactory = new FunctionalDataFactory();
    final RepositoryFactory repoFactory = new RepositoryFactory();
    final RepositoryService sut = repoFactory.asSystemWithSharing();
    RepositoryTestSubject__c testSubject = dataFactory.buildTestSubject();

    System.runAs(dataFactory.getMinimalAccessUser()) {
      insert testSubject;
      testSubject.put('Name', 'Other Name');
      // Act
      final List<Database.UpsertResult> results = sut.upsertRecords(new List<SObject>{ testSubject }, RepositoryTestSubject__c.Id, false);

      // Assert
      for (Database.UpsertResult result : results) {
        Assert.isTrue(result.isSuccess(), 'DML operation should succeed but: ' + result);
      }
    }
  }

  @isTest
  static void whenRecordIsNotAccessible_upsert_thenRecordIsNotUpserted() {
    // Arrange
    final FunctionalDataFactory dataFactory = new FunctionalDataFactory();
    final RepositoryFactory repoFactory = new RepositoryFactory();
    final RepositoryService sut = repoFactory.asSystemWithSharing();
    RepositoryTestSubject__c testSubject = dataFactory.buildTestSubject();
    System.runAs(dataFactory.getAdminUser()) {
      insert testSubject;
    }
    testSubject.put('Name', 'Other Name');

    System.runAs(dataFactory.getMinimalAccessUser()) {
      // Act
      final List<Database.UpsertResult> results = sut.upsertRecords(new List<SObject>{ testSubject }, RepositoryTestSubject__c.Id, false);

      // Assert
      for (Database.UpsertResult result : results) {
        Assert.isFalse(result.isSuccess(), 'DML operation should succeed but: ' + result);
      }
    }
  }

  @isTest
  static void whenRecordIsAccessible_delete_thenRecordIsDeleted() {
    // Arrange
    final FunctionalDataFactory dataFactory = new FunctionalDataFactory();
    final RepositoryFactory repoFactory = new RepositoryFactory();
    final RepositoryService sut = repoFactory.asSystemWithSharing();
    RepositoryTestSubject__c testSubject = dataFactory.buildTestSubject();

    System.runAs(dataFactory.getMinimalAccessUser()) {
      insert testSubject;

      // Act
      final List<Database.DeleteResult> results = sut.deleteRecords(new List<SObject>{ testSubject }, false);

      // Assert
      for (Database.DeleteResult result : results) {
        Assert.isTrue(result.isSuccess(), 'DML operation should succeed but: ' + result);
      }
    }
  }

  @isTest
  static void whenRecordIsNotAccessible_delete_thenRecordIsNotDeleted() {
    // Arrange
    final FunctionalDataFactory dataFactory = new FunctionalDataFactory();
    final RepositoryFactory repoFactory = new RepositoryFactory();
    final RepositoryService sut = repoFactory.asSystemWithSharing();
    RepositoryTestSubject__c testSubject = dataFactory.buildTestSubject();
    System.runAs(dataFactory.getAdminUser()) {
      insert testSubject;
    }

    System.runAs(dataFactory.getMinimalAccessUser()) {
      // Act
      final List<Database.DeleteResult> results = sut.deleteRecords(new List<SObject>{ testSubject }, false);

      // Assert
      for (Database.DeleteResult result : results) {
        Assert.isFalse(result.isSuccess(), 'DML operation should succeed but: ' + result);
      }
    }
  }

  @isTest
  static void whenRecordIsAccessible_query_thenRecordIsReturned() {
    // Arrange
    final FunctionalDataFactory dataFactory = new FunctionalDataFactory();
    final RepositoryFactory repoFactory = new RepositoryFactory();
    final RepositoryService sut = repoFactory.asSystemWithSharing();
    RepositoryTestSubject__c testSubject = dataFactory.buildTestSubject();

    System.runAs(dataFactory.getMinimalAccessUser()) {
      insert testSubject;

      // Act
      final List<SObject> results = sut.query('SELECT Id FROM RepositoryTestSubject__c', new Map<String, Object>());

      // Assert
      Assert.areEqual(1, results.size(), 'Expected record not returned.');
      Assert.areEqual(testSubject.Id, results[0].Id, 'Expected record not returned.');
    }
  }

  @isTest
  static void whenRecordIsNotAccessible_query_thenRecordIsNotReturned() {
    // Arrange
    final FunctionalDataFactory dataFactory = new FunctionalDataFactory();
    final RepositoryFactory repoFactory = new RepositoryFactory();
    final RepositoryService sut = repoFactory.asSystemWithSharing();
    RepositoryTestSubject__c testSubject = dataFactory.buildTestSubject();
    System.runAs(dataFactory.getAdminUser()) {
      insert testSubject;
    }

    System.runAs(dataFactory.getMinimalAccessUser()) {
      // Act
      final List<SObject> results = sut.query('SELECT Id FROM RepositoryTestSubject__c', new Map<String, Object>());

      // Assert
      Assert.areEqual(0, results.size(), 'No record expected but: ' + results);
    }
  }

  @isTest
  static void whenRecordIsAccessible_find_thenRecordIsReturned() {
    // Arrange
    final FunctionalDataFactory dataFactory = new FunctionalDataFactory();
    final RepositoryFactory repoFactory = new RepositoryFactory();
    final RepositoryService sut = repoFactory.asSystemWithSharing();
    RepositoryTestSubject__c testSubject = dataFactory.buildTestSubject();

    System.runAs(dataFactory.getMinimalAccessUser()) {
      insert testSubject;
      Test.setFixedSearchResults(new List<Id>{ testSubject.Id });

      // Act
      final List<List<SObject>> results = sut.find('FIND \'Test*\' IN NAME FIELDS RETURNING RepositoryTestSubject__c(Id, Name WHERE Name = \'TestSubject\' LIMIT 1)');

      // Assert
      Assert.areEqual(1, results[0].size(), 'Expected record not returned.');
      Assert.areEqual(testSubject.Id, results[0][0].Id, 'Expected record not returned.');
    }
  }

  @isTest
  static void whenRecordIsNotAccessible_find_thenRecordIsNotReturned() {
    // Arrange
    final FunctionalDataFactory dataFactory = new FunctionalDataFactory();
    final RepositoryFactory repoFactory = new RepositoryFactory();
    final RepositoryService sut = repoFactory.asSystemWithSharing();
    RepositoryTestSubject__c testSubject = dataFactory.buildTestSubject();
    System.runAs(dataFactory.getAdminUser()) {
      insert testSubject;
    }

    System.runAs(dataFactory.getMinimalAccessUser()) {
      // Act
      final List<List<SObject>> results = sut.find('FIND \'Test*\' IN NAME FIELDS RETURNING RepositoryTestSubject__c(Id, Name WHERE Name = \'TestSubject\' LIMIT 1)');

      // Assert
      Assert.areEqual(0, results[0].size(), 'No record expected but: ' + results);
    }
  }
}
