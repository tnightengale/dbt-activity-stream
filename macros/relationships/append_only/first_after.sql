{% macro first_after_join_clause(i) %}

{% set stream = dbt_activity_schema.alias_stream %}
{% set columns = dbt_activity_schema.columns() %}

(
    {{ stream(i) }}.{{- columns.ts }} > {{ stream() }}.{{- columns.ts }}
)
{% endmacro %}


{% macro first_after_aggregation_func() %}
min({{ caller() }})
{% endmacro %}


{% macro first_after() %}

{% do return(namespace(
    name="first_after",
    aggregation_func=dbt_activity_schema.first_after_aggregation_func,
    join_clause=dbt_activity_schema.first_after_join_clause
)) %}

{% endmacro %}
