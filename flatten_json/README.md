Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test

## How to Run Tests

1. After installing the package, you can run the provided tests to verify that the macros work as expected.
   
2. Run the tests using:

   ```bash
   dbt test
   
3. use this to run the package:
      this macro only be used with json file with nested array
      -- with flatten_json_nested_array as (

      {{ flatten_json_nested_array(

         model_name = source('my_source','employee'),
         json_column = 'json_data'

      ) }}
      )

      select * 
      from flatten_json_nested_array

      --this macro only be used with json file without nested array

      with flatten_json as (

      {{ flatten_json(

         model_name = source('my_source','employee'),
         json_column = 'json_data'

      ) }}
      )

      select * 
      from flatten_json


