/****************************************
 *                Tables
 ****************************************/

/* Contains e.g. 'PG', 'PG-13', 'R', etc. */
CREATE TABLE boi.mpaa_ratings (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

/* Contains e.g. 'Actor', 'Director', 'Producer', 'Screenwriter', etc. */
CREATE TABLE boi.movie_roles (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

/* Contains e.g. 'Drama', 'Musical', 'Action', 'Comedy', etc. */
CREATE TABLE boi.genres (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

/* Contains e.g. 'IMDB', 'Netflix', etc. */
CREATE TABLE boi.external_services (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

/* Contains studios e.g. Universal, Warner Bros. */
CREATE TABLe boi.studios (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

/* Contains all actors, directors, producers etc. - everyone */
CREATE TABLE boi.people (
    id BIGSERIAL PRIMARY KEY,
    display_name TEXT NOT NULL,
    sex TEXT,
    name_prefix TEXT,
    first_name TEXT,
    middle_names TEXT,
    last_name TEXT,
    professional_first_name TEXT,
    professional_last_name TEXT
);

/* Contains all movies */
CREATE TABLE boi.movies (
    id BIGSERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    international_title TEXT,
    production_year INT4,
    run_time INT4,
    budget_usd INT8,
    mpaa_rating INT4 REFERENCES boi.mpaa_ratings(id),
    distributor INT4 REFERENCES boi.studios(id)
);

/* Links actors to movies, and what role they had */
CREATE TABLE boi.acting_credits (
    id BIGSERIAL PRIMARY KEY,
    people_id INT8 NOT NULL REFERENCES boi.people(id),
    movie_id INT8 NOT NULL REFERENCES boi.movies(id),
    movie_role_id INT4 NOT NULL REFERENCES boi.movie_roles(id),
    character_name TEXT,
    title_ordering INT4 NOT NULL
);

/* Links technical workers to movies and what role they had */
CREATE TABLE boi.technical_credits (
    id BIGSERIAL PRIMARY KEY,
    people_id INT8 NOT NULL REFERENCES boi.people(id),
    movie_id INT8 NOT NULL REFERENCES boi.movies(id),
    movie_role_id INT4 NOT NULL REFERENCES boi.movie_roles(id),
    title_ordering INT4 NOT NULL
);

/* Links genres to movies to know what genres a movie is */
CREATE TABLE boi.movie_genres (
    id BIGSERIAL PRIMARY KEY,
    movie_id INT8 NOT NULL REFERENCES boi.movies(id),
    genre_id INT4 NOT NULL REFERENCES boi.genres(id)
);

/* Contains domestic grosses (and theater count) each day for each movie */
CREATE TABLE boi.movie_domestic_grosses (
    id BIGSERIAL PRIMARY KEY,
    movie_id INT8 NOT NULL REFERENCES boi.movies(id),
    day DATE NOT NULL,
    gross NUMERIC NOT NULL,
    num_theaters INT4,
    num_tickets INT4
);

/* Contains international grosses each day for each movie and each country */
CREATE TABLE boi.movie_international_grosses (
    id BIGSERIAL PRIMARY KEY,
    movie_id INT8 NOT NULL REFERENCES boi.movies(id),
    day DATE NOT NULL,
    country TEXT NOT NULL,
    gross NUMERIC NOT NULL
);

/* Contains movie release dates per territory and release type */
CREATE TABLE boi.movie_releases (
    id BIGSERIAL PRIMARY KEY,
    movie_id INT8 NOT NULL REFERENCES boi.movies(id),
    release_date date NOT NULL,
    territory TEXT NOT NULL,
    release_type TEXT NOT NULL
);

/* Contains all external ids for a movie (e.g. IMDB ID, Netflix ID, etc.) */
CREATE TABLE boi.external_movie_identifiers (
    id BIGSERIAL PRIMARY KEY,
    movie_id INT8 NOT NULL REFERENCES boi.movies(id),
    external_service_id INT4 NOT NULL REFERENCES boi.external_services(id),
    external_identifier TEXT NOT NULL
);

/* Contains inflation rates for adjusting grosses */
CREATE TABLE boi.historical_domestic_ticket_prices (
    id SERIAL PRIMARY KEY,
    year INT4 UNIQUE NOT NULL,
    price NUMERIC NOT NULL
);
