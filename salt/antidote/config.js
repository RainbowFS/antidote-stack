const config = {
    antidote: [

	{% for k,v in salt["mine.get"]("*","datapath_ip").items() %}
        {
		host: '{{v[0]}}',
            port: 8087
        },
	{% endfor %}
    ],
    partitionCmd: './net_part.sh'
};

module.exports = config;

