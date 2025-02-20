@IsTest
public class DatabaseTestUtils {
  static Integer identifier = 1;
  public static String getFakeId(Schema.SObjectType sot) {
    String result = String.valueOf(identifier++);
    return sot.getDescribe().getKeyPrefix() + '0'.repeat(12 - result.length()) + result;
  }

  public static Object makeData(final Type sobjectType, final Map<String, Object> data) {
    for (String fieldName : data.keySet()) {
      Object fieldValue = data.get(fieldName);
      if (fieldValue instanceof List<SObject>) {
        List<Object> children = objectToList(fieldValue);
        fieldValue = new Map<String, Object>{ 'totalSize' => children.size(), 'done' => true, 'records' => children };
      } else if (fieldValue instanceof List<Object>) {
        fieldValue = objectToList(fieldValue);
      } else if (fieldValue instanceof SObject) {
        fieldValue = objectToMap(fieldValue);
      }
      data.put(fieldName, fieldValue);
    }

    return mapToObject(sobjectType, data);
  }

  private static List<Map<String, Object>> objectToList(final Object fieldValue) {
    final List<Map<String, Object>> children = new List<Map<String, Object>>();
    for (Object child : (List<Object>) fieldValue) {
      children.add(objectToMap(child));
    }
    return children;
  }

  private static Map<String, Object> objectToMap(final Object obj) {
    return (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(obj));
  }

  private static Object mapToObject(final Type sobjectType, final Map<String, Object> objectMap) {
    return JSON.deserialize(JSON.serialize(objectMap), sobjectType);
  }
}
