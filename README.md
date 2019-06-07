# Clonebook

A facebook clone website built with Ruby on Rails.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

## Data model

![data model](https://github.com/zenott/clonebook/blob/data-model/data-model/erd.jpg)
