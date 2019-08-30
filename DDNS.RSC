:local WAN "ether1-WAN";
:local IPv4URL "http://sync.afraid.org/u/token/";
:local IPv6URL "http://v6.sync.afraid.org/u/token/";
:global currentIPv4;
:global currentIPv6;
:global currentIPv6LinkLocal;

:local IPv4 [/ip address get [/ip address find interface=$WAN] address];							#:set IPv4 [:pick [:tostr $IPv4] 0 [:find [:tostr $IPv4] "/"]];
:local IPv6 [/ipv6 address get [:pick [/ipv6 address find interface=$WAN] 1] address];				#[:pick $fromArray 0]
:local IPv6LinkLocal [/ipv6 address get [:pick [/ipv6 address find interface=$WAN] 0] address];

:if ($IPv4 != $currentIPv4)\
do={
	:log warning "Dynamic DNS: IPv4 $IPv4";
	:set currentIPv4 $IPv4;
	/tool fetch mode=http url=$IPv4URL keep-result=no;
}

:if ($IPv6 != $currentIPv6)\
do={
	:log warning "Dynamic DNS: IPv6 $IPv6";
	:set currentIPv6 $IPv6;
	/tool fetch mode=http url=$IPv6URL keep-result=no;
}

:if ($currentIPv6LinkLocal != $IPv6LinkLocal)\
do={
	:log warning "IPv6 Link Local $IPv6LinkLocal";
	:set currentIPv6LinkLocal $IPv6LinkLocal;
}

:log info "Dynamic DNS has been checked";
