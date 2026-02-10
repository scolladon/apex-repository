@IsTest
public class DatabaseTestUtils {
  static Integer identifier = 1;
  public static String getFakeId(Schema.SObjectType sot) {
    String result = String.valueOf(identifier++);
    return sot.getDescribe().getKeyPrefix() + '0'.repeat(12 - result.length()) + result;
  }

  public static Object makeData(final Type sobjectType, final Map<String, Object> data) {
    Map<String, Object> dataResult = new Map<String, Object>();
    for (String fieldName : data.keySet()) {
      Object fieldValue = data.get(fieldName); // Lookup | Primitive
      if (fieldValue instanceof List<SObject>) {
        // ChildRelationShip
        final List<Map<String, Object>> children = new List<Map<String, Object>>();
        for (Object child : (List<Object>) fieldValue) {
          if (child instanceof Map<String, Object>) {
            children.add((Map<String, Object>) child);
          } else {
            children.add((Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(child)));
          }
        }
        fieldValue = new Map<String, Object>{ 'totalSize' => children.size(), 'done' => true, 'records' => children };
      }
      dataResult.put(fieldName, fieldValue);
    }

    return JSON.deserialize(JSON.serialize(dataResult), sobjectType);
  }
}
