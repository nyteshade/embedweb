embedweb
========

EmbedWeb is a convenience class that wraps the HttpServer Sun, now Oracle,   
bundles with JDK6+. This provides an incredibly easy way to implement a      
HTTP listener in any Java based application, be it a desktop app or an app   
server like Tomcat.                                                          
                                                                             
Combined with a JSON encoder/decoder it can be a powerful solution to        
providing an API for your application. Creating an HttpServer on port 7070   
that listens to the root (/) path is as simple as:                           
                                                                             
```java                                                                  
  EmbedWeb.WEB.addHandler(7070, "/", new HttpHandler() {                     
    public void handle(HttpExchange httpExchange) throws IOException {       
      Map<String, Object> params = EmbedWeb.getParameters(httpExchange);  
      StringBuilder buffer = new StringBuilder();                            
                                                                             
      if (params.containsKey("name")) {                                      
        buffer.append("Hello " + params.get("name") + "");                   
      } else {                                                               
        buffer.append("Whats up punk?!");                                    
      }                                                                      
                                                                             
      EmbedWeb.respondWith(httpExchange, 200, buffer, "text/html");          
    }                                                                        
  });                                                                        
                                                                             
  EmbedWeb.WEB.startServer(7070);                                            
```                                                                
                                                                             
The parameters returned from ```EmbedWeb.getParameters(httpExchange)``` are
using a filter by Leonardo Marcelino. His blog and the appropriate post can
be found here:
http://leonardom.wordpress.com/2009/08/06/getting-parameters-from-httpexchange

An example of how to use org.json.simple's JSON library to output JSON with the
embedded app. Again note that this is a very contrived example, but it shows the
potential of making an easy API in an app.

```java
import com.nyteshade.EmbedWeb;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import org.json.simple.JSONObject;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

public class Main {

  public static void main(String[] args) throws NoSuchAlgorithmException {
    EmbedWeb.WEB.addHandler(7070, "/person", new HttpHandler() {
      @Override
      public void handle(HttpExchange httpExchange) throws IOException {
        Map<String, Object> params = EmbedWeb.getParameters(httpExchange);
        Map<String, Object> output = new HashMap<String, Object>();

        output.put("version", 1.0);
        output.put("params", params);
        output.put("message", "Whats up punk?!");

        if (params.containsKey("name")) {
          output.put("name", params.get("name"));
          output.put("message", "Hello " + params.get("name"));
        }

        JSONObject jobj = new JSONObject(output);
        StringBuilder buffer = new StringBuilder(jobj.toJSONString());

        EmbedWeb.respondWith(httpExchange, 200, buffer, "text/javascript");
      }
    });

    EmbedWeb.WEB.startServer(7070);
  }
}
```

The output is of a request to /person?name=Brie

```
{"message":"Hello Brie","name":"Brie","params":{"name":"Brie"},"version":1.0}
```

