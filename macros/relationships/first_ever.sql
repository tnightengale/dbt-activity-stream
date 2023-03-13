{% macro first_ever_join_clause(i=none) %}
(
    {{ dbt_activity_schema.alias_stream(i) }}.{{ dbt_activity_schema.columns().activity_occurrence }} = 1
)
{% endmacro %}


{% macro first_ever_aggregation_func() %}
min({{ caller() }})
{% endmacro %}


{% macro first_ever() %}

{% do return(namespace(
    name="first_ever",
    aggregation_func=dbt_activity_schema.first_ever_aggregation_func,
    join_clause=dbt_activity_schema.first_ever_join_clause,
    where_clause=dbt_activity_schema.first_ever_join_clause()
)) %}

{% endmacro %}
