public inherited sharing virtual class Repository {
  private static RepositoryService repositoryWithSharingAsSystem;
  private static RepositoryService repositoryWithoutSharingAsSystem;
  private static RepositoryService repositoryWithSharingAsUser;
  private static RepositoryService repositoryWithoutSharingAsUser;

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
    if (repositoryWithSharingAsSystem == null) {
      repositoryWithSharingAsSystem = new RepositoryWithSharingAsUser();
    }
    return repositoryWithSharingAsSystem;
  }

  public virtual RepositoryService withoutSharingAsUser() {
    if (repositoryWithoutSharingAsSystem == null) {
      repositoryWithoutSharingAsSystem = new RepositoryWithoutSharingAsUser();
    }
    return repositoryWithoutSharingAsSystem;
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

  // TODO Simulate Database.SaveResult by building it from JSON
  private without sharing class RepositoryWithoutSharingAsUser extends BaseRepository {
    public RepositoryWithoutSharingAsUser() {
      // USER_MODE also check for sharing
      // We need to check manually to avoid the sharing and check Object Permissions and FLS
      // And so emulate without sharing as user
      super(AccessLevel.SYSTEM_MODE);
    }

    private List<SObject> getRecords(final List<SObject> records, final AccessType accessType, final Database.DmlOptions options) {
      SObjectAccessDecision decision = Security.stripInaccessible(accessType, records);
      final List<SObject> recordsToInsert;
      if (decision.getModifiedIndexes().isEmpty()) {
        recordsToInsert = records;
      }
      if (options?.OptAllOrNone != true) {
        recordsToInsert = decision.getRecords();
      }

      // Else we insert nothing because partial success is not allowed

      return recordsToInsert;
    }

    public override List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options) {
      final List<SObject> sobjects = this.getRecords(records, AccessType.CREATABLE, options);
      return super.insertRecords(sobjects, options);
    }

    public override List<Database.SaveResult> updateRecords(final List<SObject> records, final Database.DmlOptions options) {
      final List<SObject> sobjects = this.getRecords(records, AccessType.UPDATABLE, options);
      return super.updateRecords(sobjects, options);
    }

    public override List<Database.UpsertResult> upsertRecords(final List<SObject> records, final Schema.SObjectField externalIDField, final Boolean allOrNone) {
      final List<SObject> sobjects = this.getRecords(records, AccessType.UPSERTABLE, null);
      return super.upsertRecords(sobjects, externalIDField, allOrNone);
    }

    public override List<Database.DeleteResult> deleteRecords(final List<SObject> records, final Boolean allOrNone) {
      final List<SObject> sobjects = records.getSObjectType().getDescribe().isDeletable() ? records : null;
      return super.deleteRecords(sobjects, allOrNone);
    }

    public override List<SObject> query(final String soql, final Map<String, Object> bindMap) {
      final List<SObject> sobjects = super.query(soql, bindMap);
      final SObjectAccessDecision decision = Security.stripInaccessible(AccessType.READABLE, sobjects);
      return decision.getRecords();
    }

    public override List<List<SObject>> find(final String sosl) {
      final List<List<SObject>> sobjects = super.find(sosl);
      final List<List<SObject>> stripedSObjects = new List<List<SObject>>();
      for (List<SObject> sObjectList : sobjects) {
        final SObjectAccessDecision decision = Security.stripInaccessible(AccessType.READABLE, sObjectList);
        stripedSObjects.add(decision.getRecords());
      }

      return stripedSObjects;
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
