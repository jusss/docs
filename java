1. use .equals() to match string, not ==
    String a = "a";
    if (a == "a") ... // don't use ==
    if (a.equals("a")) ... // proper way
    also 
        switch (a) {
            case "a": ... // proper way 
        }
    and
        public Map<String,String> map = new Map<String,String>(){{
            put("a","a");
        }};
        map.get("a");
