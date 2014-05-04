# Logistique

A simple logistic routing system using Ruby, Rails, PostgreSQL, Postgis and PGRouting.

## Getting ready

### Database

You need to install PostgreSQL and other two extensions: Postgis and PGRouting.

The easiest way is using Homebrew on Mac OS:

```bash
brew update
brew install postgresql postgis pgrouting
```

But if you're using other OS I highly recommend you to read those guides:

- http://www.postgresql.org/download/
- http://postgis.net/install
- http://docs.pgrouting.org/2.0/en/doc/src/installation/index.html

#### Why PostgreSQL ?

IMHO, PostgreSQL has the best community around spatial data and routing systems,
with the most complete tools available.

It's reliable and free.

### Ruby / Rails

Installing Ruby is really simple with RVM or Rbenv:

- http://rvm.io/rvm/install
- https://github.com/sstephenson/rbenv#installation

After installing all the main dependencies clone the project:

```bash
git clone git@github.com:guivinicius/logistique.git
```

and run bundler

```bash
cd logistique
bundle install
```

Install **Foreman** gem: https://github.com/ddollar/foreman

```bash
gem install foreman
```

Change the `database.yml` file to your own configurations and run the following commands:

```bash
foreman start

rake db:setup
```

#### Why using Rails besides of Sinatra or even rails-api ?

Since the app is pretty much a simple API, makes sense to use Sinatra or Rails-api,
but I'm planning to build a interface as well.

## Using the API

### Creating a Map

- **URL:** /maps
- **VERB:** POST
- **PARAMETERS:**
 - map[name]
 - map[network]

#### map[network] format:

To send the network follow the format below, each line is a route composed by **source**, **target** and **length** in Kilometers:

```ruby
A B 10
B D 15
A C 20
C D 30
B E 50
D E 30
```
The first line is a route from the point **A** to point **B** with a distance of **10** kilometers.

#### Using cURL:

- Encoding your own data with **%20** for spaces and **%0A** for line Breaks:

```bash
curl -X POST \
     -d 'map[name]=Default' \
     -d 'map[network]=A%20B%2010%0AB%20D%2015%0AA%20C%2020%0AC%20D%2030%0AB%20E%2050%0AD%20E%2030' \
     http://localhost:3000/maps
```

- Using a external json file

```bash
curl -X POST \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -d @data.json \
     http://localhost:3000/maps
```

```json
# data.json
{
  "map":  {
    "name": "Default",
    "network": "A B 10\nB D 15\nA C 20\nC D 30\nB E 50\nD E 30"
  }
}
```

### Retrieving the best route

- **URL:** /maps/:id/best_route
- **VERB:** GET
- **PARAMETERS:**
 - id (map id)
 - source (point)
 - target (point)
 - vehicle_autonomy
 - fuel_price

```bash
curl -X GET \
     -d "source=A&target=D&vehicle_autonomy=10&fuel_price=2.50" \
     http://localhost:3000/maps/4/best_route
```
