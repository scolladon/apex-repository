public with sharing class AccountService {
  RepositoryService repository;

  public AccountService() {
    this(new RepositoryFactory().asUser());
  }

  @testVisible
  private AccountService(final RepositoryService repository) {
    this.repository = repository;
  }

  public Account createAccount() {
    final Account account = new Account(Name = 'Test');

    this.repository.insertRecords(new List<SObject>{ account }, new Database.DmlOptions());

    return account;
  }

  public void updateAccount(final Account account) {
    account.Name = account.Name + ' Updated';
    this.repository.updateRecords(new List<SObject>{ account }, new Database.DmlOptions());
  }

  public void deleteAccount(final Account account) {
    this.repository.deleteRecords(new List<SObject>{ account }, true);
  }

  public List<Account> getExistingAccount(final String name) {
    return (List<Account>) this.repository.query('SELECT Id FROM Account WHERE Name = :name', new Map<String, Object>{ 'name' => name });
  }
}
