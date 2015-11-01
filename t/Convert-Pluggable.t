use Test::More;
use Math::Round qw/nearest/;

use Data::Dump qw/dump/;

BEGIN { use_ok('Convert::Pluggable') };

my $c = new Convert::Pluggable();
isa_ok($c, 'Convert::Pluggable');

my $result;

# should get a list of all units:
my $units_ref = $c->get_units();
isa_ok($units_ref, 'ARRAY');
my @units = @{$units_ref};

# all units should be singular:
my %singular_exceptions = qw(celsius);
foreach(@units) {
    my $unit = $_->{'unit'};
    unlike($unit, qr/s$/, "$unit should be singular") unless (exists $singular_exceptions{$unit});
}

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'year', 'to_unit' => 'months', } );
is($result->{'result'}, '12', 'OK');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'year', 'to_unit' => 'wk', } );
is($result->{'result'}, '52.1428571428571', 'OK');

$result = $c->convert( { 'factor' => '16', 'from_unit' => 'years', 'to_unit' => 'months', } );
is($result->{'result'}, '192', 'OK');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'day', 'to_unit' => 'yr', } );
is($result->{'result'}, '0.00273972602739726', 'OK');

$result = $c->convert( { 'factor' => '5', 'from_unit' => 'oz', 'to_unit' => 'g', } );
is($result->{'result'}, '141.747462720417', 'OK');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'ton', 'to_unit' => 'long ton', } );
is($result->{'result'}, '0.892858633233845', 'OK');

$result = $c->convert( { 'factor' => '158', 'from_unit' => 'ounce', 'to_unit' => 'lbm', } );
is($result->{'result'}, '9.87497760390089', 'OK');

$result = $c->convert( { 'factor' => '0.111', 'from_unit' => 'stone', 'to_unit' => 'pound', } );
is($result->{'result'}, '1.55399859023452', 'OK');

$result = $c->convert( { 'factor' => '3', 'from_unit' => 'kilogramme', 'to_unit' => 'pound', } );
is($result->{'result'}, '6.61386', 'OK');

$result = $c->convert( { 'factor' => '1.3', 'from_unit' => 'tonnes', 'to_unit' => 'ton', } );
is($result->{'result'}, '1.433003', 'OK');

$result = $c->convert( { 'factor' => '2', 'from_unit' => 'tons', 'to_unit' => 'kg', } );
is($result->{'result'}, '1814.37163774256', 'OK');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'ton', 'to_unit' => 'kilos', } );
is($result->{'result'}, '907.185818871279', 'OK');

$result = $c->convert( { 'factor' => '3.9', 'from_unit' => 'oz', 'to_unit' => 'grams', } );
is($result->{'result'}, '110.563020921925', 'OK');

$result = $c->convert( { 'factor' => '2', 'from_unit' => 'miles', 'to_unit' => 'km', } );
is($result->{'result'}, '3.218688', 'OK');

$result = $c->convert( { 'factor' => '5', 'from_unit' => 'feet', 'to_unit' => 'in', } );
is($result->{'result'}, '60.000030479999', 'OK');

$result = $c->convert( { 'factor' => '2', 'from_unit' => 'mi', 'to_unit' => 'km', } );
is($result->{'result'}, '3.21868899578513', 'OK');

$result = $c->convert( { 'factor' => '0.5', 'from_unit' => 'nautical mile', 'to_unit' => 'klick', } );
is($result->{'result'}, '0.925999662936123', 'OK');

$result = $c->convert( { 'factor' => '500', 'from_unit' => 'miles', 'to_unit' => 'metres', } );
is($result->{'result'}, '804672', 'OK');

$result = $c->convert( { 'factor' => '25', 'from_unit' => 'cm', 'to_unit' => 'inches', } );
is($result->{'result'}, '9.842525', 'OK');

$result = $c->convert( { 'factor' => '1760', 'from_unit' => 'yards', 'to_unit' => 'miles', } );
is($result->{'result'}, '0.99999999848', 'OK');

$result = $c->convert( { 'factor' => '3520', 'from_unit' => 'yards', 'to_unit' => 'miles', } );
is($result->{'result'}, '1.99999999696', 'OK');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'stone', 'to_unit' => 'lbs', } );
is($result->{'result'}, '13.9999872994101', 'OK');

$result = $c->convert( { 'factor' => '30', 'from_unit' => 'cm', 'to_unit' => 'in', } );
is($result->{'result'}, '11.81103', 'OK');

$result = $c->convert( { 'factor' => '36', 'from_unit' => 'months', 'to_unit' => 'years', } );
is($result->{'result'}, '3', 'OK');

$result = $c->convert( { 'factor' => '43200', 'from_unit' => 'seconds', 'to_unit' => 'hours', } );
is($result->{'result'}, '12', 'OK');

$result = $c->convert( { 'factor' => '4', 'from_unit' => 'hours', 'to_unit' => 'minutes', } );
is($result->{'result'}, '240', 'OK');

