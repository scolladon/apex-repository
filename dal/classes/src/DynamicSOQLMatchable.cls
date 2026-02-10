public class DynamicSOQLMatchable implements Argument.Matchable {
  private static final String FROM_REGEX_TEMPLATE = '(?i)FROM\\s+{0}\\b';
  private String fromType;
  private Pattern regex;

  // new DynamicSOQLMatchable(Account.class)
  public DynamicSOQLMatchable(final Type callTypeArgumentToMatch) {
    this(callTypeArgumentToMatch.getName());
  }

  // new DynamicSOQLMatchable(Account.sObjectType)
  public DynamicSOQLMatchable(final Schema.SObjectType callSObjectTypeArgumentToMatch) {
    this(callSObjectTypeArgumentToMatch.getDescribe());
  }

  // new DynamicSOQLMatchable(Schema.SObjectType.Account)
  public DynamicSOQLMatchable(final Schema.DescribeSObjectResult callArgumentDescribeSObjectResultToMatch) {
    this(callArgumentDescribeSObjectResultToMatch.getName());
  }

  // new DynamicSOQLMatchable('Account')
  public DynamicSOQLMatchable(final String callArgumentStringToMatch) {
    this.fromType = callArgumentStringToMatch?.trim();
    this.regex = Pattern.compile(String.format(FROM_REGEX_TEMPLATE, new List<Object>{ this.fromType }));
  }

  public boolean matches(final Object callArgument) {
    if (callArgument == null || !(callArgument instanceof String)) {
      return false;
    }
    final String dynamicSoql = (String) callArgument;
    return this.regex.matcher(dynamicSoql).find();
  }

  override public String toString() {
    return this.fromType + '.DynamicSOQL';
  }

  public Boolean equals(final Object obj) {
    if (obj == null || !(obj instanceof DynamicSOQLMatchable)) {
      return false;
    }
    final DynamicSOQLMatchable other = (DynamicSOQLMatchable) obj;
    // Native case insensitive equals for string
    return this.fromType == other.fromType;
  }
}
