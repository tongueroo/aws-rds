# Change Log

All notable changes to this project will be documented in this file.
This project *tries* to adhere to [Semantic Versioning](http://semver.org/), even before v1.0.

## [0.5.0]
- change config/env.yml option name to: fallback vpc_id and db_subnet_group_name

## [0.4.0]
- security-group-name option to create a security group if not specified in profile with vpc_security_group_ids

## [0.3.0]
- dont auto create security group when specified in the profile

## [0.2.0]
- allow erb usage in profiles, can reference config values
- rework profile and params to classes. profile no longer merged

## [0.1.2]
- remove require byebug

## [0.1.1]
- comment out auto name tagging of security group for now

## [0.1.0]
- initial release
