# apex repository

## Description

`RepositoryFactory` is an **Apex** class designed to manage database operations with different sharing and security levels. It provides a flexible way to perform CRUD operations (Create, Read, Update, Delete) based on the security mode:

- **With Sharing in System Mode**: Executes operations respecting sharing rules but ignoring the user’s field and object permissions.
- **Without Sharing in System Mode**: Executes operations ignoring both sharing rules and user permissions.
- **With Sharing in User Mode**: Executes operations while enforcing the current user’s permissions, field-level security, and sharing rules.

This structure allows for flexibility in handling database operations depending on the specific access and sharing requirements.

## Features

- **Flexible Sharing Modes**: The library supports system and user sharing modes, allowing you to execute database operations based on the desired security context.
- **CRUD Operations**: Supports create, update, upsert, and delete operations on Salesforce objects.
- **SOQL and SOSL Queries**: Provides functionality to execute SOQL queries and SOSL searches within the specified access mode.
- **Customizable DML Options**: DML operations can be customized using `Database.DmlOptions`.
- **In memory DB implementation**: Provides capability to mock DB for Testing purpose

## Installation

1. Clone or download the repository.
2. Add the `RepositoryFactory` class to your own repo

## Usage

For additional examples and best practices on how to use the RepositoryFactory class, you can refer to the recipe files located in the folder: [`apex-repository/recipes/classes`](https://github.com/scolladon/apex-repository/tree/main/apex-repository/recipes/classes).

You can use another mock for your services instead of using the In Memory Mock provided (or use another lib to generate the mock for you and configure the stubs according to your needs).

These examples provide detailed demonstrations of how to implement various CRUD operations and queries using the different security modes provided by the RepositoryFactory.

## Class Structure

### RepositoryFactory

`asSystemWithSharing()`: Returns an instance of RepositoryService with system mode and sharing rules enabled.

`asSystemWithoutSharing()`: Returns an instance of RepositoryService without sharing rules.

`asUser()`: Returns an instance of RepositoryService enforcing the current user’s sharing and permissions.

### RepositoryService

Interface contract with the world.

### InMemoryRepositoryService

In Memory repository service implementation for testing purpose only.
