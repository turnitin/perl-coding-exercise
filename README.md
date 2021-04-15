# Turnitin Perl Coding Exercise

Welcome! We're excited you've decided to talk with us about a position on our
engineering team.

The purpose of this exercise is so we can have a conversation about your
technical background and abilities. We think that asking you to code on a
whiteboard during an interview isn't a great way to have a conversation. And
even if we sit down and pair during an interview it's a higher pressure
situation than it could be.

Instead we ask that you read these instructions and do *at most* a few hours of
work, on your time, to complete the exercise. During the interview we'll talk
about decisions you've made, the resulting application, and how you might
change it given different circumstances.

Below are two sections:

* *Instructions*: the problem we'd like you to solve along with expectations we
  have about your solution.
* *Logistics*: constraints around the problem, and how we'd like you to
  communicate your solution to us

# Instructions

## Problem

We're starting a new application and we need to store students! We'd like to be
able to do the following with the students:

* Create a student
* Retrieve a particular student by unique identifier
* Search students in the system

__1.__ Format

The application should accept and produce JSON with appropriate content types.

__2.__ Data

The student record has the following fields:

* An `id` that uniquely identifies the student. This will be provided by the
  server when the student is created and must not be changed after creation.
* Either an `email` or a `username` must be non-blank, and whichever (or both)
  are defined the value must be unique within that field. Additionally, the
  `email` field should contain a superficially valid email.
* A `first_name` and `last_name`; the `last_name` is required to be non-blank.
* A `display_name`, which if not defined at creation should be the first name
  and last names joined with a space.
* The `created_at` datetime when the student was added to the system, which
  should be assigned by the system when the student is created. It should be
  formatted 'YYYY-MM-DD HH:mm:ss' -- for example '2016-11-08 22:18:03' for
  'November 8, 2016 at 10:18:03 PM'.
* The `started_at` date of the student started at an institution; if not
  specified it should be the date the student was added to the system. It
  should be formatted 'YYYY-MM-DD' -- for example, '2016-11-08' for 'November 8,
  2016'.

__3.__ Search

The students may be searched by the following fields:

* `name` (which is a partial match against any of the first name, last name,
  and display name)
* `username` (partial match)
* `email` (partial match)
* `started_after` (date formatted `YYYY-MM-DD` that will return students
  who started on or after a particular date)

If multiple fields provided any returned records must match all of them -- that
is, you should treat them as an `AND`. For example, the following query would
find students with 'Jen' in their name who started after 'November 15, 2016':

```
GET /students?name=Jen&started_after=2016-11-15
```

__4.__ Routes

The routes you should use are:

* Create a student: `POST /students`
* Search students: `GET /students`
* Retrieve a student: `GET /students/{id}` (where `{id}` is the value assigned
  by the server)
* Health check: `GET /service/health` should return a successful HTTP status

__5.__ Other thoughts

During our discussion we'll talk about your code and decisions you've made.
We may also challenge assumptions in the problem, or add requirements. For
example:

* How might student data be changed?
* What if we wanted to create many students at once?
* What if we wanted to assign each student to a school? More than one school?
* What if we wanted to track whether the student has logged in?

## Language and Environment

__1.__ Language

Please use Perl to solve this problem. You may use modules from CPAN in your
solution, but be prepared to explain why you chose the modules you did.

__2.__ Runtime

Your solution must be runnable via Docker. There's a starter
`docker-compose.yml` file in this directory you can use to run your solution
with a Postgres database and Redis key/value store. When we run your
application we'll check out your git repository and run `docker-compose up` and
expect it to run.

Note that your solution does not have to use either Postgres or Redis to store its
state -- we'll restart your service every time we check its output. If
you'd like to use a persistent store for state you should use one of those two.

If you use CPAN modules, you should use a `cpanfile` to declare them. There is
a starter [`cpanfile`](app/cpanfile) in the `app` directory, and the `Dockerfile` uses `cpanm` to
install the modules listed in that file. When we run `docker-compose up --build` the
container for your service will be built and ready to go.

If you use a Postgres database, there is a starter [`app.sql`](sql/app.sql) file in the `sql` directory.
Modify this to set up your desired database schema. To recreate the database you will 
need to reload and refresh the Docker volumes with `docker-compose up -V`

