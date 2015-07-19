#!/usr/bin/env perl

use v5.020;
use strict;
use warnings;
use utf8;

binmode STDOUT, ":utf8";
binmode STDERR, ":utf8";
binmode STDIN,  ":encoding(UTF-8)";

use Data::Printer;
use File::Path qw(make_path);
use IO::All;
use JSON;
use Web::Query;
use String::Util 'crunch';

use experimental 'signatures';
no warnings "experimental::signatures";

# from http://en.wikipedia.org/wiki/List_of_FIFA_country_codes
make_path("../flags");

my $flagcodes   = {};
my $countrylist = {};
my $json        = JSON->new()->pretty( [1] )->utf8( [1] )->canonical( [1] );

my %countries;

my $q;

# =cut
$q = wq('https://en.wikipedia.org/wiki/List_of_IOC_country_codes');
$q->find('h2')->each(
    sub {
        return unless $_->text() =~ m/^\s*Current NOCs/i;
        my $table = $_->next;
        while ( $table->tagname() ne 'table' ) {
            $table = $table->next;
        }
        $table->find('tr')->each(
            sub {
                # p $_;
                my $cells = $_->find('td');
                return unless @{ $cells->{trees} } == 4;
                my $code    = crunch( $cells->first()->text() );
                my $flagimg = $cells->find('img');
                return unless $code;

                addcountrydata(
                    {   countryname => crunch( $flagimg->parent()->text() ),
                        IOC         => $code,
                        flag        => $flagimg->attr('src'),
                    }
                );

            }
        );
    }
);

# =cut

$q = wq('https://en.wikipedia.org/wiki/List_of_FIFA_country_codes');
$q->find('h2')->each(
    sub {
        return
            unless $_->text() =~ m/^\s*FIFA member codes/i
            || $_->text() =~ m/^\s*Non-FIFA member codes/i;

        my $table = $_->next;
        while ( $table->tagname() ne 'table' ) {
            $table = $table->next;
        }
        $table->find('tr td span.flagicon')->each(
            sub {
                my $flaguri = $_->find('img')->first()->attr('src');
                my $code    = crunch( $_->parent()->next()->text() );

                return unless $code;

                addcountrydata(
                    {   countryname => crunch( $_->parent()->text() ),
                        FIFA        => $code,
                        flag        => $flaguri,
                    }
                );

            }
        );

    }
);

# =cut

$q = wq('https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2');
$q->find('h3')->each(
    sub {
        return
            unless $_->text() =~ m/^\s*Officially assigned code elements/i;

        my $table = $_->next;
        while ( $table->tagname() ne 'table' ) {
            $table = $table->next;
        }
        $table->find('tr')->each(
            sub {
                my $cells = $_->find('td');
                my $code  = crunch( $cells->first()->text() );
                return unless $code;

                addcountrydata(
                    {   countryname =>
                            crunch( $cells->first()->next()->text() ),
                        ISO => $code,
                    }
                );
            }
        );

    }
);

# =cut

#add country unknown for a placeholder

# #manual corrections

# $countries{'Great Britain'}->{ISO}               = 'GB';
# $countries{"São Tomé and Príncipe"}->{ISO}    = 'ST';
# $countries{'Sint Maarten'}->{ISO}                = 'SX';
# $countries{'Republic of Ireland'}->{ISO}         = 'IR';
# $countries{'Republic of Ireland'}->{countryname2} = "Ireland";

mergecountries( 'Bolivia', 'Bolivia, Plurinational State of' );
mergecountries( 'Bonaire', 'Bonaire, Sint Eustatius and Saba' );
mergecountries( 'British Virgin Islands', 'Virgin Islands, British' );
mergecountries( 'Brunei',                 'Brunei Darussalam' );
mergecountries( 'China',                  'China PR' );
mergecountries( 'Chinese Taipei',         'Chinese Taipei[5]' );
mergecountries( 'Cape Verde',             'Cabo Verde' );
mergecountries( 'DR Congo', 'Congo, the Democratic Republic of the' );
mergecountries( 'Gambia',   'The Gambia' );
mergecountries( 'Great Britain',
    'United Kingdom of Great Britain and Northern Ireland' );
mergecountries( 'Iran',        'Iran, Islamic Republic of' );
mergecountries( 'Ireland',     'Republic of Ireland' );
mergecountries( 'Ivory Coast', "Cote d'Ivoire !Côte d'Ivoire" );
mergecountries( 'Macau',       'Macao' );
mergecountries( 'Moldova',     'Moldova, Republic of' );
mergecountries( 'North Korea', "Korea, Democratic People's Republic of" );
mergecountries( 'Palestine',   'Palestine, State of' );
mergecountries( 'Russia',      'Russian Federation' );
mergecountries( 'Réunion',    'Reunion !Réunion' );
mergecountries( 'São Tomé and Príncipe', 'Sao Tome and Principe' );
mergecountries( 'South Korea',              'Korea, Republic of' );
mergecountries( 'Syria',                    'Syrian Arab Republic' );
mergecountries( 'Tanzania',                 'Tanzania, United Republic of' );
mergecountries( 'Tahiti',                   'French Polynesia' );
mergecountries( 'Venezuela',      'Venezuela, Bolivarian Republic of' );
mergecountries( 'Vietnam',        'Viet Nam' );
mergecountries( 'Virgin Islands', 'Virgin Islands, U.S.' );
mergecountries( 'Virgin Islands', 'U.S. Virgin Islands' );
mergecountries( 'United States',  'United States of America' );

