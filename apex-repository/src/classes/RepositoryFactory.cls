public inherited sharing virtual class RepositoryFactory {
  private static RepositoryService repositoryWithSharingAsSystem;
  private static RepositoryService repositoryWithoutSharingAsSystem;
  private static RepositoryService repositoryWithSharingAsUser;

  /**
   * By default, Apex code runs in system mode, which means that it runs with substantially elevated permissions over the user running the code.
   * In system mode, the object and field-level permissions of the current user are ignored, and the record sharing rules are controlled by the class sharing keywords.
   * In user mode, the current user's object permissions, field-level security, and sharing rules are enforced.
   */

  public virtual RepositoryService asSystemWithSharing() {
    if (repositoryWithSharingAsSystem == null) {
      repositoryWithSharingAsSystem = new RepositoryWithSharingAsSystem();
    }
    return repositoryWithSharingAsSystem;
  }

  public virtual RepositoryService asSystemWithoutSharing() {
    if (repositoryWithoutSharingAsSystem == null) {
      repositoryWithoutSharingAsSystem = new RepositoryWithoutSharingAsSystem();
    }
    return repositoryWithoutSharingAsSystem;
  }

  public virtual RepositoryService asUser() {
    if (repositoryWithSharingAsUser == null) {
      repositoryWithSharingAsUser = new RepositoryWithSharingAsUser();
    }
    return repositoryWithSharingAsUser;
  }

  private with sharing class RepositoryWithSharingAsSystem extends BaseRepository {
    public RepositoryWithSharingAsSystem() {
      super(AccessLevel.SYSTEM_MODE);
    }
  }

  private without sharing class RepositoryWithoutSharingAsSystem extends BaseRepository {
    public RepositoryWithoutSharingAsSystem() {
      super(AccessLevel.SYSTEM_MODE);
    }
  }

  private with sharing class RepositoryWithSharingAsUser extends BaseRepository {
    public RepositoryWithSharingAsUser() {
      super(AccessLevel.USER_MODE);
    }
  }

  private inherited sharing abstract class BaseRepository implements RepositoryService {
    private AccessLevel mode;

    public BaseRepository(final AccessLevel mode) {
      this.mode = mode;
    }

    public virtual List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options) {
      final List<Database.SaveResult> result = Database.insert(records, options, this.mode);
      return result;
    }
    public virtual List<Database.SaveResult> updateRecords(final List<SObject> records, final Database.DmlOptions options) {
      final List<Database.SaveResult> result = Database.update(records, options, this.mode);

      return result;
    }

    public virtual List<Database.UpsertResult> upsertRecords(final List<SObject> records, final Schema.SObjectField externalIDField, final Boolean allOrNone) {
      final List<Database.UpsertResult> result = Database.upsert(records, externalIDField, allOrNone == true, this.mode);

      return result;
    }

    public virtual List<Database.DeleteResult> deleteRecords(final List<SObject> records, final Boolean allOrNone) {
      final List<Database.DeleteResult> result = Database.delete(records, allOrNone == true, this.mode);

      return result;
    }

    public virtual List<SObject> query(final String soql, final Map<String, Object> bindMap) {
      return Database.queryWithBinds(soql, bindMap, this.mode);
    }

    public virtual List<SObject> query(final List<SObject> soql) {
      return soql;
    }

    public virtual List<List<SObject>> find(final String sosl) {
      return Search.query(sosl, this.mode);
    }

    public virtual List<List<SObject>> find(final List<List<SObject>> sosl) {
      return sosl;
    }
  }
}
