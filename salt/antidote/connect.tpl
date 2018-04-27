{%- set antidote_hosts = salt["pillar.get"]("antidote:nodes") -%}
{%- set starts = [] -%}
{%- set observers = [] -%}
{%- set desc = [] -%}

{%- for host in antidote_hosts -%}
{%- do starts.append("rpc:call(antidote@%s, inter_dc_manager, start_bg_processes, [stable])"%host) -%}
{%- endfor -%}
{%- for host in antidote_hosts -%}
{%- do starts.append("{ok, Desc%d} = rpc:call(antidote@%s, inter_dc_manager, get_descriptor, [])"%(loop.index,host)) -%}
{%- do desc.append('Desc%d'%loop.index) -%}
{%- endfor -%}
{%- for host in antidote_hosts -%}
{%- do observers.append("rpc:call(antidote@%s, inter_dc_manager, observe_dcs_sync, [Descriptors])"%host) -%}
{%- endfor -%}



{{ starts |join(",\n") }},
Descriptors = [{{ desc |join(",")  }}],
{{ observers|join(",\n") }}.