$result = $c->convert( { 'factor' => '5', 'from_unit' => 'kelvin', 'to_unit' => 'fahrenheit', } );
is($result->{'result'}, '-450.67', 'OK');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'bar', 'to_unit' => 'pascal', } );
is($result->{'result'}, '100000', 'OK');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'kilopascal', 'to_unit' => 'psi', } );
is($result->{'result'}, '0.145036839357197', 'OK');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'atm', 'to_unit' => 'kpa', } );
is($result->{'result'}, '101.325', 'OK');

$result = $c->convert( { 'factor' => '5', 'from_unit' => 'yrds', 'to_unit' => 'km', } );
is($result->{'result'}, '0.00457199999305056', 'OK');

$result = $c->convert( { 'factor' => '12', 'from_unit' => '"', 'to_unit' => 'cm', } );
is($result->{'result'}, '30.4799835408089', 'OK');

$result = $c->convert( { 'factor' => '25', 'from_unit' => 'inches', 'to_unit' => 'feet', } );
is($result->{'result'}, '2.08333227500057', 'OK');

$result = $c->convert( { 'factor' => '42', 'from_unit' => 'kilowatt hours', 'to_unit' => 'joules', } );
is($result->{'result'}, '151200000', 'OK');

$result = $c->convert( { 'factor' => '2500', 'from_unit' => 'kcal', 'to_unit' => 'tons of tnt', } );
is($result->{'result'}, '0.0025', 'OK');

$result = $c->convert( { 'factor' => '90', 'from_unit' => 'ps', 'to_unit' => 'watts', } );
is($result->{'result'}, '66194.8875', 'OK');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'gigawatt', 'to_unit' => 'horsepower', } );
is($result->{'result'}, '1341022.08959503', 'OK');

$result = $c->convert( { 'factor' => '180', 'from_unit' => 'degrees', 'to_unit' => 'radians', } );
is($result->{'result'}, '3.14159265358979', 'OK');

$result = $c->convert( { 'factor' => '270', 'from_unit' => 'degrees', 'to_unit' => 'quadrants', } );
is($result->{'result'}, '3', 'OK');

$result = $c->convert( { 'factor' => '180', 'from_unit' => 'degrees', 'to_unit' => 'grads', } );
is($result->{'result'}, '200', 'OK');

$result = $c->convert( { 'factor' => '45', 'from_unit' => 'newtons', 'to_unit' => 'pounds force', } );
is($result->{'result'}, '10.116402439487', 'OK');

$result = $c->convert( { 'factor' => '8', 'from_unit' => 'poundal', 'to_unit' => 'newtons', } );
is($result->{'result'}, '1.106039635008', 'OK');

$result = $c->convert( { 'factor' => '5', 'from_unit' => 'f', 'to_unit' => 'celsius', } );
is($result->{'result'}, '-15', 'OK');

$result = $c->convert( { 'factor' => '6^2', 'from_unit' => 'oz', 'to_unit' => 'grams', } );
is($result->{'result'}, 1020.581731587, 'OK');

$result = $c->convert( { 'factor' => 'NaN', 'from_unit' => 'oz', 'to_unit' => 'stones', } );
is($result->{'result'}, undef, 'OK');

#$result = $c->convert( { 'factor' => '45x10', 'from_unit' => 'oz', 'to_unit' => 'stones', } );
#is($result->{'result'}, undef, 'OK');

$result = $c->convert( { 'factor' => '-9', 'from_unit' => 'g', 'to_unit' => 'ozs', } );
is($result->{'result'}, undef, 'OK');

$result = $c->convert( { 'factor' => '5', 'from_unit' => 'oz', 'to_unit' => 'yards', } );
is($result->{'result'}, undef, 'OK');

#$result = $c->convert( { 'factor' => 'Inf', 'from_unit' => 'oz', 'to_unit' => 'stones', } );
#is($result->{'result'}, undef, 'OK');

$result = $c->convert( { 'factor' => '-5', 'from_unit' => 'kelvin', 'to_unit' => 'fahrenheit', } );
is($result->{'result'}, undef, 'OK');

#$result = $c->convert( { 'factor' => 'use', 'from_unit' => 'ton', 'to_unit' => 'stones', } );
#is($result->{'result'}, undef, 'OK');

#$result = $c->convert( { 'factor' => 'shoot', 'from_unit' => 'oneself', 'to_unit' => 'foot', } );
#is($result->{'result'}, undef, 'OK');

#$result = $c->convert( { 'factor' => 'foot', 'from_unit' => 'both', 'to_unit' => 'camps', } );
#is($result->{'result'}, undef, 'OK');

#$result = $c->convert( { 'factor' => 'puff', 'from_unit' => 'toke', 'to_unit' => 'kludge', } );
#is($result->{'result'}, undef, 'OK');
    
$result = $c->convert( { 'factor' => '10', 'from_unit' => 'milligrams', 'to_unit' => 'tons', } );
is($result->{'result'}, 1.10231e-08, '10 milligrams is 1.1e-08 tons');

