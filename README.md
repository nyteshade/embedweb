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
