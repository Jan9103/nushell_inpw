# INPW Repository definition

A `nuon` file: `{ packages: [] }`

Package entries (in `packages`) are records with the following values:

Key         | type           | description
----------- | -------------- | -----------
name        | `string`       |
source      | `string`       |
tags        | `list<string>` | tags for the search
description | `string`       | a description for humans
settings    | `record`       | settings for the `packages.nuon`. example: `settings: {condition: {env: {TERM: ['xterm-kitty']}}}`