$result = $c->convert( { 'factor' => '10000', 'from_unit' => 'minutes', 'to_unit' => 'microseconds', } );
is($result->{'result'}, 600000000000, '10000 minutes is 6e+11 microseconds');

$result = $c->convert( { 'factor' => '5', 'from_unit' => 'bytes', 'to_unit' => 'bit', } );
is($result->{'result'}, 40, '5 bytes is 40.000 bits');

$result = $c->convert( { 'factor' => '5', 'from_unit' => 'GB', 'to_unit' => 'megabyte', } );
is($result->{'result'}, 5000, '5 gigabytes is 5000.000 megabytes');

$result = $c->convert( { 'factor' => '0.013', 'from_unit' => 'mb', 'to_unit' => 'bits', } );
is($result->{'result'}, 104000, '0.013 megabytes is 104000.000 bits');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'exabyte', 'to_unit' => 'pib', } );
is($result->{'result'}, 888.178419700125, '1 exabyte is 888.178 pebibytes');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'yb', 'to_unit' => 'yib', } );
is($result->{'result'}, 0.827180612553028, '1 yottabyte is 0.827 yobibytes');

#areas
$result = $c->convert( { 'factor' => '1', 'from_unit' => 'ha', 'to_unit' => 'acre', } );
is($result->{'result'}, 2.4710439, '1 hectare is ~ 2.471 acres');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'km^2', 'to_unit' => 'ha', 'precision' => $precision, } );
is($result->{'result'}, 100, '1 km^2 is 100 ha');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'cm^2', 'to_unit' => 'square inches', } );
is($result->{'result'}, 0.15500031, '1 cm^2 is ~ 0.155 inches^2');

$result = $c->convert( { 'factor' => '1254', 'from_unit' => 'm^2', 'to_unit' => 'square miles', } );
is($result->{'result'}, 0.000484172108744438, '1254 m^2 is ~ 0.00048417211 miles^2');

$result = $c->convert( { 'factor' => '1254', 'from_unit' => 'feet^2', 'to_unit' => 'square inches', } );
is($result->{'result'}, 180576.006990025, '1254 feet^2 is ~ 180576 inch^2');

$result = $c->convert( { 'factor' => '1254', 'from_unit' => 'm^2', 'to_unit' => 'sq mi', } );
is($result->{'result'}, 0.000484172108744438, '1254 m^2 is ~ 0.00048417211 miles^2');

$result = $c->convert( { 'factor' => '125', 'from_unit' => 'yards^2', 'to_unit' => 'metres^2', } );
is($result->{'result'}, 104.515924046188, '125 yards^2 is ~ 104.516 metres^2');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'ha', 'to_unit' => 'tsubo', } );
is($result->{'result'}, 3024.9863876, '1 hectare is ~ 3025 tsubo');

#volumes
$result = $c->convert( { 'factor' => '1', 'from_unit' => 'pint', 'to_unit' => 'ml', } );
is($result->{'result'}, 568.26125, '1 fl oz is ~ 568 ml');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'imperial gallon', 'to_unit' => 'l', } );
is($result->{'result'}, 4.54609, '1 gallon is ~ 4.5 litres');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'imperial gallon', 'to_unit' => 'pints', } );
is($result->{'result'}, 8, '1 gallon  = 8 pints');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'us gallon', 'to_unit' => 'us quarts', } );
is($result->{'result'}, 4, '1 gallon  = 4 quarts');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'us pints', 'to_unit' => 'us fluid ounces', } );
is($result->{'result'}, 16, '1 us pint  = 16 us fluid oz');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'us gallon', 'to_unit' => 'us fluid ounces', } );
is($result->{'result'}, 16*8, '1 gallon  = 16*8');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'imperial pints', 'to_unit' => 'imperial fluid ounces', } );
is($result->{'result'}, 16, '1 imperial pint  = 16 imperial fluid oz');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'imperial gallon', 'to_unit' => 'imperial fluid ounces', } );
is($result->{'result'}, 16*8, '1 gallon  = 16*8');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'millilitre', 'to_unit' => 'imperial fluid ounces', } );
is($result->{'result'}, 0.0281560637822832, '1 millilitre ~ 0.03 us fl oz');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'millilitre', 'to_unit' => 'us cup', } );
is($result->{'result'}, 0.0042267528, '1 millilitre = 0.004 us cups');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'millilitre', 'to_unit' => 'metric cup', } );
is($result->{'result'}, 0.004, '1 millilitre = 0.004 metric cups');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'ha', 'to_unit' => 'square kilometer', 'precision' => $precision, } );
is($result->{'result'}, 0.01, '1 hectare is ~ 0.01 square kilometers');

$result = $c->convert( { 'factor' => '1', 'from_unit' => 'mile', 'to_unit' => 'yards', 'precision' => $precision, } );
is($result->{'result'}, 1760.0000026752, '1 mile is 1760 yards');

done_testing();
