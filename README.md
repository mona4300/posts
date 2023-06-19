
# Posts

It is a simple application to demonstrate the specs types. The types used here are acceptance, integration and unit. The application allows you to create a post and get the post using its generated ID.

### Requirements
 - Ruby 3.1.0.


### Setup
You need to run the following commands to test the application.
```
bundle install
bundle exec sequel -m db/migrations/ sqlite://db/development.db --echo
bundle exec rackup
```

### Endpoints:

- Create Post

    ```
    Method POST => /posts
    ```

    Request body sample (JSON)
    ```
    {
        "title": "Hello",
        "content": "Content"
    }
    ```


    Response sample
    ```
    { "id": 1 }
    ```


- Find Post
    ```
    Method GET => /posts/:post_id
    ```

    You can obtain the post_id from the create API response. The response here could be not found (404) or the post data if exists

    Response sample
    ```
    {"id":1,"title":"Hello","content":"Content"}
    ```


