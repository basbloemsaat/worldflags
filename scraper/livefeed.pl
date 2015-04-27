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

# from http://en.wikipedia.org/wiki/List_of_FIFA_country_codes
make_path("../flags");

my $flagcodes = {};
my $json = JSON->new()->pretty( [1] )->utf8( [1] )->canonical( [1] );

wq('http://en.wikipedia.org/wiki/List_of_FIFA_country_codes')
    ->find('tr td span.flagicon')->each(
    sub {
        my $flaguri = $_->find('img')->first()->attr('src');
        p $flaguri;

        my $name = $_->parent->find('a')->first()->text;
        p $name;

        my $code = $_->parent->parent->find('td:nth-child(2)')->first->text;
        p $code;

        return unless $code =~ /[A-Z]{3}/;

        for my $size ( 16, 24, 32, 48, 64 ) {
            my $rps   = $size . "px";
            my $rsuri = $flaguri =~ s/\d\dpx/$rps/r;    #/
            io( "../flags/$code" . "_$size.png" ) < io( 'https:' . $rsuri );
            $flagcodes->{$code}->{$size} = "flags/$code" . "_$size.png";
        }

    },
    );

$json->encode($flagcodes) > io('../flags.json');
