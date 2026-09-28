@IsTest
private class DatabaseTestUtils_TEST {
  private static final Integer FAKE_ID_LENGTH = 15;
  private static final Integer CHILDREN_VOLUME = 1000;
  private static final Integer COMPOSITION_DEPTH = 10;

  @IsTest
  static void givenSObjectType_whenGetFakeId_thenReturnsValidIdOfThatType() {
    // Act
    String fakeId = DatabaseTestUtils.getFakeId(Account.SObjectType);

    // Assert
    Assert.areEqual(FAKE_ID_LENGTH, fakeId.length());
    Assert.areEqual(Account.SObjectType.getDescribe().getKeyPrefix() + '000000000001', fakeId);
    Assert.areEqual(Account.SObjectType, Id.valueOf(fakeId).getSObjectType());
  }

  @IsTest
  static void givenSeveralCalls_whenGetFakeId_thenIdsAreUniqueAndIncreasing() {
    // Act
    String first = DatabaseTestUtils.getFakeId(Account.SObjectType);
    String second = DatabaseTestUtils.getFakeId(Account.SObjectType);
    String otherType = DatabaseTestUtils.getFakeId(Contact.SObjectType);

    // Assert
    Assert.isTrue(second.compareTo(first) > 0);
    Assert.areEqual(3, new Set<String>{ first, second, otherType }.size());
    Assert.areEqual(Contact.SObjectType, Id.valueOf(otherType).getSObjectType());
  }

  @IsTest
  static void givenSObjectTypeWithoutKeyPrefix_whenGetFakeId_thenThrowsIllegalArgument() {
    // Act & Assert
    try {
      DatabaseTestUtils.getFakeId(AggregateResult.SObjectType);
      Assert.fail('an aggregate has no key prefix, no Id can be forged for it');
    } catch (IllegalArgumentException e) {
      Assert.isTrue(e.getMessage().contains('AggregateResult'));
    }
  }

  @IsTest
  static void givenTypedValues_whenMakeData_thenEachFieldKeepsItsType() {
    // Arrange
    final Date closeDate = Date.newInstance(2026, 1, 31);
    final Map<String, Object> values = new Map<String, Object>{ 'Name' => 'Oppy', 'CloseDate' => closeDate, 'Amount' => 1234.56, 'IsPrivate' => true };

    // Act
    Opportunity opportunity = (Opportunity) DatabaseTestUtils.makeData(Opportunity.class, values);

    // Assert
    Assert.areEqual('Oppy', opportunity.Name);
    Assert.areEqual(closeDate, opportunity.CloseDate);
    Assert.areEqual(1234.56, opportunity.Amount);
    Assert.isTrue(opportunity.IsPrivate);
  }

  @IsTest
  static void givenDatetimeValue_whenMakeData_thenInstantIsPreserved() {
    // Arrange
    final Datetime startsAt = Datetime.newInstance(2026, 1, 31, 10, 30, 0);

    // Act
    Event event = (Event) DatabaseTestUtils.makeData(Event.class, new Map<String, Object>{ 'ActivityDateTime' => startsAt });

    // Assert
    Assert.areEqual(startsAt, event.ActivityDateTime);
  }

  @IsTest
  static void givenReadOnlyField_whenMakeData_thenFieldIsSet() {
    // Act
    Opportunity opportunity = (Opportunity) DatabaseTestUtils.makeData(Opportunity.class, new Map<String, Object>{ 'IsClosed' => true });

    // Assert
    Assert.isTrue(opportunity.IsClosed);
  }

  @IsTest
  static void givenUnknownField_whenMakeData_thenFieldIsIgnored() {
    // Act
    Account account = makeAccount(new Map<String, Object>{ 'Name' => 'Account', 'NoSuchField__c' => 'ignored' });

    // Assert
    Assert.areEqual('Account', account.Name);
    Assert.isFalse(account.getPopulatedFieldsAsMap().containsKey('NoSuchField__c'));
  }

  @IsTest
  static void givenNullValue_whenMakeData_thenFieldIsNull() {
    // Act
    Account account = makeAccount(new Map<String, Object>{ 'Name' => null, 'Industry' => 'Tech' });

    // Assert
    Assert.isNull(account.Name);
    Assert.areEqual('Tech', account.Industry);
  }

