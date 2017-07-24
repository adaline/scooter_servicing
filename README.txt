SETUP
-----

Have `ruby` and `bundler` installed.
Run `bundler` in project root to install dependencies.

TEST
-----

Only the calculation class is tested for this challenge, as that is the interesting part.
Run `ruby -Ilib:test test/test_coup_service_packer.rb`

USAGE
-----

Script takes a JSON string as input and returns json sting/error.
Run `./fleet_engineers.rb "{ \"scooters\": [15, 10], \"C\": 12, \"P\": 5 }"`
