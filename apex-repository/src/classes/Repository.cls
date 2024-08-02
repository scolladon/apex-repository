public inherited sharing virtual class Repository {
  private static RepositoryService repositoryWithSharingAsSystem;
  private static RepositoryService repositoryWithoutSharingAsSystem;
  private static RepositoryService repositoryWithSharingAsUser;

  /**
   * By default, Apex code runs in system mode, which means that it runs with substantially elevated permissions over the user running the code.
   * In system mode, the object and field-level permissions of the current user are ignored, and the record sharing rules are controlled by the class sharing keywords.
   * In user mode, the current user's object permissions, field-level security, and sharing rules are enforced.
   */

  public virtual RepositoryService withSharingAsSystem() {
    if (repositoryWithSharingAsSystem == null) {
      repositoryWithSharingAsSystem = new RepositoryWithSharingAsSystem();
    }
    return repositoryWithSharingAsSystem;
  }

  public virtual RepositoryService withoutSharingAsSystem() {
    if (repositoryWithoutSharingAsSystem == null) {
      repositoryWithoutSharingAsSystem = new RepositoryWithoutSharingAsSystem();
    }
    return repositoryWithoutSharingAsSystem;
  }

  public virtual RepositoryService withSharingAsUser() {
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

  public interface RepositoryService {
    List<Database.SaveResult> insertRecords(List<SObject> records, Database.DmlOptions options);
    List<Database.SaveResult> updateRecords(List<SObject> records, Database.DmlOptions options);
    List<Database.UpsertResult> upsertRecords(List<SObject> records, Schema.SObjectField externalIDField, Boolean allOrNone);
    List<Database.DeleteResult> deleteRecords(List<SObject> records, Boolean allOrNone);
    List<SObject> query(String soql, Map<String, Object> bindMap);
    List<List<SObject>> find(String sosl);
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

    public virtual List<List<SObject>> find(final String sosl) {
      return Search.query(sosl, this.mode);
    }
  }
}
