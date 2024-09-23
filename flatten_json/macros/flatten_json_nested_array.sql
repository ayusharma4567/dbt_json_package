{# /* this macro only be used with json file with nested array */ #}
{% macro flatten_json_nested_array(model_name, json_column) %}

{% set get_json_path %}
with low_level_flatten as (
    select
        row_number() over (order by (select null)) as id,
        f.key as json_key,
        f.path as json_path,
        f.value as json_value,
        f.index as json_index
    from {{ model_name }},
    lateral flatten(input => {{ json_column }}, recursive => true) f
    )
select
distinct REGEXP_REPLACE(json_path, '\\[\\d+\\]', '') AS json_path,
json_value
from low_level_flatten
where not contains(json_value, '{') and not contains(json_value, '[')
{% endset %}

{% set res = run_query(get_json_path) %}
{% if execute %}
    {% set res_list = res.columns[0].values() %}
{% else %}
    {% set res_list = [] %}
{% endif %}

with flattened_data as (
    select
        row_number() over (order by (select null)) as id,
        f.key as json_key,
        REGEXP_REPLACE(f.path, '\\[\\d+\\]', '') as cleaned_json_path,
        f.value as json_value
    from {{ model_name }},
    lateral flatten(input => {{ json_column }}, recursive => true) f
    where not contains(json_value, '{') and not contains(json_value, '[')
),
distinct_paths as (
    select distinct cleaned_json_path from flattened_data
)

select
    {% for json_path in res_list | unique %}
        MAX(CASE WHEN cleaned_json_path = '{{ json_path }}' THEN json_value END) as {{ json_path | replace(".", "_") | replace("[", "_") | replace("]", "") | replace("'", "") }}{{ ",\n" if not loop.last else "" }}
    {% endfor %}
from flattened_data
group by id

{% endmacro %}



