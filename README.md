# schema cache dump issue example

this repo contains sample app which uses postgresql virtual columns feature that
is not properly working with activerecord database schema cache

you can check commit history or compare `db/schema.rb` file with the
`db/_schema_before_cache_dump.rb`

the problem is that after introducing the cache virtual columns are dumped as regular columns

before cache
```
    t.virtual "full_name", type: :text, as: "((first_name || ' '::text) || last_name)", stored: true
```

after cache
```
    t.text "full_name", default: -> { "((first_name || ' '::text) || last_name)" }
```

this causes `PG::FeatureNotSupported` error when recreating database from schema
```
ActiveRecord::StatementInvalid: PG::FeatureNotSupported: ERROR:  cannot use column reference in DEFAULT expression
LINE 1: ...ext, "last_name" text, "full_name" text DEFAULT ((first_name...
```