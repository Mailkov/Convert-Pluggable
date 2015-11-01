#!/usr/bin/env perl

use Dancer2;

set serializer => 'JSON';   # Dancer2::Serializer::JSON;

use lib '../lib';
use Convert::Pluggable;

# tell C::P where to get the data for the conversions:
my $c = Convert::Pluggable->new('units.json');
# or, ye olde waye:
# my $c = Convert::Pluggable->new();









#
# curl http://localhost:3000/convert/3/kg/ounces
#
get '/convert/:factor/:from/:to' => sub {
    my $conversion = $c->convert({
        'factor'    => params->{factor},
        'from_unit' => params->{from},
        'to_unit'   => params->{to},
    });

    return {
        result => $conversion,
    };
};









#
# curl  -X POST http://localhost:3000/add 
#       -d '{"type":"mass","unit":"RICE","factor":"666","aliases":"SHEEP|MONKEYS"}' 
#
post '/add' => sub {
    my $type    = params->{type};
    my $unit    = params->{unit};
    my $factor  = params->{factor};
    my $aliases = params->{aliases};

    my $success_message = qq|You have added $type:$unit:$factor:$aliases|;

    return {
        result  => $success_message,
    };
};

#
# update OR add
#
post '/update' => sub {
    my $type    = params->{type};
    my $unit    = params->{unit};
    my $factor  = params->{factor};
    my $aliases = params->{aliases};

    # add    if !exists
    # update if  exists


    my $success_message = qq|You have added $type:$unit:$factor:$aliases|;

    return {
        result  => $success_message,
    };
};

#
# curl http://localhost:3000/delete/kg
#
get '/delete/:unit' => sub {
    my $unit    = params->{unit};

    my $success_message = qq|You have deleted $unit|;

    return {
        result  => $success_message,
    };
};


dance;