  @IsTest
  static void givenNoValue_whenMakeData_thenReturnsEmptyRecord() {
    // Act
    Account account = makeAccount(new Map<String, Object>());

    // Assert
    Assert.isNotNull(account);
    Assert.isTrue(account.getPopulatedFieldsAsMap().isEmpty());
  }

  @IsTest
  static void givenValueOfWrongType_whenMakeData_thenThrowsJSONException() {
    // Arrange
    final Map<String, Object> values = new Map<String, Object>{ 'AnnualRevenue' => 'not a number' };

    // Act & Assert
    try {
      makeAccount(values);
      Assert.fail('a String cannot become a currency');
    } catch (JSONException e) {
      Assert.isTrue(e.getMessage().contains('not a number'));
    }
  }

  @IsTest
  static void givenFakeId_whenMakeData_thenIdIsSet() {
    // Arrange
    final Id fakeId = DatabaseTestUtils.getFakeId(Account.SObjectType);

    // Act
    Account account = makeAccount(new Map<String, Object>{ 'Id' => fakeId, 'Name' => 'Account' });

    // Assert
    Assert.areEqual(fakeId, account.Id);
  }

  @IsTest
  static void givenParentRelationships_whenMakeData_thenParentChainIsSet() {
    // Arrange
    final Account parent = new Account(Name = 'Parent', Parent = new Account(Name = 'GrandParent'));

    // Act
    Account account = makeAccount(new Map<String, Object>{ 'Name' => 'Account', 'Parent' => parent });

    // Assert
    Assert.areEqual('Parent', account.Parent.Name);
    Assert.areEqual('GrandParent', account.Parent.Parent.Name);
  }

  @IsTest
  static void givenChildRelationship_whenMakeData_thenAllChildrenAreSetInOrder() {
    // Arrange
    final List<Opportunity> opportunities = new List<Opportunity>{ new Opportunity(Name = 'First'), new Opportunity(Name = 'Second'), new Opportunity(Name = 'Third') };

    // Act
    Account account = makeAccount(new Map<String, Object>{ 'Opportunities' => opportunities });

    // Assert
    Assert.areEqual(3, account.Opportunities.size());
    Assert.areEqual('First', account.Opportunities[0].Name);
    Assert.areEqual('Third', account.Opportunities[2].Name);
  }

  @IsTest
  static void givenSeveralChildRelationships_whenMakeData_thenEachOneIsSet() {
    // Arrange
    final Map<String, Object> values = new Map<String, Object>{
      'Contacts' => new List<Contact>{ new Contact(LastName = 'Doe') },
      'Opportunities' => new List<Opportunity>{ new Opportunity(Name = 'Oppy') }
    };

    // Act
    Account account = makeAccount(values);

    // Assert
    Assert.areEqual('Doe', account.Contacts[0].LastName);
    Assert.areEqual('Oppy', account.Opportunities[0].Name);
  }

  @IsTest
  static void givenChildrenWithTheirOwnChildrenAndParents_whenMakeData_thenWholeGraphIsReachable() {
    // Arrange
    Contract contract = (Contract) DatabaseTestUtils.makeData(Contract.class, new Map<String, Object>{ 'ContractNumber' => 'C-1', 'Account' => new Account(Name = 'Signer') });
    Contact contact = (Contact) DatabaseTestUtils.makeData(
      Contact.class,
      new Map<String, Object>{ 'Name' => 'Contact', 'Account' => new Account(Name = 'Employer'), 'ContractsSigned' => new List<Contract>{ contract } }
    );

    // Act
    Account account = makeAccount(new Map<String, Object>{ 'Name' => 'Account', 'Contacts' => new List<Contact>{ contact } });

    // Assert
    Assert.areEqual('Contact', account.Contacts[0].Name);
    Assert.areEqual('Employer', account.Contacts[0].Account.Name);
    Assert.areEqual('C-1', account.Contacts[0].ContractsSigned[0].ContractNumber);
    Assert.areEqual('Signer', account.Contacts[0].ContractsSigned[0].Account.Name);
  }

  @IsTest
  static void givenDeepComposition_whenMakeData_thenEveryLevelIsReachable() {
    // Arrange
    Account subtree = makeAccount(new Map<String, Object>{ 'Name' => 'Level' + COMPOSITION_DEPTH });
    for (Integer level = COMPOSITION_DEPTH - 1; level > 1; --level) {
      subtree = makeAccount(new Map<String, Object>{ 'Name' => 'Level' + level, 'ChildAccounts' => new List<Account>{ subtree } });
    }

    // Act
    Account root = makeAccount(new Map<String, Object>{ 'Name' => 'Level1', 'ChildAccounts' => new List<Account>{ subtree } });

    // Assert
    Account node = root;
    for (Integer level = 1; level < COMPOSITION_DEPTH; ++level) {
      node = node.ChildAccounts[0];
    }
    Assert.areEqual('Level' + COMPOSITION_DEPTH, node.Name);
  }

