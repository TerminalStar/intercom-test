# intercom-test
My solution to the given problem:

>We have some customer records in a text file (customers.txt) -- one customer per line, JSON lines formatted. We want to invite any customer within 100km of our Dublin office for some food and drinks on us. Write a program that will read the full list of customers and output the names and user ids of matching customers (within 100km), sorted by User ID (ascending).

## Setup
MacOS focussed and assumes you already have [Homebew](https://brew.sh/) installed/setup.

1. `git clone` the repo
2. Install ruby: this project uses [rbenv](https://github.com/rbenv/rbenv), which recommends installing via homebrew (`brew install rbenv`). See the docs for other operating systems.
3. Install bundler: run `gem install bundler`
4. Install gems: run `bundle install`

## Run
Run `ruby bin/find_closest_customers.rb` in your Terminal. The output (a list of the customers within distance) is saved to the file `output.txt` in the top level directory.

You can change the distance within which customers must be situated (expressed in km) by passing the argument `--distance` with the value to search within. Defaults to 100.

You can also change the file that customer data is read in from, by passing `--filepath` and the file's name. Defaults to `/bin/customers.txt`.

## Test
Run `rspec` in the project directory.
