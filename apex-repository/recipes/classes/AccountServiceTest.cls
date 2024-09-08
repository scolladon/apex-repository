@isTest
private class AccountServiceTest {
  @isTest
  static void createAccount_returnsAccount() {
    // Arrange
    final InMemoryRepositoryFactory repoFactory = new InMemoryRepositoryFactory();
    final AccountService sut = new AccountService(repoFactory);

    // Act
    final Account result = sut.createAccount();

    // Assert
    Assert.areEqual('Test', result.Name, 'Name should be "Test"');
    Assert.isTrue(result.Id != null, 'Record should have Id');
    Assert.areEqual(new List<SObject>{ new Account(Name = 'Test') }, repoFactory.insertCallParameters[0]);
  }

  @isTest
  static void updateAccount_updatesTheAccount() {
    // Arrange
    final InMemoryRepositoryFactory repoFactory = new InMemoryRepositoryFactory();
    final AccountService sut = new AccountService(repoFactory);
    final Account account = sut.createAccount();

    // Act
    sut.updateAccount(account);

    // Assert
    Assert.areEqual('Test Updated', account.Name, 'Name should be "Test Updated"');
    Assert.areEqual(new List<SObject>{ new Account(Name = 'Test Updated', Id = account.Id) }, repoFactory.updateCallParameters[0]);
  }

  @isTest
  static void deleteAccount_deletesTheAccount() {
    // Arrange
    final InMemoryRepositoryFactory repoFactory = new InMemoryRepositoryFactory();
    final AccountService sut = new AccountService(repoFactory);
    final Account account = sut.createAccount();

    // Act
    sut.deleteAccount(account);

    // Assert
    Assert.areEqual(new List<SObject>{ new Account(Name = 'Test', Id = account.Id) }, repoFactory.deleteCallParameters[0]);
  }

  @isTest
  static void getExistingAccount_returnsAccount() {
    // Arrange
    final InMemoryRepositoryFactory repoFactory = new InMemoryRepositoryFactory();
    final AccountService sut = new AccountService(repoFactory);
    final Account account = sut.createAccount();

    // Act
    final Account result = sut.getExistingAccount('Test')[0];

    // Assert
    Assert.areEqual('Test', result.Name, 'Name should be "Test"');
    Assert.isTrue(result.Id != null, 'Record should have Id');
    Assert.areEqual(new Map<String, Object>{ 'soql' => 'SELECT Id FROM Account WHERE Name = :name', 'bindMap' => new Map<String, Object>{ 'name' => 'Test' } }, repoFactory.queryCallParameters[0]);
  }
}
