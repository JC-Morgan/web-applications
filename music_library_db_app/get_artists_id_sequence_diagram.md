Create a sequence diagram explaining the behaviour of your program when a request is sent to GET /artists/:id. Make sure your diagram all includes the following:
The HTTP Client
The HTTP Request and the data it contains
The HTTP Response and the data it contains
The Application class (app.rb)
The Repository class (artist_repository.rb)
The View (ERB file)
The Database


```mermaid
sequenceDiagram
    participant c as Client
    participant rack as Rackup
    participant app as Application class (app.rb)
    participant p_block as POST / artists
    participant ar as artist_repository.rb
    participant db as Database (music_library(_test))

    Note left of c: Time <br />⬇ <br /> ⬇ <br /> ⬇

    c->>rack: HTTP Request (POST /artists?name=()&genre=())

    rect rgb(191, 223, 255)
    Note left of rack: Sinatra Application
    rack->>app: Forwards request
    app->>p_block: Calls method
    end
    p_block->>ar: Method calls
    ar->>db: SQL query
    Note right of db: (creates artist in database)
    db->>ar: Confirmation/ no error
    ar->>p_block: Returns artist
    rect rgb(191, 223, 255)
    p_block->>app: Returns ""
    app->>rack: Sends response
    end

    rack->>c: HTTP Response (body: "" status: 200)

```
