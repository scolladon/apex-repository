# Salesforce Data Access Layer (DAL)

A robust Data Access Layer for Salesforce that simplifies database operations and makes your code more testable.

## Features

- Unified interface for all database operations (DML)
- Support for partial operations and access levels
- Easy mocking capabilities for unit tests
- Type-safe operations
- Encapsulates Database operations complexity

## Prerequisites

This library depends on [Apex-Mockery](https://github.com/link-to-apex-mockery). Make sure to install it first.

## Installation

1. Install Apex-Mockery
2. Deploy the following files to your org:
   - `IDAL.cls`
   - `DAL.cls`
   - `DatabaseTestUtils.cls` (optional - for testing utilities)

## Usage

### Production Code

````apex
// Insert records
Account newAccount = new Account(Name = 'Test Account');
List<Database.SaveResult> results = DAL.insertRecords(new List<Account>{ newAccount });

// Insert with partial success allowed
List<Database.SaveResult> partialResults = DAL.insertRecordsPartially(new List<Account>{ newAccount });

// Update records
Account existingAccount = [SELECT Id, Name FROM Account LIMIT 1];
existingAccount.Name = 'Updated Name';
DAL.updateRecords(new List<Account>{ existingAccount });

// Query records
List<Account> accounts = DAL.query([SELECT Id, Name FROM Account WHERE Name LIKE 'Test%']);

// Dynamic query with bind variables
Map<String, Object> bindVars = new Map<String, Object>{'name' => 'Test%'};
List<Account> accounts = DAL.query('SELECT Id, Name FROM Account WHERE Name LIKE :name', bindVars);

// SOSL search
List<List<SObject>> searchResults = DAL.find([FIND 'Test' IN ALL FIELDS RETURNING Account(Id, Name)]);

### Test Code
```apex
@isTest
static void testAccountCreation() {
    // Arrange
    DAL.Stub dalStub = DAL.mock();
    MethodSpy insertSpy = dalStub.spyOnInsert();

    Account testAccount = new Account(Name = 'Test');
    Database.SaveResult mockResult = (Database.SaveResult)DatabaseTestUtils.makeData(
        Database.SaveResult.class,
        new Map<String, Object>{
            'success' => true,
            'id' => DatabaseTestUtils.getFakeId(Account.SObjectType)
        }
    );
    insertSpy.returns(new List<Database.SaveResult>{ mockResult });

    // Act
    List<Database.SaveResult> results = DAL.insertRecords(new List<Account>{ testAccount });

    // Assert
    Assert.isTrue(results[0].isSuccess());
    Expect.that(insertSpy).hasBeenCalledWith(Argument.ofType(List<Account>.class));
}
````

## Advanced Feature

**System Mode Operations**
Execute operations with system privileges:

```apex
DAL.insertRecords(records, AccessLevel.SYSTEM_MODE);
DAL.updateRecords(records, AccessLevel.SYSTEM_MODE);
DAL.queryRecords(soql, bindMap, AccessLevel.SYSTEM_MODE);
```

**DML Options**
Customize DML operations with Database.DMLOptions:

```apex
Database.DMLOptions options = new Database.DMLOptions();
options.optAllOrNone = true;
options.allowFieldTruncation = true;

DAL.insertRecords(records, options);
```

**AggregateResultProxy**

```apex
List<AggregateResultProxy> aggregateResults = DAL.queryAggregate([SELECT Count(Id) countId FROM Account WHERE Name LIKE 'Test%']);
for(AggregateResultProxy aggregateResult : aggregateResults) {
    Integer countId = (Integer)aggregateResult.get('countId');
    // Do something with countId
}
```

## Best Practices

1. Always use DAL instead of direct Database operations
2. Handle operation results appropriately
3. Use partial operations when appropriate
4. Mock DAL in unit tests for better isolation
5. Use System Mode operations sparingly and only when necessary

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
