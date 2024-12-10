@isTest
public class DatabaseTestUtils {
  static Integer identifier = 1;
  public static String getFakeId(Schema.SObjectType sot) {
    String result = String.valueOf(identifier++);
    return sot.getDescribe().getKeyPrefix() + '0'.repeat(12 - result.length()) + result;
  }

  public static Object makeData(final Type sobjectType, final Map<String, Object> data) {
    for (String fieldName : data.keySet()) {
      final Object fieldValue = data.get(fieldName);
      if (fieldValue instanceof List<SObject>) {
        List<Map<String, Object>> serializedChildren = new List<Map<String, Object>>();
        for (SObject child : (List<SObject>) fieldValue) {
          serializedChildren.add((Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(child)));
        }
        data.put(fieldName, new Map<String, Object>{ 'totalSize' => ((List<Object>) fieldValue).size(), 'done' => true, 'records' => serializedChildren });
      } else if (fieldValue instanceof List<Object>) {
        List<Map<String, Object>> serializedChildren = new List<Map<String, Object>>();
        for (Object child : (List<Object>) fieldValue) {
          serializedChildren.add((Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(child)));
        }
        data.put(fieldName, serializedChildren);
      } else if (fieldValue instanceof SObject) {
        data.put(fieldName, (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(fieldValue)));
      }
    }

    return JSON.deserialize(JSON.serialize(data), sobjectType);
  }
  /* Execute Anonymous
  // AggregateResult
AggregateResult aggResult = (AggregateResult) DAL.makeData(
  AggregateResult.class, 
  new Map<String, Object>{ 'field' => 'value' }
);
System.Debug(aggResult);
// Database.SaveResult
Database.SaveResult result =  (Database.SaveResult) DAL.makeData(Database.SaveResult.class, new Map<String, Object>{
  'success'=>true,
  'id' => 'value',
  'errors' => new List<Object>{
    new Map<String, Object> {
      'message' => 'error message',
      'statusCode' => 42
    }
  }
});
System.Debug(result);
Opportunity opp = (Opportunity) DAL.makeData(Opportunity.class, new Map<String, Object>{
    'Name'=>'Oppy', 
    'Account'=>new Account(Name='Test'),
    'IsClosed'=>true,
        'OpportunityTeamMembers'=>new List<OpportunityTeamMember>{
            new OpportunityTeamMember(TeamMemberRole='Leader')
        }
        });

Account acc = (Account) DAL.makeData(Account.class, new Map<String, Object>{
  'Name'=>'Account',
  'IsPersonAccount' => true,
  'Parent' => new Account(
    Name='Parent', 
    Parent=new Account(
      Name='GrandParent'
    )
  ),
  'Opportunities' => new List<Opportunity>{
    opp
  }
});
System.Debug(acc);
System.Debug(acc.Name);
System.Debug(acc.IsPersonAccount);
System.Debug(acc.Parent);
System.Debug(acc.Parent.Parent);
System.Debug(acc.Opportunities);
System.Debug(acc.Opportunities[0].Account);
System.Debug(acc.Opportunities[0].IsClosed);
System.Debug(acc.Opportunities[0].OpportunityTeamMembers);
System.Debug(acc.Opportunities[0].OpportunityTeamMembers[0].TeamMemberRole);
*/
}
