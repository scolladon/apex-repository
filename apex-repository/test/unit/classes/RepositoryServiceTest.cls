@IsTest
private class RepositoryServiceTest {
  @IsTest
  static void givenRepositoryWithSharingAsSystem_whenInsertRecords_thenSaveResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithSharing();

    Account acc1 = new Account(Name = 'Test Account 1');
    Account acc2 = new Account(Name = 'Test Account 2');
    List<SObject> records = new List<SObject>{ acc1, acc2 };
    Database.DmlOptions options = new Database.DmlOptions();

    // Act
    List<Database.SaveResult> results = sut.insertRecords(records, options);

    // Assert
    Assert.areEqual(2, results.size(), 'Expected two SaveResult records');
    for (Database.SaveResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithoutSharingAsSystem_whenInsertRecords_thenSaveResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithoutSharing();

    Account acc1 = new Account(Name = 'Test Account 1');
    Account acc2 = new Account(Name = 'Test Account 2');
    List<SObject> records = new List<SObject>{ acc1, acc2 };
    Database.DmlOptions options = new Database.DmlOptions();

    // Act
    List<Database.SaveResult> results = sut.insertRecords(records, options);

    // Assert
    Assert.areEqual(2, results.size(), 'Expected two SaveResult records');
    for (Database.SaveResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithSharingAsUser_whenInsertRecords_thenSaveResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asUser();

    Account acc1 = new Account(Name = 'Test Account 1');
    Account acc2 = new Account(Name = 'Test Account 2');
    List<SObject> records = new List<SObject>{ acc1, acc2 };
    Database.DmlOptions options = new Database.DmlOptions();

    // Act
    List<Database.SaveResult> results = sut.insertRecords(records, options);

    // Assert
    Assert.areEqual(2, results.size(), 'Expected two SaveResult records');
    for (Database.SaveResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithSharingAsSystem_whenUpdateRecords_thenSaveResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithSharing();

    Account acc1 = new Account(Name = 'Test Account 1');
    List<SObject> records = new List<SObject>{ acc1 };
    Database.DmlOptions options = new Database.DmlOptions();
    sut.insertRecords(records, options);
    acc1.Name = 'Another Name';

    // Act
    List<Database.SaveResult> results = sut.updateRecords(records, options);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one SaveResult records');
    for (Database.SaveResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithoutSharingAsSystem_whenUpdateRecords_thenSaveResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithoutSharing();

    Account acc1 = new Account(Name = 'Test Account 1');
    List<SObject> records = new List<SObject>{ acc1 };
    Database.DmlOptions options = new Database.DmlOptions();
    sut.insertRecords(records, options);
    acc1.Name = 'Another Name';

    // Act
    List<Database.SaveResult> results = sut.updateRecords(records, options);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one SaveResult records');
    for (Database.SaveResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithSharingAsUser_whenUpdateRecords_thenSaveResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asUser();

    Account acc1 = new Account(Name = 'Test Account 1');
    List<SObject> records = new List<SObject>{ acc1 };
    Database.DmlOptions options = new Database.DmlOptions();
    sut.insertRecords(records, options);
    acc1.Name = 'Another Name';

    // Act
    List<Database.SaveResult> results = sut.updateRecords(records, options);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one SaveResult records');
    for (Database.SaveResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithSharingAsSystem_whenUpsertRecords_thenUpsertResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithSharing();

    Account acc1 = new Account(Name = 'Test Account 1');
    List<SObject> records = new List<SObject>{ acc1 };
    Database.DmlOptions options = new Database.DmlOptions();
    sut.insertRecords(records, options);
    acc1.Name = 'Another Name';

    // Act
    List<Database.UpsertResult> results = sut.upsertRecords(records, Account.Id, false);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one UpsertResult records');
    for (Database.UpsertResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithoutSharingAsSystem_whenUpsertRecords_thenUpsertResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithoutSharing();

    Account acc1 = new Account(Name = 'Test Account 1');
    List<SObject> records = new List<SObject>{ acc1 };
    Database.DmlOptions options = new Database.DmlOptions();
    sut.insertRecords(records, options);
    acc1.Name = 'Another Name';

    // Act
    List<Database.UpsertResult> results = sut.upsertRecords(records, Account.Id, false);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one UpsertResult records');
    for (Database.UpsertResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithSharingAsUser_whenUpsertRecords_thenUpsertResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asUser();

    Account acc1 = new Account(Name = 'Test Account 1');
    List<SObject> records = new List<SObject>{ acc1 };
    Database.DmlOptions options = new Database.DmlOptions();
    sut.insertRecords(records, options);
    acc1.Name = 'Another Name';

    // Act
    List<Database.UpsertResult> results = sut.upsertRecords(records, Account.Id, false);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one UpsertResult records');
    for (Database.UpsertResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithSharingAsSystem_whenDeleteRecords_thenDeleteResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithSharing();

    Account acc1 = new Account(Name = 'Test Account 1');
    List<SObject> records = new List<SObject>{ acc1 };
    Database.DmlOptions options = new Database.DmlOptions();
    sut.insertRecords(records, options);

    // Act
    List<Database.DeleteResult> results = sut.deleteRecords(records, false);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one DeleteResult records');
    for (Database.DeleteResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithoutSharingAsSystem_whenDeleteRecords_thenDeleteResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithoutSharing();

    Account acc1 = new Account(Name = 'Test Account 1');
    List<SObject> records = new List<SObject>{ acc1 };
    Database.DmlOptions options = new Database.DmlOptions();
    sut.insertRecords(records, options);

    // Act
    List<Database.DeleteResult> results = sut.deleteRecords(records, false);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one DeleteResult records');
    for (Database.DeleteResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithSharingAsUser_whenDeleteRecords_thenDeleteResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asUser();

    Account acc1 = new Account(Name = 'Test Account 1');
    List<SObject> records = new List<SObject>{ acc1 };
    Database.DmlOptions options = new Database.DmlOptions();
    sut.insertRecords(records, options);

    // Act
    List<Database.DeleteResult> results = sut.deleteRecords(records, false);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one DeleteResult records');
    for (Database.DeleteResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithSharingAsSystem_whenUndeleteRecords_thenDeleteResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithSharing();

    Account acc1 = new Account(Name = 'Test Account 1');
    List<SObject> records = new List<SObject>{ acc1 };
    Database.DmlOptions options = new Database.DmlOptions();
    sut.insertRecords(records, options);
    sut.deleteRecords(records, false);

    // Act
    List<Database.UndeleteResult> results = sut.undeleteRecords(records, false);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one DeleteResult records');
    for (Database.UndeleteResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithoutSharingAsSystem_whenUndeleteRecords_thenDeleteResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithoutSharing();

    Account acc1 = new Account(Name = 'Test Account 1');
    List<SObject> records = new List<SObject>{ acc1 };
    Database.DmlOptions options = new Database.DmlOptions();
    sut.insertRecords(records, options);
    sut.deleteRecords(records, false);

    // Act
    List<Database.UndeleteResult> results = sut.undeleteRecords(records, false);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one DeleteResult records');
    for (Database.UndeleteResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithSharingAsUser_whenUndeleteRecords_thenDeleteResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asUser();

    Account acc1 = new Account(Name = 'Test Account 1');
    List<SObject> records = new List<SObject>{ acc1 };
    Database.DmlOptions options = new Database.DmlOptions();
    sut.insertRecords(records, options);
    sut.deleteRecords(records, false);

    // Act
    List<Database.UndeleteResult> results = sut.undeleteRecords(records, false);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one DeleteResult records');
    for (Database.UndeleteResult result : results) {
      Assert.isTrue(result.isSuccess(), 'Expected save to be successful');
      Assert.areNotEqual(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithSharingAsSystem_whenQueryString_thenReturnResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithSharing();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    String soql = 'SELECT Id, Name FROM Account WHERE Name = :acc.Name';
    Map<String, Object> bindMap = new Map<String, Object>{ 'Name' => acc.Name };

    // Act
    List<SObject> results = sut.query(soql, bindMap);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0];
    Assert.areEqual(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }

  @IsTest
  static void givenRepositoryWithoutSharingAsSystem_whenQueryString_thenReturnResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithoutSharing();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    String soql = 'SELECT Id, Name FROM Account WHERE Name = :acc.Name';
    Map<String, Object> bindMap = new Map<String, Object>{ 'Name' => acc.Name };

    // Act
    List<SObject> results = sut.query(soql, bindMap);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0];
    Assert.areEqual(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }

  @IsTest
  static void givenRepositoryWithSharingAsUser_whenQueryString_thenReturnResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asUser();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    String soql = 'SELECT Id, Name FROM Account WHERE Name = :acc.Name';
    Map<String, Object> bindMap = new Map<String, Object>{ 'Name' => acc.Name };

    // Act
    List<SObject> results = sut.query(soql, bindMap);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0];
    Assert.areEqual(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }

  @IsTest
  static void givenRepositoryWithSharingAsSystem_whenQuery_thenReturnResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithSharing();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    // Act
    List<SObject> results = sut.query([SELECT Id, Name FROM Account WHERE Name = :acc.Name]);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0];
    Assert.areEqual(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }

  @IsTest
  static void givenRepositoryWithoutSharingAsSystem_whenQuery_thenReturnResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithoutSharing();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    // Act
    List<SObject> results = sut.query([SELECT Id, Name FROM Account WHERE Name = :acc.Name]);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0];
    Assert.areEqual(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }

  @IsTest
  static void givenRepositoryWithSharingAsUser_whenQuery_thenReturnResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asUser();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    // Act
    List<SObject> results = sut.query([SELECT Id, Name FROM Account WHERE Name = :acc.Name]);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0];
    Assert.areEqual(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }

  @IsTest
  static void givenRepositoryWithSharingAsSystem_whenFindString_thenReturnResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithSharing();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    String sosl = 'FIND \'Test Account\' IN NAME FIELDS RETURNING Account (Id, Name)';
    Test.setFixedSearchResults(new List<Id>{ acc.Id });

    // Act
    List<List<SObject>> results = sut.find(sosl);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0][0];
    Assert.areEqual(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }

  @IsTest
  static void givenRepositoryWithoutSharingAsSystem_whenFindString_thenReturnResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithoutSharing();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    String sosl = 'FIND \'Test\' IN NAME FIELDS RETURNING Account(Id, Name)';
    Test.setFixedSearchResults(new List<Id>{ acc.Id });

    // Act
    List<List<SObject>> results = sut.find(sosl);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0][0];
    Assert.areEqual(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }

  @IsTest
  static void givenRepositoryWithSharingAsUser_whenFindString_thenReturnResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asUser();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    String sosl = 'FIND \'Test Account\' IN NAME FIELDS RETURNING Account (Id, Name)';
    Test.setFixedSearchResults(new List<Id>{ acc.Id });

    // Act
    List<List<SObject>> results = sut.find(sosl);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0][0];
    Assert.areEqual(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }

  @IsTest
  static void givenRepositoryWithSharingAsSystem_whenFind_thenReturnResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithSharing();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    Test.setFixedSearchResults(new List<Id>{ acc.Id });

    // Act
    List<List<SObject>> results = sut.find([FIND 'Test Account' IN NAME FIELDS RETURNING Account(Id, Name)]);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0][0];
    Assert.areEqual(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }

  @IsTest
  static void givenRepositoryWithoutSharingAsSystem_whenFind_thenReturnResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asSystemWithoutSharing();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    Test.setFixedSearchResults(new List<Id>{ acc.Id });

    // Act
    List<List<SObject>> results = sut.find([FIND 'Test Account' IN NAME FIELDS RETURNING Account(Id, Name)]);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0][0];
    Assert.areEqual(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }

  @IsTest
  static void givenRepositoryWithSharingAsUser_whenFind_thenReturnResults() {
    // Arrange
    RepositoryFactory repoFactory = new RepositoryFactory();
    RepositoryService sut = repoFactory.asUser();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    Test.setFixedSearchResults(new List<Id>{ acc.Id });

    // Act
    List<List<SObject>> results = sut.find([FIND 'Test Account' IN NAME FIELDS RETURNING Account(Id, Name)]);

    // Assert
    Assert.areEqual(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0][0];
    Assert.areEqual(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }
}
