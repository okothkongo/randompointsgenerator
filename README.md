# RandomPointsGenerator

This application creates users with 0 points  when the server starts and then updates each user's points with random numbers which are between 0 and 100 after every  minute.

It allows users to make requests whose response is a json object containing users and timestamp.

## Setting up the project

### Prerequiste

To avoid any surprise or errors this project runs on these stacks but anything  above these should work fine:

- elixir v1.11.2
- phoenix v1.5.6
- postgresql v12.x

To install the above mentioned depedencies kindly follows the links and follow instructions depending on your system

**Kindly note you can use [asdf](https://github.com/asdf-vm/asdf)  version manage to avoid version collisions in elixir**

Once you are done with the installaton of depedency clone the project into your local machine like so:

via ssh `git@github.com:okothkongo/randompointsgenerator.git`  
or

via https `https://github.com/okothkongo/randompointsgenerator.git`

## How run this application

* Install dependencies with `mix deps.get`
* Create,migrate, and seed your database with `mix ecto.setup`
* Run a quick test to ensure everything is working with `mix test`.It should be all green.
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Response

The response is a json  object that contains a timestamp and an array of user's objects like so:

```json
{"timestamp":null,
 "users":[{"id":402,"points":70},
          {"id":405,"points":41}
         ]
}
```

1. ### timestamp

The timestamp is a string, the value of this timestamp is a datetime in this format `yyyy-mm-dd hh:mm:sec`

This time is UTC based.

On  initial request  the value of timestamp is `null` like so:

```json
{"timestamp":"2020-07-30 17:09:33"
 "users":[{"id":402,"points":70},
          {"id":405,"points":41}
         ]
}
```

On any other consecutive requests, the value of the timestamp of the latest request will be the value of
of time previous request request was made. For instance when you did  a request on 
`2020-07-30 17:09:33` and you did another request at `2021-10-30 20:00:00` .

The response will be like so:

```json
{"timestamp":"2020-07-30 17:09:33",
 "users":[{"id":402,"points":70},
          {"id":405,"points":41}
         ]
}
```

2. ### users

users is an array of objects with each contain user details, their id and points which are both numbers(integers).

This array can have only of  maximum of two object, meaning it contain 0, 1, or two user's objects.

The value of user's object is determined by two things:

i. random number used to update each user

ii. random number used to query the database

### i. random number used to update each user

After every minute points of each user in the database is updated to a  random number whose value ranges between 0 and 100,the points of each user may remain the same or change depending of value of the random number used.

This will greatly affect values on users object, on requests made on minute after the previous request.

### ii. random number used to query the database

It is used to filter users being display,user with point greater than this number are select and the pick the first two(order is determined by user points, users with highest points will be fetched)

On each request this number can remain same or change since it is random.