  @IsTest
  static void givenManyChildren_whenMakeData_thenAllOfThemAreSet() {
    // Arrange
    final List<Opportunity> opportunities = new List<Opportunity>();
    for (Integer i = 0; i < CHILDREN_VOLUME; ++i) {
      opportunities.add(new Opportunity(Name = 'Opportunity ' + i));
    }

    // Act
    Test.startTest();
    Account account = makeAccount(new Map<String, Object>{ 'Opportunities' => opportunities });
    Test.stopTest();

    // Assert
    Assert.areEqual(CHILDREN_VOLUME, account.Opportunities.size());
    Assert.areEqual('Opportunity ' + (CHILDREN_VOLUME - 1), account.Opportunities[CHILDREN_VOLUME - 1].Name);
  }

  @IsTest
  static void givenFailedSaveResultValues_whenMakeData_thenErrorsAreReadable() {
    // Arrange
    final Map<String, Object> values = new Map<String, Object>{
      'success' => false,
      'errors' => new List<Object>{ new Map<String, Object>{ 'message' => 'error message', 'statusCode' => StatusCode.REQUIRE_RUNAS_USER } }
    };

    // Act
    Database.SaveResult result = (Database.SaveResult) DatabaseTestUtils.makeData(Database.SaveResult.class, values);

    // Assert
    Assert.isFalse(result.isSuccess());
    Assert.areEqual('error message', result.getErrors()[0].getMessage());
    Assert.areEqual(StatusCode.REQUIRE_RUNAS_USER, result.getErrors()[0].getStatusCode());
  }

  @IsTest
  static void givenSuccessInsertedBeforeErrors_whenMakeData_thenSuccessIsKept() {
    // Arrange
    final Id recordId = DatabaseTestUtils.getFakeId(Account.SObjectType);
    // Database result deserializers let a later "errors" override "success": fields are emitted in reverse insertion order so this natural ordering stays a success
    final Map<String, Object> values = new Map<String, Object>{
      'success' => true,
      'id' => recordId,
      'errors' => new List<Object>{ new Map<String, Object>{ 'message' => 'warning', 'statusCode' => StatusCode.REQUIRE_RUNAS_USER } }
    };

    // Act
    Database.SaveResult result = (Database.SaveResult) DatabaseTestUtils.makeData(Database.SaveResult.class, values);

    // Assert
    Assert.isTrue(result.isSuccess());
    Assert.areEqual(recordId, result.getId());
    Assert.areEqual('warning', result.getErrors()[0].getMessage());
  }

  @IsTest
  static void givenOtherDatabaseResultTypes_whenMakeData_thenTheyAreReadable() {
    // Arrange
    final Id recordId = DatabaseTestUtils.getFakeId(Account.SObjectType);
    final Map<String, Object> succeeded = new Map<String, Object>{ 'success' => true, 'id' => recordId, 'errors' => new List<Object>() };
    final Map<String, Object> created = new Map<String, Object>{ 'success' => true, 'created' => true, 'id' => recordId, 'errors' => new List<Object>() };

    // Act
    Database.UpsertResult upserted = (Database.UpsertResult) DatabaseTestUtils.makeData(Database.UpsertResult.class, created);
    Database.DeleteResult deleted = (Database.DeleteResult) DatabaseTestUtils.makeData(Database.DeleteResult.class, succeeded);
    Database.UndeleteResult undeleted = (Database.UndeleteResult) DatabaseTestUtils.makeData(Database.UndeleteResult.class, succeeded);

    // Assert
    Assert.isTrue(upserted.isSuccess());
    Assert.isTrue(upserted.isCreated());
    Assert.areEqual(recordId, upserted.getId());
    Assert.isTrue(deleted.isSuccess());
    Assert.areEqual(recordId, deleted.getId());
    Assert.isTrue(undeleted.isSuccess());
    Assert.areEqual(recordId, undeleted.getId());
  }

  private static Account makeAccount(final Map<String, Object> values) {
    return (Account) DatabaseTestUtils.makeData(Account.class, values);
  }
}
