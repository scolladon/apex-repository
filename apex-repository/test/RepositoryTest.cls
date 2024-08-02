@IsTest
private class RepositoryTest {
  @IsTest
  static void givenRepositoryWithSharingAsSystem_whenInsertRecords_thenSaveResults() {
    // Arrange
    Repository repo = new Repository();
    Repository.RepositoryService service = repo.withSharingAsSystem();

    Account acc1 = new Account(Name = 'Test Account 1');
    Account acc2 = new Account(Name = 'Test Account 2');
    List<SObject> records = new List<SObject>{ acc1, acc2 };
    Database.DmlOptions options = new Database.DmlOptions();

    // Act
    List<Database.SaveResult> results = service.insertRecords(records, options);

    // Assert
    System.assertEquals(2, results.size(), 'Expected two SaveResult records');
    for (Database.SaveResult result : results) {
      System.assert(result.isSuccess(), 'Expected save to be successful');
      System.assertNotEquals(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithoutSharingAsSystem_whenInsertRecords_thenSaveResults() {
    // Arrange
    Repository repo = new Repository();
    Repository.RepositoryService service = repo.withoutSharingAsSystem();

    Account acc1 = new Account(Name = 'Test Account 1');
    Account acc2 = new Account(Name = 'Test Account 2');
    List<SObject> records = new List<SObject>{ acc1, acc2 };
    Database.DmlOptions options = new Database.DmlOptions();

    // Act
    List<Database.SaveResult> results = service.insertRecords(records, options);

    // Assert
    System.assertEquals(2, results.size(), 'Expected two SaveResult records');
    for (Database.SaveResult result : results) {
      System.assert(result.isSuccess(), 'Expected save to be successful');
      System.assertNotEquals(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithSharingAsUser_whenInsertRecords_thenSaveResults() {
    // Arrange
    Repository repo = new Repository();
    Repository.RepositoryService service = repo.withSharingAsUser();

    Account acc1 = new Account(Name = 'Test Account 1');
    Account acc2 = new Account(Name = 'Test Account 2');
    List<SObject> records = new List<SObject>{ acc1, acc2 };
    Database.DmlOptions options = new Database.DmlOptions();

    // Act
    List<Database.SaveResult> results = service.insertRecords(records, options);

    // Assert
    System.assertEquals(2, results.size(), 'Expected two SaveResult records');
    for (Database.SaveResult result : results) {
      System.assert(result.isSuccess(), 'Expected save to be successful');
      System.assertNotEquals(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithoutSharingAsUser_whenInsertRecords_thenSaveResults() {
    // Arrange
    Repository repo = new Repository();
    Repository.RepositoryService service = repo.withoutSharingAsUser();

    Account acc1 = new Account(Name = 'Test Account 1');
    Account acc2 = new Account(Name = 'Test Account 2');
    List<SObject> records = new List<SObject>{ acc1, acc2 };
    Database.DmlOptions options = new Database.DmlOptions();

    // Act
    List<Database.SaveResult> results = service.insertRecords(records, options);

    // Assert
    System.assertEquals(2, results.size(), 'Expected two SaveResult records');
    for (Database.SaveResult result : results) {
      System.assert(result.isSuccess(), 'Expected save to be successful');
      System.assertNotEquals(null, result.getId(), 'Expected ID to be returned');
    }
  }

  @IsTest
  static void givenRepositoryWithSharingAsSystem_whenQuery_thenReturnResults() {
    // Arrange
    Repository repo = new Repository();
    Repository.RepositoryService service = repo.withSharingAsSystem();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    String soql = 'SELECT Id, Name FROM Account WHERE Name = :acc.Name';
    Map<String, Object> bindMap = new Map<String, Object>{ 'Name' => acc.Name };

    // Act
    List<SObject> results = service.query(soql, bindMap);

    // Assert
    System.assertEquals(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0];
    System.assertEquals(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }

  @IsTest
  static void givenRepositoryWithoutSharingAsSystem_whenQuery_thenReturnResults() {
    // Arrange
    Repository repo = new Repository();
    Repository.RepositoryService service = repo.withoutSharingAsSystem();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    String soql = 'SELECT Id, Name FROM Account WHERE Name = :acc.Name';
    Map<String, Object> bindMap = new Map<String, Object>{ 'Name' => acc.Name };

    // Act
    List<SObject> results = service.query(soql, bindMap);

    // Assert
    System.assertEquals(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0];
    System.assertEquals(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }

  @IsTest
  static void givenRepositoryWithSharingAsUser_whenQuery_thenReturnResults() {
    // Arrange
    Repository repo = new Repository();
    Repository.RepositoryService service = repo.withSharingAsUser();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    String soql = 'SELECT Id, Name FROM Account WHERE Name = :acc.Name';
    Map<String, Object> bindMap = new Map<String, Object>{ 'Name' => acc.Name };

    // Act
    List<SObject> results = service.query(soql, bindMap);

    // Assert
    System.assertEquals(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0];
    System.assertEquals(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }

  @IsTest
  static void givenRepositoryWithoutSharingAsUser_whenQuery_thenReturnResults() {
    // Arrange
    Repository repo = new Repository();
    Repository.RepositoryService service = repo.withoutSharingAsUser();

    Account acc = new Account(Name = 'Test Account');
    insert acc;

    String soql = 'SELECT Id, Name FROM Account WHERE Name = :acc.Name';
    Map<String, Object> bindMap = new Map<String, Object>{ 'Name' => acc.Name };

    // Act
    List<SObject> results = service.query(soql, bindMap);

    // Assert
    System.assertEquals(1, results.size(), 'Expected one record from the query');
    Account resultAcc = (Account) results[0];
    System.assertEquals(acc.Name, resultAcc.Name, 'Expected queried record to match');
  }
}
