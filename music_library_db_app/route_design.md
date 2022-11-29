# POST/albums Route Design

# Request:
POST /albums

# With body parameters:
title=Voyage
release_year=2022
artist_id=2

# Expected response (200 OK)
(No content)



1. Design the Route Signature

Method: POST
Path: /albums
Body Parameters:
title=Voyage
release_year=2022
artist_id=2

# Create a new album
Request: POST /albums
  With body parameters: "title=Voyage, release_year=2022, artist_id=2"
Response: None (just adds the album to the database)


# Request:

POST /albums?title=Voyage&release_year=2022&artist_id=2

# Expected response:
""
