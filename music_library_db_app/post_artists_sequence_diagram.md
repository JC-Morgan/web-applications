# POST/artists Sequence Diagram


(The HTTP Client
The HTTP Request and the data it contains
The HTTP Response and the data it contains
The Application class (app.rb)
The Repository class (artist_repository.rb)
The Database)

```mermaid
sequenceDiagram
    participant c as Client
    participant rack as Rackup
    participant app as Application class (app.rb)
    participant g_block as GET / (route block)

    Note left of c: Time <br />⬇ <br /> ⬇ <br /> ⬇

    c->>rack: HTTP Request

    rect rgb(191, 223, 255)
    Note left of rack: Sinatra Application
    rack->>app: Forwards request
    app->>g_block: Calls
    g_block->>app: Returns
    app->>rack: Sends response
    end

    rack->>c: HTTP Response

```

