static class BinomialCoefficient{
  static Map<Integer, Integer[]> map = new HashMap<Integer, Integer[]>(4);
  static int get(int n, int k){
    if(!map.containsKey(n))
      createBinomials(n);
    return map.get(n)[k];
  }
  static void createBinomials(int n){
    Integer[] coefficients = new Integer[n+1];
    coefficients[0] = 1;
    coefficients[n] = 1;
    for(int k = 1; k<=n/2; k++){
      coefficients[k] = (coefficients[k - 1] * (n - k + 1)) / k;
      coefficients[n-k] = coefficients[k];
    }
    map.put(n,coefficients);
  }
}