If you use a Redis cache, you can wipe / recreate the cache with `docker-compose up -V`, similarly to the DB schema.

If you need to change the command that is used at start up (currently `CMD [ "perl", "app.pl" ]`),
change the `CMD` that is used by the [`Dockerfile`](Dockerfile).

The example hello world app in this repo uses `Mojolicious`, please feel free to use whatever framework /
approach you like. The example is also in a single `.pl` file, please feel free to restructure
the application to whatever structure you feel is appropriate.

__5.__ Testing

Unit tests are encouraged but not required; we'll understand if you spend your
time on the solution rather than the tests. (Especially because we provide a
test harness, see below.)

## Checking your work

There is a `exercise/` directory in this repo with a script that you can use to
exercise your solution with Docker. All you'll need to do is build it:

```
$ cd exercise
$ docker build -t turnitin-check .
```

And then point it at your solution, passing in the top-level URL to a running
server:

```
$ docker run --rm turnitin-check http://myhost:8080
```

If everything is working you should expect to see output like this:

```
test_can_fetch_created (__main__.VerifyCreate) ... ok
test_can_provide_display_name (__main__.VerifyCreate) ... ok
test_fail_duplicate_email (__main__.VerifyCreate) ... ok
test_fail_missing_email_or_username (__main__.VerifyCreate) ... ok
test_fail_missing_last_name (__main__.VerifyCreate) ... ok
test_fills_in_date_fields (__main__.VerifyCreate) ... ok
test_generates_display_name (__main__.VerifyCreate) ... ok
test_fetch_invalid_id (__main__.VerifyFetch) ... ok
test_empty_results_with_records_and_no_match (__main__.VerifySearch) ... ok
test_multiple_match_any_name (__main__.VerifySearch) ... ok
test_multiple_matches_started_after (__main__.VerifySearch) ... ok
test_no_criteria_is_invalid (__main__.VerifySearch) ... ok
test_no_match_started_after (__main__.VerifySearch) ... ok
test_single_match_first_name (__main__.VerifySearch) ... ok

----------------------------------------------------------------------
Ran 14 tests in 0.106s

OK
```

# Logistics

__1.__ Timeframe

You should take a max of three hours to complete this exercise. We want to be
both respectful of your time and fair to other candidates who might not have
a whole weekend to work on it.

__2.__ Git

You will need to use git for this exercise. To get these instructions and a
repo with test scripts do the following:

1. [Create a Github account](https://github.com/join) if you don't already have
   one. For the examples below we assume a user `pusheen`.
2. Clone our repository:

```
# Using ssh
$ git clone git@github.com:turnitin/perl-coding-exercise.git

# Using https
$ git clone https://pusheen@github.com/turnitin/perl-coding-exercise.git
```

__3.__ Remote

Once you are done you can put your solution in your own repository by adding it
as a remote and pushing to it.

1. Create a new repo via the github UI, let's assume you call it
   `perl-coding-exercise` to mirror ours.
2. If possible use a private repo. If you've run out of private repos on GitHub
   then no worries, we'd just like to make sure that every candidate's work is
   their own.
3. Add your repo as a remote and push:

```
$ git remote add myrepo git@github.com:pusheen/perl-coding-exercise.git
$ git push myrepo main
```

__4.__ Access

Give these GitHub users read access to your repository:
* janinedog
* omgwagon
* mauton

__5.__ Notify us

When you're ready, please send your repository address to your recruiter
contact.

__6.__ Resources

Here are some resources that may be useful:

* [Docker for Mac](https://docs.docker.com/docker-for-mac/) or
  [Docker for Windows](https://docs.docker.com/docker-for-windows/) should
  help you get Docker installed if you don't already have it. (If you're using
  a Linux desktop you can just `sudo apt-get install docker` -- lucky you!)
  Another resource is [Docker Machine](https://docs.docker.com/machine/) which
  walks you through installing Docker on a VM running on VirtualBox; you may
  prefer that if you've already got VirtualBox installed.
* [Docker Compose](https://docs.docker.com/compose/) -- This should already be
  installed if you use the Docker for Mac/Windows options, but if not it's just
  a binary you can install.

