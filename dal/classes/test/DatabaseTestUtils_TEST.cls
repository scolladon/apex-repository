@isTest
private class DatabaseTestUtils_TEST {
  @isTest
  static void makeData_bigScenario() {
    // Act
    Contract contract = (Contract) DatabaseTestUtils.makeData(Contract.class, new Map<String, Object>{ 'ContractNumber' => 'TEST' });
    Contact contact = (Contact) DatabaseTestUtils.makeData(
      Contact.class,
      new Map<String, Object>{ 'Name' => 'Contact', 'Account' => new Account(Name = 'Test'), 'ContractsSigned' => new List<Contract>{ contract } }
    );
    Account acc = (Account) DatabaseTestUtils.makeData(
      Account.class,
      new Map<String, Object>{ 'Name' => 'Account', 'Parent' => new Account(Name = 'Parent', Parent = new Account(Name = 'GrandParent')), 'Contacts' => new List<Contact>{ contact } }
    );

    // Assert
    Assert.isNotNull(acc);
    Assert.areEqual('Account', acc.Name);
    Assert.areEqual('Parent', acc.Parent.Name);
    Assert.areEqual('GrandParent', acc.Parent.Parent.Name);
    Assert.areEqual(1, acc.Contacts.size());
    Assert.areEqual('Contact', acc.Contacts[0].Name);
    Assert.areEqual('Test', acc.Contacts[0].Account.Name);
    Assert.areEqual(1, acc.Contacts[0].ContractsSigned.size());
    Assert.areEqual('TEST', acc.Contacts[0].ContractsSigned[0].ContractNumber);
  }

  @isTest
  static void makeData_SObject() {
    // Arrange
    final Map<String, Object> values = new Map<String, Object>{ 'Name' => 'Account' };

    // Act
    Account acc = (Account) DatabaseTestUtils.makeData(Account.class, new Map<String, Object>{ 'Name' => 'Account', 'IsPersonAccount' => true });

    // Assert
    Assert.isNotNull(acc);
    Assert.areEqual('Account', acc.Name);
  }

  @isTest
  static void makeData_SObject_withReadOnlyField() {
    // Arrange
    final Map<String, Object> values = new Map<String, Object>{ 'IsClosed' => true };

    // Act
    Opportunity oppy = (Opportunity) DatabaseTestUtils.makeData(Opportunity.class, values);

    // Assert
    Assert.isNotNull(oppy);
    Assert.areEqual(true, oppy.IsClosed);
  }

  @isTest
  static void makeData_SObject_withParentRelationship() {
    // Arrange
    final Map<String, Object> values = new Map<String, Object>{ 'Name' => 'Account' };

    // Act
    Account acc = (Account) DatabaseTestUtils.makeData(Account.class, new Map<String, Object>{ 'Parent' => new Account(Name = 'Parent') });

    // Assert
    Assert.isNotNull(acc);
    Assert.areEqual('Parent', acc.Parent.Name);
  }

  @isTest
  static void makeData_SObject_withGrandParentRelationship() {
    // Arrange
    final Map<String, Object> values = new Map<String, Object>{ 'Name' => 'Account' };

    // Act
    Account acc = (Account) DatabaseTestUtils.makeData(Account.class, new Map<String, Object>{ 'Parent' => new Account(Name = 'Parent', Parent = new Account(Name = 'Grand Parent')) });

    // Assert
    Assert.isNotNull(acc);
    Assert.areEqual('Grand Parent', acc.Parent.Parent.Name);
  }

  @isTest
  static void makeData_SObject_withChildRelationship() {
    // Arrange
    final Map<String, Object> values = new Map<String, Object>{ 'Name' => 'Account' };

    // Act
    Account acc = (Account) DatabaseTestUtils.makeData(Account.class, new Map<String, Object>{ 'Opportunities' => new List<Opportunity>{ new Opportunity(Name = 'Oppy') } });

    // Assert
    Assert.isNotNull(acc);
    Assert.areEqual('Oppy', acc.Opportunities[0].Name);
  }

  @isTest
  static void makeData_AggregateResult() {
    // Arrange
    final Map<String, Object> values = new Map<String, Object>{ 'Name' => 'Test' };

    // Act
    AggregateResult aggResult = (AggregateResult) DatabaseTestUtils.makeData(AggregateResult.class, values);

    // Assert
    Assert.isNotNull(aggResult);
  }

  @isTest
  static void makeData_ReadOnlyObject() {
    // Arrange
    final Map<String, Object> values = new Map<String, Object>{
      'success' => true,
      'id' => 'value',
      'errors' => new List<Object>{ new Map<String, Object>{ 'message' => 'error message', 'statusCode' => StatusCode.REQUIRE_RUNAS_USER } }
    };

    // Act
    Database.SaveResult result = (Database.SaveResult) DatabaseTestUtils.makeData(Database.SaveResult.class, values);

    // Assert
    Assert.isNotNull(result);
    Assert.isTrue(result.isSuccess());
    Assert.areEqual('value', result.getId());
    Assert.areEqual('error message', result.getErrors()[0].getMessage());
    Assert.areEqual(StatusCode.REQUIRE_RUNAS_USER, result.errors[0].getStatusCode());
  }
}
