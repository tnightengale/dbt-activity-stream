{% macro last_before_join_clause(i) %}

{% set stream = dbt_activity_schema.alias_stream %}
{% set columns = dbt_activity_schema.columns() %}

(
    {{ stream(i) }}.{{- columns.ts }} <= coalesce({{ stream() }}.{{- columns.ts }}, '1900-01-01'::timestamp)
)
{% endmacro %}


{% macro last_before_aggregation_func() %}
max({{ caller() }})
{% endmacro %}


{% macro last_before() %}

{% do return(namespace(
    name="last_before",
    aggregation_func=dbt_activity_schema.last_before_aggregation_func,
    join_clause=dbt_activity_schema.last_before_join_clause
)) %}

{% endmacro %}
