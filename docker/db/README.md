# Box Office Initiative Schema

The schema used is `boi` - the initials of Box Office Initiative.

Tables:
* mpaa_ratings:  
  One row per MPAA rating. Fields:  
  * id INT4 - the primary key
  * name TEXT - the rating
* movie_roles:  
  One row per movie role (e.g. 'Actor', 'Director', 'Producer', 'Screenwriter', etc.) Fields:  
  * id INT4 - the primary key
  * name TEXT - the role's name
* genres:  
  One row per movie genre (e.g. 'Drama', 'Musical', 'Action', 'Comedy', etc.). Fields:  
  * id INT4 - the primary key
  * name TEXT - the genre
* external_services:  
  One row per "external service" (e.g. 'Netflix', 'IMDB', etc.). Fields:  
  * id INT4 - the primary key
  * name TEXT - the service
* studios:  
  One row per studio (e.g. 'Warner Bros.', 'Universal', etc.) Fields:  
  * id INT4 - the primary key
  * name TEXT - the studio
* people:  
  One row per person. Fields:  
  * id INT8 - the primary key
  * display_name TEXT - the full name displayed everywhere
  * sex TEXT - Male/Female/Non-binary (per OpusData)
  * name_prefix TEXT - any name prefix (e.g. 'Dame')
  * first_name TEXT - person's first name
  * middle_names TEXT - any middle names
  * last_name TEXT - person's last name
  * professional_first_name TEXT - any "professional" first name (per OpusData)
  * professional_last_name TEXT any "professional" last name (per OpusData)
* movies:  
  One row per movie. Fields:  
  * id INT8 - the primary key
  * title TEXT - the movie's title
  * international_title TEXT - the movie's international title
  * production_year INT4 - year the movie was produced
  * run_time INT4 - run time in mins
  * budget_usd INT8 - budget in YSD
  * mpaa_rating INT4 - foreign key to mpaa_ratings table
  * distributor INT4 - foreign key to studios table
* movie_external_identifiers:  
  One row per movie per external service (from the external_services table, e.g. IMDB, Netflix etc.) which has the movie. So has the IMDB ID among other IDs. Fields:  
  * id INT8 - the primary key
  * movie_id INT8 - foreign key to the movies table
  * external_service_id INT4 - foreign key to the external_services table
  * external_identifier TEXT - the value of the movie's ID in the external service
* acting_credits:  
  One row per character per movie. I believe the same actor can appear multiple times per movie. Fields:  
  * id INT8 - the primary key
  * people_id INT8 - foreign key to people table
  * movie_id INT8 - foreign key to movies table
  * movie_role_id INT4 - foreign key to movie_roles table
  * character_name TEXT - the name of the character being played
  * title_ordering INT4 - the ordering of the actor in the credits (starting at 1)
* technical_credits:  
  One row per technical credit per movie. Fields:  
  * id INT8 - the primary key
  * people_id INT8 - foreign key to people table
  * movie_id INT8 - foreign key to movies table
  * movie_role_id INT4 - foreign key to the movie-roles table
  * title_ordering INT4 - the ordering of the person in the credits (starting at 1)
* movie_genres:  
  One row per genre per movie. In case a movie has multiple genres. OpusData has their own classification system which we could either use without changing or adapt slightly. Fields:  
  * id INT4 - the primary key
  * movie_id INT8 - foreign key to movies table
  * genre_id INT4 - foreign key to genres table
* movie_domestic_grosses:  
  One row per movie per day it earned any revenue domestically (in USA). Fields:  
  * id INT8 - the primary key
  * movie_id INT8 - foreign key to movies table
  * day DATE - the date the revenue was earned on
  * gross NUMERIC - the revenue earned in USD
  * num_theaters INT4 - the number of theaters the movie was being shown on this day
  * num_tickets INT4 - an estimate of the number of tickets sold this day (comes from OpusData - we may want to calculate this ourselves)
* movie_international_grosses:  
  One row per movie per day it earned any revenue intenationally. OpusData's most granular intenational data is only by weekend so maybe this will change to not be by day and instead be by week. Fields:  
  * id INT8 - the primary key
  * movie_id INT8 - foreign key to movies table
  * day DATE - the day the revenue was earned
  * country TEXT - the country it was earned in (there should probably be a countries table and this should be a foreign key)
  * gross NUMERIC - the revenue earned in USD
* movie_releases:  
  One row per movie per country of release and per "release type" (OpusData value which is either 'Wide', 'Limited', 'Exclusive', 'Expands Wide', 'Special Engagement', 'Oscar Qualifying Run', 'Festive Screening' or 'IMAX'). Fields:  
  * id INT8 - the primary key
  * movie_id INT8 - foreign key to the movies table
  * release_date DATE - the date of this release
  * territory TEXT - the country of release (also should probably FK to a countries table as movie_international_grosses.country should)
  * release_type TEXT - the "release type"
* historical_domestic_ticket_prices:  
  One row for every year we have historical ticket prices for. Used to inflation adjust grosses. Fields:  
  * id INT4 - the primary key
  * year INT4 - the year of this ticket price
  * price NUMERIC - the average price of a ticket in this year

