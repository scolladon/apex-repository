@isTest
private class AccountServiceTest {
  @isTest
  static void createAccount_returnsAccount() {
    // Arrange
    final InMemoryRepositoryService repository = new InMemoryRepositoryService();
    final AccountService sut = new AccountService(repository);

    // Act
    final Account result = sut.createAccount();

    // Assert
    Assert.areEqual('Test', result.Name, 'Name should be "Test"');
    Assert.isTrue(result.Id != null, 'Record should have Id');
    Assert.areEqual(new List<SObject>{ new Account(Name = 'Test') }, repository.insertCallParameters[0]);
  }

  @isTest
  static void updateAccount_updatesTheAccount() {
    // Arrange
    final InMemoryRepositoryService repository = new InMemoryRepositoryService();
    final AccountService sut = new AccountService(repository);
    final Account account = new Account(Name = 'Test', Id = InMemoryRepositoryService.getFakeId(Account.getSObjectType()));
    repository.mockDatabase.put(Account.getSObjectType(), new List<SObject>{ account });

    // Act
    sut.updateAccount(account);

    // Assert
    Assert.areEqual('Test Updated', account.Name, 'Name should be "Test Updated"');
    Assert.areEqual(new List<SObject>{ new Account(Name = 'Test Updated', Id = account.Id) }, repository.updateCallParameters[0]);
  }

  @isTest
  static void deleteAccount_deletesTheAccount() {
    // Arrange
    final InMemoryRepositoryService repository = new InMemoryRepositoryService();
    final AccountService sut = new AccountService(repository);
    final Account account = new Account(Name = 'Test', Id = InMemoryRepositoryService.getFakeId(Account.getSObjectType()));
    repository.mockDatabase.put(Account.getSObjectType(), new List<SObject>{ account });

    // Act
    sut.deleteAccount(account);

    // Assert
    Assert.areEqual(new List<SObject>{ new Account(Name = 'Test', Id = account.Id) }, repository.deleteCallParameters[0]);
  }

  @isTest
  static void getExistingAccount_returnsAccount() {
    // Arrange
    final InMemoryRepositoryService repository = new InMemoryRepositoryService();
    final AccountService sut = new AccountService(repository);
    repository.mockDatabase.put(Account.getSObjectType(), new List<SObject>{ new Account(Name = 'Test', Id = InMemoryRepositoryService.getFakeId(Account.getSObjectType())) });

    // Act
    final Account result = sut.getExistingAccount('Test')[0];

    // Assert
    Assert.areEqual('Test', result.Name, 'Name should be "Test"');
    Assert.isTrue(result.Id != null, 'Record should have Id');
    Assert.areEqual(new Map<String, Object>{ 'soql' => 'SELECT Id FROM Account WHERE Name = :name', 'bindMap' => new Map<String, Object>{ 'name' => 'Test' } }, repository.queryCallParameters[0]);
  }
}
