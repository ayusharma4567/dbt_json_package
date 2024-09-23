# dbt_json_package
├── flatten_json/
│   ├── macros/
│       ├── flatten_json_nested_array_json.sql
        ├── flatten_json
│   ├── dbt_project.yml
│   ├── README.md
|-- Linence
|-- Readme.md
# JSON Flatten Package

This dbt package contains a macro that can flatten any JSON structure into a structured format using Snowflake's `FLATTEN` function.

## How to Install

Add this package to your `packages.yml` file:

```yaml
packages:
  - git: "https://github.com/ayusharma4567/dbt_json_package.git"
    revision: "main"