# p %countries;
# die;
my %clean;
my %doublecheck;

for my $name ( keys %countries ) {
    if ( $countries{$name}->{FIFA} ) {
        $countries{$name}->{code3} = $countries{$name}->{FIFA};
    }
    elsif ( $countries{$name}->{IOC} ) {
        $countries{$name}->{code3} = $countries{$name}->{IOC};
    }
    else {
        next;
    }

    $doublecheck{ $countries{$name}->{code3} }++;

    if (   $countries{$name}->{code3}
        && $countries{$name}->{flag} )
    {
        $clean{$name} = $countries{$name};
        delete $countries{$name};
    }
}

$clean{Unknown} = {
    code3 => 'UNK',
    flag =>
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Bandera_-_cuartelado.svg/120px-Bandera_-_cuartelado.svg.png',
};

# p %doublecheck;

my @dbl = grep { $doublecheck{$_} > 1 } keys(%doublecheck);

# p @dbl;
# p %countries;
# p %clean;

# haal plaatjes op

my %lookup_3;
my %lookup_codes;
my $i = 0;

foreach ( keys %clean ) {
    p $clean{$_};

# =cut 
    my $flaguri = $clean{$_}->{flag};
    $flaguri =~ s%^\/\/%https:\/\/%;
    my $code = $clean{$_}->{code3};

    for my $size ( 16, 24, 32, 48, 64, 96, 128, 256 ) {
        my $rps   = $size . "px-";
        my $rsuri = $flaguri =~ s/\d\d+px-/$rps/r;    #/
        io( "../flags/$code" . "_$size.png" ) < io($rsuri);
        $flagcodes->{$code}->{$size} = "flags/$code" . "_$size.png";

    }

    my $svguri = $flaguri =~ s/\.svg\/.*/.svg/r;           #/
    $svguri =~ s/\/thumb\//\//;                             #/
    io( "../flags/$code" . ".svg" ) < io($svguri);

    # p $svguri;
# =cut

    my $code3 = $clean{$_}->{code3};

    $lookup_3{$code3} = $_;

    if ( $clean{$_}->{ISO} && !exists $lookup_codes{ $clean{$_}->{ISO} } ) {
        $lookup_codes{ $clean{$_}->{ISO} } = $code3;
    }
    if ( $clean{$_}->{IOC} && !exists $lookup_codes{ $clean{$_}->{IOC} } ) {
        $lookup_codes{ $clean{$_}->{IOC} } = $code3;
    }
    foreach (@{$clean{$_}->{countryname}}) {
        $lookup_codes{ $_ } = $code3;
    }

    $lookup_codes{$code3} = $code3;

}

# p %lookup_3;
# p $i;

# maak lookuptabellen
# die;

# p %lookup_codes;

$json->encode(\%lookup_codes) > io('../flags.json');
$json->encode(\%lookup_3) > io('../countries.json');


exit;

sub mergecountries($src, $mrg) {
    $countries{$src}->{countryname} = [
        @{ $countries{$src}->{countryname} },
        @{ $countries{$mrg}->{countryname} },
    ];

    $countries{$src}->{ISO}
        = $countries{$src}->{ISO} || $countries{$mrg}->{ISO};
    $countries{$src}->{FIFA}
        = $countries{$src}->{FIFA} || $countries{$mrg}->{FIFA};
    $countries{$src}->{IOC}
        = $countries{$src}->{IOC} || $countries{$mrg}->{IOC};

    delete $countries{$mrg};
}

sub addcountrydata($data) {
    return if length( $data->{countryname} ) > 120;

    if ( $data->{countryname} ) {
        $countries{ $data->{countryname} }
            = { %{ $countries{ $data->{countryname} } // {} }, %{$data}, };
        $countries{ $data->{countryname} }->{countryname}
            = [ $data->{countryname} ];
    }
}

# p $q;

# wq('http://en.wikipedia.org/wiki/List_of_FIFA_country_codes')
#     ->find('tr td span.flagicon')->each(
#     sub {
#         my $flaguri = $_->find('img')->first()->attr('src');
#         p $flaguri;

#         my $name = $_->parent->find('a')->first()->text;
#         p $name;

#         my $code = $_->parent->parent->find('td:nth-child(2)')->first->text;
#         p $code;

#         return unless $code =~ /[A-Z]{3}/;

#         for my $size ( 16, 24, 32, 48, 64 ) {
#             my $rps   = $size . "px";
#             my $rsuri = $flaguri =~ s/\d\dpx/$rps/r;    #/
#             io( "../flags/$code" . "_$size.png" ) < io( 'https:' . $rsuri );
#             $flagcodes->{$code}->{$size} = "flags/$code" . "_$size.png";
#         }

#         $countrylist->{$name} = $code;

#     },
#     );

# $json->encode($flagcodes) > io('../flags.json');
# $json->encode($countrylist) > io('../countries.json');
