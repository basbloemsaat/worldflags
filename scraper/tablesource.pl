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

my $data = do { local $/ = undef; <DATA> };
# p $data;

# exit;

my $flagcodes   = {};
my $countrylist = {};
my $json        = JSON->new()->pretty( [1] )->utf8( [1] )->canonical( [1] );

wq($data)
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

        $countrylist->{$name} = $code;

    },
    );

$json->encode($flagcodes) > io('../flags.json');
$json->encode($countrylist) > io('../countries.json');

__DATA__
<table>
<tr>
<td valign="top">
<table class="wikitable" style="font-size:90%;">
<tr>
<th>Country</th>
<th>Code</th>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Afghanistan.svg/23px-Flag_of_Afghanistan.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Afghanistan.svg/35px-Flag_of_Afghanistan.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Afghanistan.svg/45px-Flag_of_Afghanistan.svg.png 2x" data-file-width="600" data-file-height="400" />&#160;</span><a href="/wiki/Afghanistan_national_football_team" title="Afghanistan national football team">Afghanistan</a></td>
<td>AFG</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/36/Flag_of_Albania.svg/21px-Flag_of_Albania.svg.png" width="21" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/36/Flag_of_Albania.svg/32px-Flag_of_Albania.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/36/Flag_of_Albania.svg/42px-Flag_of_Albania.svg.png 2x" data-file-width="700" data-file-height="500" />&#160;</span><a href="/wiki/Albania_national_football_team" title="Albania national football team">Albania</a></td>
<td>ALB</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/7/77/Flag_of_Algeria.svg/23px-Flag_of_Algeria.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/7/77/Flag_of_Algeria.svg/35px-Flag_of_Algeria.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/7/77/Flag_of_Algeria.svg/45px-Flag_of_Algeria.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Algeria_national_football_team" title="Algeria national football team">Algeria</a></td>
<td>ALG</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/87/Flag_of_American_Samoa.svg/23px-Flag_of_American_Samoa.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/8/87/Flag_of_American_Samoa.svg/35px-Flag_of_American_Samoa.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/8/87/Flag_of_American_Samoa.svg/46px-Flag_of_American_Samoa.svg.png 2x" data-file-width="1000" data-file-height="500" />&#160;</span><a href="/wiki/American_Samoa_national_association_football_team" title="American Samoa national association football team">American Samoa</a></td>
<td>ASA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Andorra.svg/22px-Flag_of_Andorra.svg.png" width="22" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Andorra.svg/33px-Flag_of_Andorra.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Andorra.svg/43px-Flag_of_Andorra.svg.png 2x" data-file-width="1000" data-file-height="700" />&#160;</span><a href="/wiki/Andorra_national_football_team" title="Andorra national football team">Andorra</a></td>
<td>AND</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Flag_of_Angola.svg/23px-Flag_of_Angola.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Flag_of_Angola.svg/35px-Flag_of_Angola.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Flag_of_Angola.svg/45px-Flag_of_Angola.svg.png 2x" data-file-width="450" data-file-height="300" />&#160;</span><a href="/wiki/Angola_national_football_team" title="Angola national football team">Angola</a></td>
<td>ANG</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Flag_of_Anguilla.svg/23px-Flag_of_Anguilla.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Flag_of_Anguilla.svg/35px-Flag_of_Anguilla.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Flag_of_Anguilla.svg/46px-Flag_of_Anguilla.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Anguilla_national_football_team" title="Anguilla national football team">Anguilla</a></td>
<td>AIA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/89/Flag_of_Antigua_and_Barbuda.svg/23px-Flag_of_Antigua_and_Barbuda.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/8/89/Flag_of_Antigua_and_Barbuda.svg/35px-Flag_of_Antigua_and_Barbuda.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/8/89/Flag_of_Antigua_and_Barbuda.svg/45px-Flag_of_Antigua_and_Barbuda.svg.png 2x" data-file-width="690" data-file-height="460" />&#160;</span><a href="/wiki/Antigua_and_Barbuda_national_football_team" title="Antigua and Barbuda national football team">Antigua and Barbuda</a></td>
<td>ATG</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Flag_of_Argentina.svg/23px-Flag_of_Argentina.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Flag_of_Argentina.svg/35px-Flag_of_Argentina.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Flag_of_Argentina.svg/46px-Flag_of_Argentina.svg.png 2x" data-file-width="800" data-file-height="500" />&#160;</span><a href="/wiki/Argentina_national_football_team" title="Argentina national football team">Argentina</a></td>
<td>ARG</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Flag_of_Armenia.svg/23px-Flag_of_Armenia.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Flag_of_Armenia.svg/35px-Flag_of_Armenia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Flag_of_Armenia.svg/46px-Flag_of_Armenia.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Armenia_national_football_team" title="Armenia national football team">Armenia</a></td>
<td>ARM</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Flag_of_Aruba.svg/23px-Flag_of_Aruba.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Flag_of_Aruba.svg/35px-Flag_of_Aruba.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Flag_of_Aruba.svg/45px-Flag_of_Aruba.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Aruba_national_football_team" title="Aruba national football team">Aruba</a></td>
<td>ARU</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/b/b9/Flag_of_Australia.svg/23px-Flag_of_Australia.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/b/b9/Flag_of_Australia.svg/35px-Flag_of_Australia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/b/b9/Flag_of_Australia.svg/46px-Flag_of_Australia.svg.png 2x" data-file-width="1280" data-file-height="640" />&#160;</span><a href="/wiki/Australia_national_soccer_team" title="Australia national soccer team">Australia</a></td>
<td>AUS</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/41/Flag_of_Austria.svg/23px-Flag_of_Austria.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/41/Flag_of_Austria.svg/35px-Flag_of_Austria.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/41/Flag_of_Austria.svg/45px-Flag_of_Austria.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Austria_national_football_team" title="Austria national football team">Austria</a></td>
<td>AUT</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Flag_of_Azerbaijan.svg/23px-Flag_of_Azerbaijan.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Flag_of_Azerbaijan.svg/35px-Flag_of_Azerbaijan.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Flag_of_Azerbaijan.svg/46px-Flag_of_Azerbaijan.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Azerbaijan_national_football_team" title="Azerbaijan national football team">Azerbaijan</a></td>
<td>AZE</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/93/Flag_of_the_Bahamas.svg/23px-Flag_of_the_Bahamas.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/93/Flag_of_the_Bahamas.svg/35px-Flag_of_the_Bahamas.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/93/Flag_of_the_Bahamas.svg/46px-Flag_of_the_Bahamas.svg.png 2x" data-file-width="600" data-file-height="300" />&#160;</span><a href="/wiki/Bahamas_national_football_team" title="Bahamas national football team">Bahamas</a></td>
<td>BAH</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Flag_of_Bahrain.svg/23px-Flag_of_Bahrain.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Flag_of_Bahrain.svg/35px-Flag_of_Bahrain.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Flag_of_Bahrain.svg/46px-Flag_of_Bahrain.svg.png 2x" data-file-width="1500" data-file-height="900" />&#160;</span><a href="/wiki/Bahrain_national_football_team" title="Bahrain national football team">Bahrain</a></td>
<td>BHR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Flag_of_Bangladesh.svg/23px-Flag_of_Bangladesh.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Flag_of_Bangladesh.svg/35px-Flag_of_Bangladesh.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Flag_of_Bangladesh.svg/46px-Flag_of_Bangladesh.svg.png 2x" data-file-width="500" data-file-height="300" />&#160;</span><a href="/wiki/Bangladesh_national_football_team" title="Bangladesh national football team">Bangladesh</a></td>
<td>BAN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Flag_of_Barbados.svg/23px-Flag_of_Barbados.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Flag_of_Barbados.svg/35px-Flag_of_Barbados.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Flag_of_Barbados.svg/45px-Flag_of_Barbados.svg.png 2x" data-file-width="1500" data-file-height="1000" />&#160;</span><a href="/wiki/Barbados_national_football_team" title="Barbados national football team">Barbados</a></td>
<td>BRB</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/85/Flag_of_Belarus.svg/23px-Flag_of_Belarus.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/8/85/Flag_of_Belarus.svg/35px-Flag_of_Belarus.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/8/85/Flag_of_Belarus.svg/46px-Flag_of_Belarus.svg.png 2x" data-file-width="900" data-file-height="450" />&#160;</span><a href="/wiki/Belarus_national_football_team" title="Belarus national football team">Belarus</a></td>
<td>BLR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_Belgium_%28civil%29.svg/23px-Flag_of_Belgium_%28civil%29.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_Belgium_%28civil%29.svg/35px-Flag_of_Belgium_%28civil%29.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_Belgium_%28civil%29.svg/45px-Flag_of_Belgium_%28civil%29.svg.png 2x" data-file-width="450" data-file-height="300" />&#160;</span><a href="/wiki/Belgium_national_football_team" title="Belgium national football team">Belgium</a></td>
<td>BEL</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Flag_of_Belize.svg/23px-Flag_of_Belize.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Flag_of_Belize.svg/35px-Flag_of_Belize.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Flag_of_Belize.svg/45px-Flag_of_Belize.svg.png 2x" data-file-width="750" data-file-height="500" />&#160;</span><a href="/wiki/Belize_national_football_team" title="Belize national football team">Belize</a></td>
<td>BLZ</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Flag_of_Benin.svg/23px-Flag_of_Benin.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Flag_of_Benin.svg/35px-Flag_of_Benin.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Flag_of_Benin.svg/45px-Flag_of_Benin.svg.png 2x" data-file-width="1500" data-file-height="1000" />&#160;</span><a href="/wiki/Benin_national_football_team" title="Benin national football team">Benin</a></td>
<td>BEN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Flag_of_Bermuda.svg/23px-Flag_of_Bermuda.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Flag_of_Bermuda.svg/35px-Flag_of_Bermuda.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Flag_of_Bermuda.svg/46px-Flag_of_Bermuda.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Bermuda_national_football_team" title="Bermuda national football team">Bermuda</a></td>
<td>BER</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/91/Flag_of_Bhutan.svg/23px-Flag_of_Bhutan.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/91/Flag_of_Bhutan.svg/35px-Flag_of_Bhutan.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/91/Flag_of_Bhutan.svg/45px-Flag_of_Bhutan.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Bhutan_national_football_team" title="Bhutan national football team">Bhutan</a></td>
<td>BHU</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/48/Flag_of_Bolivia.svg/22px-Flag_of_Bolivia.svg.png" width="22" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/48/Flag_of_Bolivia.svg/34px-Flag_of_Bolivia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/48/Flag_of_Bolivia.svg/44px-Flag_of_Bolivia.svg.png 2x" data-file-width="1100" data-file-height="750" />&#160;</span><a href="/wiki/Bolivia_national_football_team" title="Bolivia national football team">Bolivia</a></td>
<td>BOL</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Flag_of_Bosnia_and_Herzegovina.svg/23px-Flag_of_Bosnia_and_Herzegovina.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Flag_of_Bosnia_and_Herzegovina.svg/35px-Flag_of_Bosnia_and_Herzegovina.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Flag_of_Bosnia_and_Herzegovina.svg/46px-Flag_of_Bosnia_and_Herzegovina.svg.png 2x" data-file-width="800" data-file-height="400" />&#160;</span><a href="/wiki/Bosnia_and_Herzegovina_national_football_team" title="Bosnia and Herzegovina national football team">Bosnia and Herzegovina</a></td>
<td>BIH</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_Botswana.svg/23px-Flag_of_Botswana.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_Botswana.svg/35px-Flag_of_Botswana.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_Botswana.svg/45px-Flag_of_Botswana.svg.png 2x" data-file-width="1200" data-file-height="800" />&#160;</span><a href="/wiki/Botswana_national_football_team" title="Botswana national football team">Botswana</a></td>
<td>BOT</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/22px-Flag_of_Brazil.svg.png" width="22" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/33px-Flag_of_Brazil.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/43px-Flag_of_Brazil.svg.png 2x" data-file-width="720" data-file-height="504" />&#160;</span><a href="/wiki/Brazil_national_football_team" title="Brazil national football team">Brazil</a></td>
<td>BRA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/42/Flag_of_the_British_Virgin_Islands.svg/23px-Flag_of_the_British_Virgin_Islands.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/42/Flag_of_the_British_Virgin_Islands.svg/35px-Flag_of_the_British_Virgin_Islands.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/42/Flag_of_the_British_Virgin_Islands.svg/46px-Flag_of_the_British_Virgin_Islands.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/British_Virgin_Islands_national_football_team" title="British Virgin Islands national football team">British Virgin Islands</a></td>
<td>VGB</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Flag_of_Brunei.svg/23px-Flag_of_Brunei.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Flag_of_Brunei.svg/35px-Flag_of_Brunei.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Flag_of_Brunei.svg/46px-Flag_of_Brunei.svg.png 2x" data-file-width="1440" data-file-height="720" />&#160;</span><a href="/wiki/Brunei_national_football_team" title="Brunei national football team">Brunei</a></td>
<td>BRU</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Bulgaria.svg/23px-Flag_of_Bulgaria.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Bulgaria.svg/35px-Flag_of_Bulgaria.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Bulgaria.svg/46px-Flag_of_Bulgaria.svg.png 2x" data-file-width="1000" data-file-height="600" />&#160;</span><a href="/wiki/Bulgaria_national_football_team" title="Bulgaria national football team">Bulgaria</a></td>
<td>BUL</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Burkina_Faso.svg/23px-Flag_of_Burkina_Faso.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Burkina_Faso.svg/35px-Flag_of_Burkina_Faso.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Burkina_Faso.svg/45px-Flag_of_Burkina_Faso.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Burkina_Faso_national_football_team" title="Burkina Faso national football team">Burkina Faso</a></td>
<td>BFA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/5/50/Flag_of_Burundi.svg/23px-Flag_of_Burundi.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/5/50/Flag_of_Burundi.svg/35px-Flag_of_Burundi.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/5/50/Flag_of_Burundi.svg/46px-Flag_of_Burundi.svg.png 2x" data-file-width="500" data-file-height="300" />&#160;</span><a href="/wiki/Burundi_national_football_team" title="Burundi national football team">Burundi</a></td>
<td>BDI</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/83/Flag_of_Cambodia.svg/23px-Flag_of_Cambodia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/8/83/Flag_of_Cambodia.svg/35px-Flag_of_Cambodia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/8/83/Flag_of_Cambodia.svg/46px-Flag_of_Cambodia.svg.png 2x" data-file-width="625" data-file-height="400" />&#160;</span><a href="/wiki/Cambodia_national_football_team" title="Cambodia national football team">Cambodia</a></td>
<td>CAM</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Flag_of_Cameroon.svg/23px-Flag_of_Cameroon.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Flag_of_Cameroon.svg/35px-Flag_of_Cameroon.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Flag_of_Cameroon.svg/45px-Flag_of_Cameroon.svg.png 2x" data-file-width="600" data-file-height="400" />&#160;</span><a href="/wiki/Cameroon_national_football_team" title="Cameroon national football team">Cameroon</a></td>
<td>CMR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/c/cf/Flag_of_Canada.svg/23px-Flag_of_Canada.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/c/cf/Flag_of_Canada.svg/35px-Flag_of_Canada.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/c/cf/Flag_of_Canada.svg/46px-Flag_of_Canada.svg.png 2x" data-file-width="1000" data-file-height="500" />&#160;</span><a href="/wiki/Canada_men%27s_national_soccer_team" title="Canada men's national soccer team">Canada</a></td>
<td>CAN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag_of_Cape_Verde.svg/23px-Flag_of_Cape_Verde.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag_of_Cape_Verde.svg/35px-Flag_of_Cape_Verde.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag_of_Cape_Verde.svg/46px-Flag_of_Cape_Verde.svg.png 2x" data-file-width="510" data-file-height="300" />&#160;</span><a href="/wiki/Cape_Verde_national_football_team" title="Cape Verde national football team">Cape Verde</a></td>
<td>CPV</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_the_Cayman_Islands.svg/23px-Flag_of_the_Cayman_Islands.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_the_Cayman_Islands.svg/35px-Flag_of_the_Cayman_Islands.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_the_Cayman_Islands.svg/46px-Flag_of_the_Cayman_Islands.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Cayman_Islands_national_football_team" title="Cayman Islands national football team">Cayman Islands</a></td>
<td>CAY</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag_of_the_Central_African_Republic.svg/23px-Flag_of_the_Central_African_Republic.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag_of_the_Central_African_Republic.svg/35px-Flag_of_the_Central_African_Republic.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag_of_the_Central_African_Republic.svg/45px-Flag_of_the_Central_African_Republic.svg.png 2x" data-file-width="450" data-file-height="300" />&#160;</span><a href="/wiki/Central_African_Republic_national_football_team" title="Central African Republic national football team">Central African Republic</a></td>
<td>CTA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Flag_of_Chad.svg/23px-Flag_of_Chad.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Flag_of_Chad.svg/35px-Flag_of_Chad.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Flag_of_Chad.svg/45px-Flag_of_Chad.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Chad_national_football_team" title="Chad national football team">Chad</a></td>
<td>CHA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/7/78/Flag_of_Chile.svg/23px-Flag_of_Chile.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/7/78/Flag_of_Chile.svg/35px-Flag_of_Chile.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/7/78/Flag_of_Chile.svg/45px-Flag_of_Chile.svg.png 2x" data-file-width="1500" data-file-height="1000" />&#160;</span><a href="/wiki/Chile_national_football_team" title="Chile national football team">Chile</a></td>
<td>CHI</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_the_People%27s_Republic_of_China.svg/23px-Flag_of_the_People%27s_Republic_of_China.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_the_People%27s_Republic_of_China.svg/35px-Flag_of_the_People%27s_Republic_of_China.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_the_People%27s_Republic_of_China.svg/45px-Flag_of_the_People%27s_Republic_of_China.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/China_national_football_team" title="China national football team">China PR</a></td>
<td>CHN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/14/Flag_of_Chinese_Taipei_for_Olympic_games.svg/23px-Flag_of_Chinese_Taipei_for_Olympic_games.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/14/Flag_of_Chinese_Taipei_for_Olympic_games.svg/35px-Flag_of_Chinese_Taipei_for_Olympic_games.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/14/Flag_of_Chinese_Taipei_for_Olympic_games.svg/45px-Flag_of_Chinese_Taipei_for_Olympic_games.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Chinese_Taipei_national_football_team" title="Chinese Taipei national football team">Chinese Taipei</a></td>
<td>TPE</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Colombia.svg/23px-Flag_of_Colombia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Colombia.svg/35px-Flag_of_Colombia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Colombia.svg/45px-Flag_of_Colombia.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Colombia_national_football_team" title="Colombia national football team">Colombia</a></td>
<td>COL</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/94/Flag_of_the_Comoros.svg/23px-Flag_of_the_Comoros.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/94/Flag_of_the_Comoros.svg/35px-Flag_of_the_Comoros.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/94/Flag_of_the_Comoros.svg/46px-Flag_of_the_Comoros.svg.png 2x" data-file-width="500" data-file-height="300" />&#160;</span><a href="/wiki/Comoros_national_football_team" title="Comoros national football team">Comoros</a></td>
<td>COM</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_the_Republic_of_the_Congo.svg/23px-Flag_of_the_Republic_of_the_Congo.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_the_Republic_of_the_Congo.svg/35px-Flag_of_the_Republic_of_the_Congo.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_the_Republic_of_the_Congo.svg/45px-Flag_of_the_Republic_of_the_Congo.svg.png 2x" data-file-width="600" data-file-height="400" />&#160;</span><a href="/wiki/Congo_national_football_team" title="Congo national football team">Congo</a></td>
<td>CGO</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag_of_the_Democratic_Republic_of_the_Congo.svg/20px-Flag_of_the_Democratic_Republic_of_the_Congo.svg.png" width="20" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag_of_the_Democratic_Republic_of_the_Congo.svg/31px-Flag_of_the_Democratic_Republic_of_the_Congo.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag_of_the_Democratic_Republic_of_the_Congo.svg/40px-Flag_of_the_Democratic_Republic_of_the_Congo.svg.png 2x" data-file-width="800" data-file-height="600" />&#160;</span><a href="/wiki/DR_Congo_national_football_team" title="DR Congo national football team">DR Congo</a></td>
<td>COD</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/35/Flag_of_the_Cook_Islands.svg/23px-Flag_of_the_Cook_Islands.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/35/Flag_of_the_Cook_Islands.svg/35px-Flag_of_the_Cook_Islands.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/35/Flag_of_the_Cook_Islands.svg/46px-Flag_of_the_Cook_Islands.svg.png 2x" data-file-width="600" data-file-height="300" />&#160;</span><a href="/wiki/Cook_Islands_national_football_team" title="Cook Islands national football team">Cook Islands</a></td>
<td>COK</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Flag_of_Costa_Rica.svg/23px-Flag_of_Costa_Rica.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Flag_of_Costa_Rica.svg/35px-Flag_of_Costa_Rica.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Flag_of_Costa_Rica.svg/46px-Flag_of_Costa_Rica.svg.png 2x" data-file-width="1000" data-file-height="600" />&#160;</span><a href="/wiki/Costa_Rica_national_football_team" title="Costa Rica national football team">Costa Rica</a></td>
<td>CRC</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Flag_of_Croatia.svg/23px-Flag_of_Croatia.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Flag_of_Croatia.svg/35px-Flag_of_Croatia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Flag_of_Croatia.svg/46px-Flag_of_Croatia.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Croatia_national_football_team" title="Croatia national football team">Croatia</a></td>
<td>CRO</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Flag_of_Cuba.svg/23px-Flag_of_Cuba.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Flag_of_Cuba.svg/35px-Flag_of_Cuba.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Flag_of_Cuba.svg/46px-Flag_of_Cuba.svg.png 2x" data-file-width="800" data-file-height="400" />&#160;</span><a href="/wiki/Cuba_national_football_team" title="Cuba national football team">Cuba</a></td>
<td>CUB</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Flag_of_Cura%C3%A7ao.svg/23px-Flag_of_Cura%C3%A7ao.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Flag_of_Cura%C3%A7ao.svg/35px-Flag_of_Cura%C3%A7ao.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Flag_of_Cura%C3%A7ao.svg/45px-Flag_of_Cura%C3%A7ao.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Cura%C3%A7ao_national_football_team" title="Curaçao national football team">Curaçao</a></td>
<td>CUW</td>
</tr>
</table>
</td>
<td valign="top">
<table class="wikitable" style="font-size:90%;">
<tr>
<th>Country</th>
<th>Code</th>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Flag_of_Cyprus.svg/23px-Flag_of_Cyprus.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Flag_of_Cyprus.svg/35px-Flag_of_Cyprus.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Flag_of_Cyprus.svg/46px-Flag_of_Cyprus.svg.png 2x" data-file-width="275" data-file-height="180" />&#160;</span><a href="/wiki/Cyprus_national_football_team" title="Cyprus national football team">Cyprus</a></td>
<td>CYP</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_Czech_Republic.svg/23px-Flag_of_the_Czech_Republic.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_Czech_Republic.svg/35px-Flag_of_the_Czech_Republic.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_Czech_Republic.svg/45px-Flag_of_the_Czech_Republic.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Czech_Republic_national_football_team" title="Czech Republic national football team">Czech Republic</a></td>
<td>CZE</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Flag_of_Denmark.svg/20px-Flag_of_Denmark.svg.png" width="20" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Flag_of_Denmark.svg/31px-Flag_of_Denmark.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Flag_of_Denmark.svg/40px-Flag_of_Denmark.svg.png 2x" data-file-width="370" data-file-height="280" />&#160;</span><a href="/wiki/Denmark_national_football_team" title="Denmark national football team">Denmark</a></td>
<td>DEN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/34/Flag_of_Djibouti.svg/23px-Flag_of_Djibouti.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/34/Flag_of_Djibouti.svg/35px-Flag_of_Djibouti.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/34/Flag_of_Djibouti.svg/45px-Flag_of_Djibouti.svg.png 2x" data-file-width="600" data-file-height="400" />&#160;</span><a href="/wiki/Djibouti_national_football_team" title="Djibouti national football team">Djibouti</a></td>
<td>DJI</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Flag_of_Dominica.svg/23px-Flag_of_Dominica.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Flag_of_Dominica.svg/35px-Flag_of_Dominica.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Flag_of_Dominica.svg/46px-Flag_of_Dominica.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Dominica_national_football_team" title="Dominica national football team">Dominica</a></td>
<td>DMA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_the_Dominican_Republic.svg/23px-Flag_of_the_Dominican_Republic.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_the_Dominican_Republic.svg/35px-Flag_of_the_Dominican_Republic.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_the_Dominican_Republic.svg/46px-Flag_of_the_Dominican_Republic.svg.png 2x" data-file-width="1000" data-file-height="625" />&#160;</span><a href="/wiki/Dominican_Republic_national_football_team" title="Dominican Republic national football team">Dominican Republic</a></td>
<td>DOM</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Flag_of_Ecuador.svg/23px-Flag_of_Ecuador.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Flag_of_Ecuador.svg/35px-Flag_of_Ecuador.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Flag_of_Ecuador.svg/45px-Flag_of_Ecuador.svg.png 2x" data-file-width="1440" data-file-height="960" />&#160;</span><a href="/wiki/Ecuador_national_football_team" title="Ecuador national football team">Ecuador</a></td>
<td>ECU</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/23px-Flag_of_Egypt.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/35px-Flag_of_Egypt.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/45px-Flag_of_Egypt.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Egypt_national_football_team" title="Egypt national football team">Egypt</a></td>
<td>EGY</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/34/Flag_of_El_Salvador.svg/23px-Flag_of_El_Salvador.svg.png" width="23" height="13" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/34/Flag_of_El_Salvador.svg/35px-Flag_of_El_Salvador.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/34/Flag_of_El_Salvador.svg/46px-Flag_of_El_Salvador.svg.png 2x" data-file-width="1064" data-file-height="600" />&#160;</span><a href="/wiki/El_Salvador_national_football_team" title="El Salvador national football team">El Salvador</a></td>
<td>SLV</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/b/be/Flag_of_England.svg/23px-Flag_of_England.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/b/be/Flag_of_England.svg/35px-Flag_of_England.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/b/be/Flag_of_England.svg/46px-Flag_of_England.svg.png 2x" data-file-width="800" data-file-height="480" />&#160;</span><a href="/wiki/England_national_football_team" title="England national football team">England</a></td>
<td>ENG</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Equatorial_Guinea.svg/23px-Flag_of_Equatorial_Guinea.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Equatorial_Guinea.svg/35px-Flag_of_Equatorial_Guinea.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Equatorial_Guinea.svg/45px-Flag_of_Equatorial_Guinea.svg.png 2x" data-file-width="1200" data-file-height="800" />&#160;</span><a href="/wiki/Equatorial_Guinea_national_football_team" title="Equatorial Guinea national football team">Equatorial Guinea</a></td>
<td>EQG</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/2/29/Flag_of_Eritrea.svg/23px-Flag_of_Eritrea.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/2/29/Flag_of_Eritrea.svg/35px-Flag_of_Eritrea.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/2/29/Flag_of_Eritrea.svg/46px-Flag_of_Eritrea.svg.png 2x" data-file-width="1000" data-file-height="500" />&#160;</span><a href="/wiki/Eritrea_national_football_team" title="Eritrea national football team">Eritrea</a></td>
<td>ERI</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Flag_of_Estonia.svg/23px-Flag_of_Estonia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Flag_of_Estonia.svg/35px-Flag_of_Estonia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Flag_of_Estonia.svg/46px-Flag_of_Estonia.svg.png 2x" data-file-width="990" data-file-height="630" />&#160;</span><a href="/wiki/Estonia_national_football_team" title="Estonia national football team">Estonia</a></td>
<td>EST</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/7/71/Flag_of_Ethiopia.svg/23px-Flag_of_Ethiopia.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/7/71/Flag_of_Ethiopia.svg/35px-Flag_of_Ethiopia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/7/71/Flag_of_Ethiopia.svg/46px-Flag_of_Ethiopia.svg.png 2x" data-file-width="720" data-file-height="360" />&#160;</span><a href="/wiki/Ethiopia_national_football_team" title="Ethiopia national football team">Ethiopia</a></td>
<td>ETH</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Flag_of_the_Faroe_Islands.svg/21px-Flag_of_the_Faroe_Islands.svg.png" width="21" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Flag_of_the_Faroe_Islands.svg/32px-Flag_of_the_Faroe_Islands.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Flag_of_the_Faroe_Islands.svg/41px-Flag_of_the_Faroe_Islands.svg.png 2x" data-file-width="1100" data-file-height="800" />&#160;</span><a href="/wiki/Faroe_Islands_national_football_team" title="Faroe Islands national football team">Faroe Islands</a></td>
<td>FRO</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Flag_of_Fiji.svg/23px-Flag_of_Fiji.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Flag_of_Fiji.svg/35px-Flag_of_Fiji.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Flag_of_Fiji.svg/46px-Flag_of_Fiji.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Fiji_national_football_team" title="Fiji national football team">Fiji</a></td>
<td>FIJ</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Finland.svg/23px-Flag_of_Finland.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Finland.svg/35px-Flag_of_Finland.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Finland.svg/46px-Flag_of_Finland.svg.png 2x" data-file-width="1800" data-file-height="1100" />&#160;</span><a href="/wiki/Finland_national_football_team" title="Finland national football team">Finland</a></td>
<td>FIN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/c/c3/Flag_of_France.svg/23px-Flag_of_France.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/c/c3/Flag_of_France.svg/35px-Flag_of_France.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/c/c3/Flag_of_France.svg/45px-Flag_of_France.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/France_national_football_team" title="France national football team">France</a></td>
<td>FRA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/04/Flag_of_Gabon.svg/20px-Flag_of_Gabon.svg.png" width="20" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/04/Flag_of_Gabon.svg/31px-Flag_of_Gabon.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/04/Flag_of_Gabon.svg/40px-Flag_of_Gabon.svg.png 2x" data-file-width="400" data-file-height="300" />&#160;</span><a href="/wiki/Gabon_national_football_team" title="Gabon national football team">Gabon</a></td>
<td>GAB</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/7/77/Flag_of_The_Gambia.svg/23px-Flag_of_The_Gambia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/7/77/Flag_of_The_Gambia.svg/35px-Flag_of_The_Gambia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/7/77/Flag_of_The_Gambia.svg/45px-Flag_of_The_Gambia.svg.png 2x" data-file-width="600" data-file-height="400" />&#160;</span><a href="/wiki/Gambia_national_football_team" title="Gambia national football team">Gambia</a></td>
<td>GAM</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_Georgia.svg/23px-Flag_of_Georgia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_Georgia.svg/35px-Flag_of_Georgia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_Georgia.svg/45px-Flag_of_Georgia.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Georgia_national_football_team" title="Georgia national football team">Georgia</a></td>
<td>GEO</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/b/ba/Flag_of_Germany.svg/23px-Flag_of_Germany.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/b/ba/Flag_of_Germany.svg/35px-Flag_of_Germany.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/b/ba/Flag_of_Germany.svg/46px-Flag_of_Germany.svg.png 2x" data-file-width="1000" data-file-height="600" />&#160;</span><a href="/wiki/Germany_national_football_team" title="Germany national football team">Germany</a></td>
<td>GER</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Ghana.svg/23px-Flag_of_Ghana.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Ghana.svg/35px-Flag_of_Ghana.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Ghana.svg/45px-Flag_of_Ghana.svg.png 2x" data-file-width="450" data-file-height="300" />&#160;</span><a href="/wiki/Ghana_national_football_team" title="Ghana national football team">Ghana</a></td>
<td>GHA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Greece.svg/23px-Flag_of_Greece.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Greece.svg/35px-Flag_of_Greece.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Greece.svg/45px-Flag_of_Greece.svg.png 2x" data-file-width="600" data-file-height="400" />&#160;</span><a href="/wiki/Greece_national_football_team" title="Greece national football team">Greece</a></td>
<td>GRE</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Grenada.svg/23px-Flag_of_Grenada.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Grenada.svg/35px-Flag_of_Grenada.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Grenada.svg/46px-Flag_of_Grenada.svg.png 2x" data-file-width="600" data-file-height="360" />&#160;</span><a href="/wiki/Grenada_national_football_team" title="Grenada national football team">Grenada</a></td>
<td>GRN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/07/Flag_of_Guam.svg/23px-Flag_of_Guam.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/07/Flag_of_Guam.svg/35px-Flag_of_Guam.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/07/Flag_of_Guam.svg/46px-Flag_of_Guam.svg.png 2x" data-file-width="820" data-file-height="440" />&#160;</span><a href="/wiki/Guam_national_football_team" title="Guam national football team">Guam</a></td>
<td>GUM</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Flag_of_Guatemala.svg/23px-Flag_of_Guatemala.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Flag_of_Guatemala.svg/35px-Flag_of_Guatemala.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Flag_of_Guatemala.svg/46px-Flag_of_Guatemala.svg.png 2x" data-file-width="960" data-file-height="600" />&#160;</span><a href="/wiki/Guatemala_national_football_team" title="Guatemala national football team">Guatemala</a></td>
<td>GUA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Flag_of_Guinea.svg/23px-Flag_of_Guinea.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Flag_of_Guinea.svg/35px-Flag_of_Guinea.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Flag_of_Guinea.svg/45px-Flag_of_Guinea.svg.png 2x" data-file-width="450" data-file-height="300" />&#160;</span><a href="/wiki/Guinea_national_football_team" title="Guinea national football team">Guinea</a></td>
<td>GUI</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/01/Flag_of_Guinea-Bissau.svg/23px-Flag_of_Guinea-Bissau.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/01/Flag_of_Guinea-Bissau.svg/35px-Flag_of_Guinea-Bissau.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/01/Flag_of_Guinea-Bissau.svg/46px-Flag_of_Guinea-Bissau.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Guinea-Bissau_national_football_team" title="Guinea-Bissau national football team">Guinea-Bissau</a></td>
<td>GNB</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/99/Flag_of_Guyana.svg/23px-Flag_of_Guyana.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/99/Flag_of_Guyana.svg/35px-Flag_of_Guyana.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/99/Flag_of_Guyana.svg/46px-Flag_of_Guyana.svg.png 2x" data-file-width="500" data-file-height="300" />&#160;</span><a href="/wiki/Guyana_national_football_team" title="Guyana national football team">Guyana</a></td>
<td>GUY</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/5/56/Flag_of_Haiti.svg/23px-Flag_of_Haiti.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/5/56/Flag_of_Haiti.svg/35px-Flag_of_Haiti.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/5/56/Flag_of_Haiti.svg/46px-Flag_of_Haiti.svg.png 2x" data-file-width="500" data-file-height="300" />&#160;</span><a href="/wiki/Haiti_national_football_team" title="Haiti national football team">Haiti</a></td>
<td>HAI</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/82/Flag_of_Honduras.svg/23px-Flag_of_Honduras.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/8/82/Flag_of_Honduras.svg/35px-Flag_of_Honduras.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/8/82/Flag_of_Honduras.svg/46px-Flag_of_Honduras.svg.png 2x" data-file-width="1000" data-file-height="500" />&#160;</span><a href="/wiki/Honduras_national_football_team" title="Honduras national football team">Honduras</a></td>
<td>HON</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Flag_of_Hong_Kong.svg/23px-Flag_of_Hong_Kong.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Flag_of_Hong_Kong.svg/35px-Flag_of_Hong_Kong.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Flag_of_Hong_Kong.svg/45px-Flag_of_Hong_Kong.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Hong_Kong_national_football_team" title="Hong Kong national football team">Hong Kong</a></td>
<td>HKG</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Flag_of_Hungary.svg/23px-Flag_of_Hungary.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Flag_of_Hungary.svg/35px-Flag_of_Hungary.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Flag_of_Hungary.svg/46px-Flag_of_Hungary.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Hungary_national_football_team" title="Hungary national football team">Hungary</a></td>
<td>HUN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Flag_of_Iceland.svg/21px-Flag_of_Iceland.svg.png" width="21" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Flag_of_Iceland.svg/32px-Flag_of_Iceland.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Flag_of_Iceland.svg/42px-Flag_of_Iceland.svg.png 2x" data-file-width="2500" data-file-height="1800" />&#160;</span><a href="/wiki/Iceland_national_football_team" title="Iceland national football team">Iceland</a></td>
<td>ISL</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/23px-Flag_of_India.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/35px-Flag_of_India.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/45px-Flag_of_India.svg.png 2x" data-file-width="1350" data-file-height="900" />&#160;</span><a href="/wiki/India_national_football_team" title="India national football team">India</a></td>
<td>IND</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_Indonesia.svg/23px-Flag_of_Indonesia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_Indonesia.svg/35px-Flag_of_Indonesia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_Indonesia.svg/45px-Flag_of_Indonesia.svg.png 2x" data-file-width="1200" data-file-height="800" />&#160;</span><a href="/wiki/Indonesia_national_football_team" title="Indonesia national football team">Indonesia</a></td>
<td>IDN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Flag_of_Iran.svg/23px-Flag_of_Iran.svg.png" width="23" height="13" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Flag_of_Iran.svg/35px-Flag_of_Iran.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Flag_of_Iran.svg/46px-Flag_of_Iran.svg.png 2x" data-file-width="630" data-file-height="360" />&#160;</span><a href="/wiki/Iran_national_football_team" title="Iran national football team">Iran</a></td>
<td>IRN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Flag_of_Iraq.svg/23px-Flag_of_Iraq.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Flag_of_Iraq.svg/35px-Flag_of_Iraq.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Flag_of_Iraq.svg/45px-Flag_of_Iraq.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Iraq_national_football_team" title="Iraq national football team">Iraq</a></td>
<td>IRQ</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Flag_of_Israel.svg/21px-Flag_of_Israel.svg.png" width="21" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Flag_of_Israel.svg/32px-Flag_of_Israel.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Flag_of_Israel.svg/41px-Flag_of_Israel.svg.png 2x" data-file-width="660" data-file-height="480" />&#160;</span><a href="/wiki/Israel_national_football_team" title="Israel national football team">Israel</a></td>
<td>ISR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/23px-Flag_of_Italy.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/35px-Flag_of_Italy.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/45px-Flag_of_Italy.svg.png 2x" data-file-width="1500" data-file-height="1000" />&#160;</span><a href="/wiki/Italy_national_football_team" title="Italy national football team">Italy</a></td>
<td>ITA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_C%C3%B4te_d%27Ivoire.svg/23px-Flag_of_C%C3%B4te_d%27Ivoire.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_C%C3%B4te_d%27Ivoire.svg/35px-Flag_of_C%C3%B4te_d%27Ivoire.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_C%C3%B4te_d%27Ivoire.svg/45px-Flag_of_C%C3%B4te_d%27Ivoire.svg.png 2x" data-file-width="450" data-file-height="300" />&#160;</span><a href="/wiki/Ivory_Coast_national_football_team" title="Ivory Coast national football team">Ivory Coast</a></td>
<td>CIV</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Flag_of_Jamaica.svg/23px-Flag_of_Jamaica.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Flag_of_Jamaica.svg/35px-Flag_of_Jamaica.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Flag_of_Jamaica.svg/46px-Flag_of_Jamaica.svg.png 2x" data-file-width="600" data-file-height="300" />&#160;</span><a href="/wiki/Jamaica_national_football_team" title="Jamaica national football team">Jamaica</a></td>
<td>JAM</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/9/9e/Flag_of_Japan.svg/23px-Flag_of_Japan.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/9/9e/Flag_of_Japan.svg/35px-Flag_of_Japan.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/9/9e/Flag_of_Japan.svg/45px-Flag_of_Japan.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Japan_national_football_team" title="Japan national football team">Japan</a></td>
<td>JPN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Flag_of_Jordan.svg/23px-Flag_of_Jordan.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Flag_of_Jordan.svg/35px-Flag_of_Jordan.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Flag_of_Jordan.svg/46px-Flag_of_Jordan.svg.png 2x" data-file-width="840" data-file-height="420" />&#160;</span><a href="/wiki/Jordan_national_football_team" title="Jordan national football team">Jordan</a></td>
<td>JOR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Flag_of_Kazakhstan.svg/23px-Flag_of_Kazakhstan.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Flag_of_Kazakhstan.svg/35px-Flag_of_Kazakhstan.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Flag_of_Kazakhstan.svg/46px-Flag_of_Kazakhstan.svg.png 2x" data-file-width="600" data-file-height="300" />&#160;</span><a href="/wiki/Kazakhstan_national_football_team" title="Kazakhstan national football team">Kazakhstan</a></td>
<td>KAZ</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/49/Flag_of_Kenya.svg/23px-Flag_of_Kenya.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/49/Flag_of_Kenya.svg/35px-Flag_of_Kenya.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/49/Flag_of_Kenya.svg/45px-Flag_of_Kenya.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Kenya_national_football_team" title="Kenya national football team">Kenya</a></td>
<td>KEN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Flag_of_Kuwait.svg/23px-Flag_of_Kuwait.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Flag_of_Kuwait.svg/35px-Flag_of_Kuwait.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Flag_of_Kuwait.svg/46px-Flag_of_Kuwait.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Kuwait_national_football_team" title="Kuwait national football team">Kuwait</a></td>
<td>KUW</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Flag_of_Kyrgyzstan.svg/23px-Flag_of_Kyrgyzstan.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Flag_of_Kyrgyzstan.svg/35px-Flag_of_Kyrgyzstan.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Flag_of_Kyrgyzstan.svg/46px-Flag_of_Kyrgyzstan.svg.png 2x" data-file-width="750" data-file-height="450" />&#160;</span><a href="/wiki/Kyrgyzstan_national_football_team" title="Kyrgyzstan national football team">Kyrgyzstan</a></td>
<td>KGZ</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/5/56/Flag_of_Laos.svg/23px-Flag_of_Laos.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/5/56/Flag_of_Laos.svg/35px-Flag_of_Laos.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/5/56/Flag_of_Laos.svg/45px-Flag_of_Laos.svg.png 2x" data-file-width="600" data-file-height="400" />&#160;</span><a href="/wiki/Laos_national_football_team" title="Laos national football team">Laos</a></td>
<td>LAO</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/84/Flag_of_Latvia.svg/23px-Flag_of_Latvia.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/8/84/Flag_of_Latvia.svg/35px-Flag_of_Latvia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/8/84/Flag_of_Latvia.svg/46px-Flag_of_Latvia.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Latvia_national_football_team" title="Latvia national football team">Latvia</a></td>
<td>LVA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/5/59/Flag_of_Lebanon.svg/23px-Flag_of_Lebanon.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/5/59/Flag_of_Lebanon.svg/35px-Flag_of_Lebanon.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/5/59/Flag_of_Lebanon.svg/45px-Flag_of_Lebanon.svg.png 2x" data-file-width="750" data-file-height="500" />&#160;</span><a href="/wiki/Lebanon_national_football_team" title="Lebanon national football team">Lebanon</a></td>
<td>LIB</td>
</tr>
</table>
</td>
<td valign="top">
<table class="wikitable" style="font-size:90%;">
<tr>
<th>Country</th>
<th>Code</th>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Flag_of_Lesotho.svg/23px-Flag_of_Lesotho.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Flag_of_Lesotho.svg/35px-Flag_of_Lesotho.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Flag_of_Lesotho.svg/45px-Flag_of_Lesotho.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Lesotho_national_football_team" title="Lesotho national football team">Lesotho</a></td>
<td>LES</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Flag_of_Liberia.svg/23px-Flag_of_Liberia.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Flag_of_Liberia.svg/35px-Flag_of_Liberia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Flag_of_Liberia.svg/46px-Flag_of_Liberia.svg.png 2x" data-file-width="1140" data-file-height="600" />&#160;</span><a href="/wiki/Liberia_national_football_team" title="Liberia national football team">Liberia</a></td>
<td>LBR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Libya.svg/23px-Flag_of_Libya.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Libya.svg/35px-Flag_of_Libya.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Libya.svg/46px-Flag_of_Libya.svg.png 2x" data-file-width="1000" data-file-height="500" />&#160;</span><a href="/wiki/Libya_national_football_team" title="Libya national football team">Libya</a></td>
<td>LBY</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/47/Flag_of_Liechtenstein.svg/23px-Flag_of_Liechtenstein.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/47/Flag_of_Liechtenstein.svg/35px-Flag_of_Liechtenstein.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/47/Flag_of_Liechtenstein.svg/46px-Flag_of_Liechtenstein.svg.png 2x" data-file-width="1000" data-file-height="600" />&#160;</span><a href="/wiki/Liechtenstein_national_football_team" title="Liechtenstein national football team">Liechtenstein</a></td>
<td>LIE</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/11/Flag_of_Lithuania.svg/23px-Flag_of_Lithuania.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/11/Flag_of_Lithuania.svg/35px-Flag_of_Lithuania.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/11/Flag_of_Lithuania.svg/46px-Flag_of_Lithuania.svg.png 2x" data-file-width="1000" data-file-height="600" />&#160;</span><a href="/wiki/Lithuania_national_football_team" title="Lithuania national football team">Lithuania</a></td>
<td>LTU</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/da/Flag_of_Luxembourg.svg/23px-Flag_of_Luxembourg.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/d/da/Flag_of_Luxembourg.svg/35px-Flag_of_Luxembourg.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/d/da/Flag_of_Luxembourg.svg/46px-Flag_of_Luxembourg.svg.png 2x" data-file-width="1000" data-file-height="600" />&#160;</span><a href="/wiki/Luxembourg_national_football_team" title="Luxembourg national football team">Luxembourg</a></td>
<td>LUX</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/63/Flag_of_Macau.svg/23px-Flag_of_Macau.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/63/Flag_of_Macau.svg/35px-Flag_of_Macau.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/63/Flag_of_Macau.svg/45px-Flag_of_Macau.svg.png 2x" data-file-width="660" data-file-height="440" />&#160;</span><a href="/wiki/Macau_national_football_team" title="Macau national football team">Macau</a></td>
<td>MAC</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Flag_of_Macedonia.svg/23px-Flag_of_Macedonia.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Flag_of_Macedonia.svg/35px-Flag_of_Macedonia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Flag_of_Macedonia.svg/46px-Flag_of_Macedonia.svg.png 2x" data-file-width="1400" data-file-height="700" />&#160;</span><a href="/wiki/Macedonia_national_football_team" title="Macedonia national football team">Macedonia</a></td>
<td>MKD</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Madagascar.svg/23px-Flag_of_Madagascar.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Madagascar.svg/35px-Flag_of_Madagascar.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Madagascar.svg/45px-Flag_of_Madagascar.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Madagascar_national_football_team" title="Madagascar national football team">Madagascar</a></td>
<td>MAD</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Flag_of_Malawi.svg/23px-Flag_of_Malawi.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Flag_of_Malawi.svg/35px-Flag_of_Malawi.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Flag_of_Malawi.svg/45px-Flag_of_Malawi.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Malawi_national_football_team" title="Malawi national football team">Malawi</a></td>
<td>MWI</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/66/Flag_of_Malaysia.svg/23px-Flag_of_Malaysia.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/66/Flag_of_Malaysia.svg/35px-Flag_of_Malaysia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/66/Flag_of_Malaysia.svg/46px-Flag_of_Malaysia.svg.png 2x" data-file-width="2800" data-file-height="1400" />&#160;</span><a href="/wiki/Malaysia_national_football_team" title="Malaysia national football team">Malaysia</a></td>
<td>MAS</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_Maldives.svg/23px-Flag_of_Maldives.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_Maldives.svg/35px-Flag_of_Maldives.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_Maldives.svg/45px-Flag_of_Maldives.svg.png 2x" data-file-width="720" data-file-height="480" />&#160;</span><a href="/wiki/Maldives_national_football_team" title="Maldives national football team">Maldives</a></td>
<td>MDV</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_Mali.svg/23px-Flag_of_Mali.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_Mali.svg/35px-Flag_of_Mali.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_Mali.svg/45px-Flag_of_Mali.svg.png 2x" data-file-width="450" data-file-height="300" />&#160;</span><a href="/wiki/Mali_national_football_team" title="Mali national football team">Mali</a></td>
<td>MLI</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flag_of_Malta.svg/23px-Flag_of_Malta.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flag_of_Malta.svg/35px-Flag_of_Malta.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flag_of_Malta.svg/45px-Flag_of_Malta.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Malta_national_football_team" title="Malta national football team">Malta</a></td>
<td>MLT</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/43/Flag_of_Mauritania.svg/23px-Flag_of_Mauritania.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/43/Flag_of_Mauritania.svg/35px-Flag_of_Mauritania.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/43/Flag_of_Mauritania.svg/45px-Flag_of_Mauritania.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Mauritania_national_football_team" title="Mauritania national football team">Mauritania</a></td>
<td>MTN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/7/77/Flag_of_Mauritius.svg/23px-Flag_of_Mauritius.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/7/77/Flag_of_Mauritius.svg/35px-Flag_of_Mauritius.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/7/77/Flag_of_Mauritius.svg/45px-Flag_of_Mauritius.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Mauritius_national_football_team" title="Mauritius national football team">Mauritius</a></td>
<td>MRI</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Flag_of_Mexico.svg/23px-Flag_of_Mexico.svg.png" width="23" height="13" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Flag_of_Mexico.svg/35px-Flag_of_Mexico.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Flag_of_Mexico.svg/46px-Flag_of_Mexico.svg.png 2x" data-file-width="840" data-file-height="480" />&#160;</span><a href="/wiki/Mexico_national_football_team" title="Mexico national football team">Mexico</a></td>
<td>MEX</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/2/27/Flag_of_Moldova.svg/23px-Flag_of_Moldova.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/2/27/Flag_of_Moldova.svg/35px-Flag_of_Moldova.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/2/27/Flag_of_Moldova.svg/46px-Flag_of_Moldova.svg.png 2x" data-file-width="1800" data-file-height="900" />&#160;</span><a href="/wiki/Moldova_national_football_team" title="Moldova national football team">Moldova</a></td>
<td>MDA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Flag_of_Mongolia.svg/23px-Flag_of_Mongolia.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Flag_of_Mongolia.svg/35px-Flag_of_Mongolia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Flag_of_Mongolia.svg/46px-Flag_of_Mongolia.svg.png 2x" data-file-width="4800" data-file-height="2400" />&#160;</span><a href="/wiki/Mongolia_national_football_team" title="Mongolia national football team">Mongolia</a></td>
<td>MNG</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/64/Flag_of_Montenegro.svg/23px-Flag_of_Montenegro.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/64/Flag_of_Montenegro.svg/35px-Flag_of_Montenegro.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/64/Flag_of_Montenegro.svg/46px-Flag_of_Montenegro.svg.png 2x" data-file-width="640" data-file-height="320" />&#160;</span><a href="/wiki/Montenegro_national_football_team" title="Montenegro national football team">Montenegro</a></td>
<td>MNE</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Montserrat.svg/23px-Flag_of_Montserrat.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Montserrat.svg/35px-Flag_of_Montserrat.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Montserrat.svg/46px-Flag_of_Montserrat.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Montserrat_national_football_team" title="Montserrat national football team">Montserrat</a></td>
<td>MSR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Flag_of_Morocco.svg/23px-Flag_of_Morocco.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Flag_of_Morocco.svg/35px-Flag_of_Morocco.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Flag_of_Morocco.svg/45px-Flag_of_Morocco.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Morocco_national_football_team" title="Morocco national football team">Morocco</a></td>
<td>MAR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Mozambique.svg/23px-Flag_of_Mozambique.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Mozambique.svg/35px-Flag_of_Mozambique.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Mozambique.svg/45px-Flag_of_Mozambique.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Mozambique_national_football_team" title="Mozambique national football team">Mozambique</a></td>
<td>MOZ</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Flag_of_Myanmar.svg/23px-Flag_of_Myanmar.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Flag_of_Myanmar.svg/35px-Flag_of_Myanmar.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Flag_of_Myanmar.svg/45px-Flag_of_Myanmar.svg.png 2x" data-file-width="1800" data-file-height="1200" />&#160;</span><a href="/wiki/Myanmar_national_football_team" title="Myanmar national football team">Myanmar</a></td>
<td>MYA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/00/Flag_of_Namibia.svg/23px-Flag_of_Namibia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/00/Flag_of_Namibia.svg/35px-Flag_of_Namibia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/00/Flag_of_Namibia.svg/45px-Flag_of_Namibia.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Namibia_national_football_team" title="Namibia national football team">Namibia</a></td>
<td>NAM</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Flag_of_Nepal.svg/16px-Flag_of_Nepal.svg.png" width="16" height="20" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Flag_of_Nepal.svg/25px-Flag_of_Nepal.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Flag_of_Nepal.svg/33px-Flag_of_Nepal.svg.png 2x" data-file-width="726" data-file-height="885" />&#160;&#160;&#160;</span><a href="/wiki/Nepal_national_football_team" title="Nepal national football team">Nepal</a></td>
<td>NEP</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/2/20/Flag_of_the_Netherlands.svg/23px-Flag_of_the_Netherlands.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/2/20/Flag_of_the_Netherlands.svg/35px-Flag_of_the_Netherlands.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/2/20/Flag_of_the_Netherlands.svg/45px-Flag_of_the_Netherlands.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Netherlands_national_football_team" title="Netherlands national football team">Netherlands</a></td>
<td>NED</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/2/23/Flag_of_New_Caledonia.svg/23px-Flag_of_New_Caledonia.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/2/23/Flag_of_New_Caledonia.svg/35px-Flag_of_New_Caledonia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/2/23/Flag_of_New_Caledonia.svg/46px-Flag_of_New_Caledonia.svg.png 2x" data-file-width="900" data-file-height="450" />&#160;</span><a href="/wiki/New_Caledonia_national_football_team" title="New Caledonia national football team">New Caledonia</a></td>
<td>NCL</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Flag_of_New_Zealand.svg/23px-Flag_of_New_Zealand.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Flag_of_New_Zealand.svg/35px-Flag_of_New_Zealand.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Flag_of_New_Zealand.svg/46px-Flag_of_New_Zealand.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/New_Zealand_national_football_team" title="New Zealand national football team">New Zealand</a></td>
<td>NZL</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Nicaragua.svg/23px-Flag_of_Nicaragua.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Nicaragua.svg/35px-Flag_of_Nicaragua.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Nicaragua.svg/46px-Flag_of_Nicaragua.svg.png 2x" data-file-width="1000" data-file-height="600" />&#160;</span><a href="/wiki/Nicaragua_national_football_team" title="Nicaragua national football team">Nicaragua</a></td>
<td>NCA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/f4/Flag_of_Niger.svg/18px-Flag_of_Niger.svg.png" width="18" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/f4/Flag_of_Niger.svg/27px-Flag_of_Niger.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/f4/Flag_of_Niger.svg/35px-Flag_of_Niger.svg.png 2x" data-file-width="700" data-file-height="600" />&#160;</span><a href="/wiki/Niger_national_football_team" title="Niger national football team">Niger</a></td>
<td>NIG</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/7/79/Flag_of_Nigeria.svg/23px-Flag_of_Nigeria.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/7/79/Flag_of_Nigeria.svg/35px-Flag_of_Nigeria.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/7/79/Flag_of_Nigeria.svg/46px-Flag_of_Nigeria.svg.png 2x" data-file-width="2400" data-file-height="1200" />&#160;</span><a href="/wiki/Nigeria_national_football_team" title="Nigeria national football team">Nigeria</a></td>
<td>NGA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/5/51/Flag_of_North_Korea.svg/23px-Flag_of_North_Korea.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/5/51/Flag_of_North_Korea.svg/35px-Flag_of_North_Korea.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/5/51/Flag_of_North_Korea.svg/46px-Flag_of_North_Korea.svg.png 2x" data-file-width="1600" data-file-height="800" />&#160;</span><a href="/wiki/North_Korea_national_football_team" title="North Korea national football team">North Korea</a></td>
<td>PRK</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/88/Ulster_banner.svg/23px-Ulster_banner.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/8/88/Ulster_banner.svg/35px-Ulster_banner.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/8/88/Ulster_banner.svg/46px-Ulster_banner.svg.png 2x" data-file-width="600" data-file-height="300" />&#160;</span><a href="/wiki/Northern_Ireland_national_football_team" title="Northern Ireland national football team">Northern Ireland</a></td>
<td>NIR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Flag_of_Norway.svg/21px-Flag_of_Norway.svg.png" width="21" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Flag_of_Norway.svg/32px-Flag_of_Norway.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Flag_of_Norway.svg/41px-Flag_of_Norway.svg.png 2x" data-file-width="1100" data-file-height="800" />&#160;</span><a href="/wiki/Norway_national_football_team" title="Norway national football team">Norway</a></td>
<td>NOR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Flag_of_Oman.svg/23px-Flag_of_Oman.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Flag_of_Oman.svg/35px-Flag_of_Oman.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Flag_of_Oman.svg/46px-Flag_of_Oman.svg.png 2x" data-file-width="600" data-file-height="300" />&#160;</span><a href="/wiki/Oman_national_football_team" title="Oman national football team">Oman</a></td>
<td>OMA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/32/Flag_of_Pakistan.svg/23px-Flag_of_Pakistan.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/32/Flag_of_Pakistan.svg/35px-Flag_of_Pakistan.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/32/Flag_of_Pakistan.svg/45px-Flag_of_Pakistan.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Pakistan_national_football_team" title="Pakistan national football team">Pakistan</a></td>
<td>PAK</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/00/Flag_of_Palestine.svg/23px-Flag_of_Palestine.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/00/Flag_of_Palestine.svg/35px-Flag_of_Palestine.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/00/Flag_of_Palestine.svg/46px-Flag_of_Palestine.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Palestine_national_football_team" title="Palestine national football team">Palestine</a></td>
<td>PLE</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Flag_of_Panama.svg/23px-Flag_of_Panama.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Flag_of_Panama.svg/35px-Flag_of_Panama.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Flag_of_Panama.svg/45px-Flag_of_Panama.svg.png 2x" data-file-width="450" data-file-height="300" />&#160;</span><a href="/wiki/Panama_national_football_team" title="Panama national football team">Panama</a></td>
<td>PAN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Flag_of_Papua_New_Guinea.svg/20px-Flag_of_Papua_New_Guinea.svg.png" width="20" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Flag_of_Papua_New_Guinea.svg/31px-Flag_of_Papua_New_Guinea.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Flag_of_Papua_New_Guinea.svg/40px-Flag_of_Papua_New_Guinea.svg.png 2x" data-file-width="600" data-file-height="450" />&#160;</span><a href="/wiki/Papua_New_Guinea_national_football_team" title="Papua New Guinea national football team">Papua New Guinea</a></td>
<td>PNG</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/2/27/Flag_of_Paraguay.svg/23px-Flag_of_Paraguay.svg.png" width="23" height="13" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/2/27/Flag_of_Paraguay.svg/35px-Flag_of_Paraguay.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/2/27/Flag_of_Paraguay.svg/46px-Flag_of_Paraguay.svg.png 2x" data-file-width="600" data-file-height="330" />&#160;</span><a href="/wiki/Paraguay_national_football_team" title="Paraguay national football team">Paraguay</a></td>
<td>PAR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Flag_of_Peru.svg/23px-Flag_of_Peru.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Flag_of_Peru.svg/35px-Flag_of_Peru.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Flag_of_Peru.svg/45px-Flag_of_Peru.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Peru_national_football_team" title="Peru national football team">Peru</a></td>
<td>PER</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/99/Flag_of_the_Philippines.svg/23px-Flag_of_the_Philippines.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/99/Flag_of_the_Philippines.svg/35px-Flag_of_the_Philippines.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/99/Flag_of_the_Philippines.svg/46px-Flag_of_the_Philippines.svg.png 2x" data-file-width="900" data-file-height="450" />&#160;</span><a href="/wiki/Philippines_national_football_team" title="Philippines national football team">Philippines</a></td>
<td>PHI</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/1/12/Flag_of_Poland.svg/23px-Flag_of_Poland.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/1/12/Flag_of_Poland.svg/35px-Flag_of_Poland.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/1/12/Flag_of_Poland.svg/46px-Flag_of_Poland.svg.png 2x" data-file-width="1280" data-file-height="800" />&#160;</span><a href="/wiki/Poland_national_football_team" title="Poland national football team">Poland</a></td>
<td>POL</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Portugal.svg/23px-Flag_of_Portugal.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Portugal.svg/35px-Flag_of_Portugal.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Portugal.svg/45px-Flag_of_Portugal.svg.png 2x" data-file-width="600" data-file-height="400" />&#160;</span><a href="/wiki/Portugal_national_football_team" title="Portugal national football team">Portugal</a></td>
<td>POR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/2/28/Flag_of_Puerto_Rico.svg/23px-Flag_of_Puerto_Rico.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/2/28/Flag_of_Puerto_Rico.svg/35px-Flag_of_Puerto_Rico.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/2/28/Flag_of_Puerto_Rico.svg/45px-Flag_of_Puerto_Rico.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Puerto_Rico_national_football_team" title="Puerto Rico national football team">Puerto Rico</a></td>
<td>PUR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/65/Flag_of_Qatar.svg/23px-Flag_of_Qatar.svg.png" width="23" height="9" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/65/Flag_of_Qatar.svg/35px-Flag_of_Qatar.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/65/Flag_of_Qatar.svg/46px-Flag_of_Qatar.svg.png 2x" data-file-width="1400" data-file-height="550" />&#160;</span><a href="/wiki/Qatar_national_football_team" title="Qatar national football team">Qatar</a></td>
<td>QAT</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/45/Flag_of_Ireland.svg/23px-Flag_of_Ireland.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/45/Flag_of_Ireland.svg/35px-Flag_of_Ireland.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/45/Flag_of_Ireland.svg/46px-Flag_of_Ireland.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Republic_of_Ireland_national_football_team" title="Republic of Ireland national football team">Republic of Ireland</a></td>
<td>IRL</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flag_of_Romania.svg/23px-Flag_of_Romania.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flag_of_Romania.svg/35px-Flag_of_Romania.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flag_of_Romania.svg/45px-Flag_of_Romania.svg.png 2x" data-file-width="600" data-file-height="400" />&#160;</span><a href="/wiki/Romania_national_football_team" title="Romania national football team">Romania</a></td>
<td>ROU</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/f/f3/Flag_of_Russia.svg/23px-Flag_of_Russia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/f/f3/Flag_of_Russia.svg/35px-Flag_of_Russia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/f/f3/Flag_of_Russia.svg/45px-Flag_of_Russia.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Russia_national_football_team" title="Russia national football team">Russia</a></td>
<td>RUS</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/17/Flag_of_Rwanda.svg/23px-Flag_of_Rwanda.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/17/Flag_of_Rwanda.svg/35px-Flag_of_Rwanda.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/17/Flag_of_Rwanda.svg/45px-Flag_of_Rwanda.svg.png 2x" data-file-width="1080" data-file-height="720" />&#160;</span><a href="/wiki/Rwanda_national_football_team" title="Rwanda national football team">Rwanda</a></td>
<td>RWA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Saint_Kitts_and_Nevis.svg/23px-Flag_of_Saint_Kitts_and_Nevis.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Saint_Kitts_and_Nevis.svg/35px-Flag_of_Saint_Kitts_and_Nevis.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Saint_Kitts_and_Nevis.svg/45px-Flag_of_Saint_Kitts_and_Nevis.svg.png 2x" data-file-width="750" data-file-height="500" />&#160;</span><a href="/wiki/Saint_Kitts_and_Nevis_national_football_team" title="Saint Kitts and Nevis national football team">Saint Kitts and Nevis</a></td>
<td>SKN</td>
</tr>
</table>
</td>
<td valign="top">
<table class="wikitable" style="font-size:90%;">
<tr>
<th>Country</th>
<th>Code</th>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_Saint_Lucia.svg/23px-Flag_of_Saint_Lucia.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_Saint_Lucia.svg/35px-Flag_of_Saint_Lucia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_Saint_Lucia.svg/46px-Flag_of_Saint_Lucia.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Saint_Lucia_national_football_team" title="Saint Lucia national football team">Saint Lucia</a></td>
<td>LCA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Flag_of_Saint_Vincent_and_the_Grenadines.svg/23px-Flag_of_Saint_Vincent_and_the_Grenadines.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Flag_of_Saint_Vincent_and_the_Grenadines.svg/35px-Flag_of_Saint_Vincent_and_the_Grenadines.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Flag_of_Saint_Vincent_and_the_Grenadines.svg/45px-Flag_of_Saint_Vincent_and_the_Grenadines.svg.png 2x" data-file-width="450" data-file-height="300" />&#160;</span><a href="/wiki/Saint_Vincent_and_the_Grenadines_national_football_team" title="Saint Vincent and the Grenadines national football team">Saint Vincent and the Grenadines</a></td>
<td>VIN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Samoa.svg/23px-Flag_of_Samoa.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Samoa.svg/35px-Flag_of_Samoa.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Samoa.svg/46px-Flag_of_Samoa.svg.png 2x" data-file-width="2880" data-file-height="1440" />&#160;</span><a href="/wiki/Samoa_national_association_football_team" title="Samoa national association football team" class="mw-redirect">Samoa</a></td>
<td>SAM</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Flag_of_San_Marino.svg/20px-Flag_of_San_Marino.svg.png" width="20" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Flag_of_San_Marino.svg/31px-Flag_of_San_Marino.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Flag_of_San_Marino.svg/40px-Flag_of_San_Marino.svg.png 2x" data-file-width="1600" data-file-height="1200" />&#160;</span><a href="/wiki/San_Marino_national_football_team" title="San Marino national football team">San Marino</a></td>
<td>SMR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Flag_of_Sao_Tome_and_Principe.svg/23px-Flag_of_Sao_Tome_and_Principe.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Flag_of_Sao_Tome_and_Principe.svg/35px-Flag_of_Sao_Tome_and_Principe.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Flag_of_Sao_Tome_and_Principe.svg/46px-Flag_of_Sao_Tome_and_Principe.svg.png 2x" data-file-width="2800" data-file-height="1400" />&#160;</span><a href="/wiki/S%C3%A3o_Tom%C3%A9_and_Pr%C3%ADncipe_national_football_team" title="São Tomé and Príncipe national football team">São Tomé and Príncipe</a></td>
<td>STP</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Flag_of_Saudi_Arabia.svg/23px-Flag_of_Saudi_Arabia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Flag_of_Saudi_Arabia.svg/35px-Flag_of_Saudi_Arabia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Flag_of_Saudi_Arabia.svg/45px-Flag_of_Saudi_Arabia.svg.png 2x" data-file-width="750" data-file-height="500" />&#160;</span><a href="/wiki/Saudi_Arabia_national_football_team" title="Saudi Arabia national football team">Saudi Arabia</a></td>
<td>KSA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/10/Flag_of_Scotland.svg/23px-Flag_of_Scotland.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/10/Flag_of_Scotland.svg/35px-Flag_of_Scotland.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/10/Flag_of_Scotland.svg/46px-Flag_of_Scotland.svg.png 2x" data-file-width="1000" data-file-height="600" />&#160;</span><a href="/wiki/Scotland_national_football_team" title="Scotland national football team">Scotland</a></td>
<td>SCO</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Flag_of_Senegal.svg/23px-Flag_of_Senegal.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Flag_of_Senegal.svg/35px-Flag_of_Senegal.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Flag_of_Senegal.svg/45px-Flag_of_Senegal.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Senegal_national_football_team" title="Senegal national football team">Senegal</a></td>
<td>SEN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Flag_of_Serbia.svg/23px-Flag_of_Serbia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Flag_of_Serbia.svg/35px-Flag_of_Serbia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Flag_of_Serbia.svg/45px-Flag_of_Serbia.svg.png 2x" data-file-width="1350" data-file-height="900" />&#160;</span><a href="/wiki/Serbia_national_football_team" title="Serbia national football team">Serbia</a></td>
<td>SRB</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Flag_of_Seychelles.svg/23px-Flag_of_Seychelles.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Flag_of_Seychelles.svg/35px-Flag_of_Seychelles.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Flag_of_Seychelles.svg/46px-Flag_of_Seychelles.svg.png 2x" data-file-width="900" data-file-height="450" />&#160;</span><a href="/wiki/Seychelles_national_football_team" title="Seychelles national football team">Seychelles</a></td>
<td>SEY</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/17/Flag_of_Sierra_Leone.svg/23px-Flag_of_Sierra_Leone.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/17/Flag_of_Sierra_Leone.svg/35px-Flag_of_Sierra_Leone.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/17/Flag_of_Sierra_Leone.svg/45px-Flag_of_Sierra_Leone.svg.png 2x" data-file-width="450" data-file-height="300" />&#160;</span><a href="/wiki/Sierra_Leone_national_football_team" title="Sierra Leone national football team">Sierra Leone</a></td>
<td>SLE</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/48/Flag_of_Singapore.svg/23px-Flag_of_Singapore.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/48/Flag_of_Singapore.svg/35px-Flag_of_Singapore.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/48/Flag_of_Singapore.svg/45px-Flag_of_Singapore.svg.png 2x" data-file-width="4320" data-file-height="2880" />&#160;</span><a href="/wiki/Singapore_national_football_team" title="Singapore national football team">Singapore</a></td>
<td>SIN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Flag_of_Slovakia.svg/23px-Flag_of_Slovakia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Flag_of_Slovakia.svg/35px-Flag_of_Slovakia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Flag_of_Slovakia.svg/45px-Flag_of_Slovakia.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Slovakia_national_football_team" title="Slovakia national football team">Slovakia</a></td>
<td>SVK</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Flag_of_Slovenia.svg/23px-Flag_of_Slovenia.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Flag_of_Slovenia.svg/35px-Flag_of_Slovenia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Flag_of_Slovenia.svg/46px-Flag_of_Slovenia.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Slovenia_national_football_team" title="Slovenia national football team">Slovenia</a></td>
<td>SVN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/7/74/Flag_of_the_Solomon_Islands.svg/23px-Flag_of_the_Solomon_Islands.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/7/74/Flag_of_the_Solomon_Islands.svg/35px-Flag_of_the_Solomon_Islands.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/7/74/Flag_of_the_Solomon_Islands.svg/46px-Flag_of_the_Solomon_Islands.svg.png 2x" data-file-width="800" data-file-height="400" />&#160;</span><a href="/wiki/Solomon_Islands_national_football_team" title="Solomon Islands national football team">Solomon Islands</a></td>
<td>SOL</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Flag_of_Somalia.svg/23px-Flag_of_Somalia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Flag_of_Somalia.svg/35px-Flag_of_Somalia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Flag_of_Somalia.svg/45px-Flag_of_Somalia.svg.png 2x" data-file-width="1200" data-file-height="800" />&#160;</span><a href="/wiki/Somalia_national_football_team" title="Somalia national football team">Somalia</a></td>
<td>SOM</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/a/af/Flag_of_South_Africa.svg/23px-Flag_of_South_Africa.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/a/af/Flag_of_South_Africa.svg/35px-Flag_of_South_Africa.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/a/af/Flag_of_South_Africa.svg/45px-Flag_of_South_Africa.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/South_Africa_national_football_team" title="South Africa national football team">South Africa</a></td>
<td>RSA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/09/Flag_of_South_Korea.svg/23px-Flag_of_South_Korea.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/09/Flag_of_South_Korea.svg/35px-Flag_of_South_Korea.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/09/Flag_of_South_Korea.svg/45px-Flag_of_South_Korea.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/South_Korea_national_football_team" title="South Korea national football team">South Korea</a></td>
<td>KOR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Flag_of_South_Sudan.svg/23px-Flag_of_South_Sudan.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Flag_of_South_Sudan.svg/35px-Flag_of_South_Sudan.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Flag_of_South_Sudan.svg/46px-Flag_of_South_Sudan.svg.png 2x" data-file-width="1000" data-file-height="500" />&#160;</span><a href="/wiki/South_Sudan_national_football_team" title="South Sudan national football team">South Sudan</a></td>
<td>SSD</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/9/9a/Flag_of_Spain.svg/23px-Flag_of_Spain.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/9/9a/Flag_of_Spain.svg/35px-Flag_of_Spain.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/9/9a/Flag_of_Spain.svg/45px-Flag_of_Spain.svg.png 2x" data-file-width="750" data-file-height="500" />&#160;</span><a href="/wiki/Spain_national_football_team" title="Spain national football team">Spain</a></td>
<td>ESP</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/11/Flag_of_Sri_Lanka.svg/23px-Flag_of_Sri_Lanka.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/11/Flag_of_Sri_Lanka.svg/35px-Flag_of_Sri_Lanka.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/11/Flag_of_Sri_Lanka.svg/46px-Flag_of_Sri_Lanka.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Sri_Lanka_national_football_team" title="Sri Lanka national football team">Sri Lanka</a></td>
<td>SRI</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/01/Flag_of_Sudan.svg/23px-Flag_of_Sudan.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/01/Flag_of_Sudan.svg/35px-Flag_of_Sudan.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/01/Flag_of_Sudan.svg/46px-Flag_of_Sudan.svg.png 2x" data-file-width="600" data-file-height="300" />&#160;</span><a href="/wiki/Sudan_national_football_team" title="Sudan national football team">Sudan</a></td>
<td>SDN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/60/Flag_of_Suriname.svg/23px-Flag_of_Suriname.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/60/Flag_of_Suriname.svg/35px-Flag_of_Suriname.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/60/Flag_of_Suriname.svg/45px-Flag_of_Suriname.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Suriname_national_football_team" title="Suriname national football team">Suriname</a></td>
<td>SUR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Flag_of_Swaziland.svg/23px-Flag_of_Swaziland.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Flag_of_Swaziland.svg/35px-Flag_of_Swaziland.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Flag_of_Swaziland.svg/45px-Flag_of_Swaziland.svg.png 2x" data-file-width="600" data-file-height="400" />&#160;</span><a href="/wiki/Swaziland_national_football_team" title="Swaziland national football team">Swaziland</a></td>
<td>SWZ</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/4/4c/Flag_of_Sweden.svg/23px-Flag_of_Sweden.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/4/4c/Flag_of_Sweden.svg/35px-Flag_of_Sweden.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/4/4c/Flag_of_Sweden.svg/46px-Flag_of_Sweden.svg.png 2x" data-file-width="1600" data-file-height="1000" />&#160;</span><a href="/wiki/Sweden_national_football_team" title="Sweden national football team">Sweden</a></td>
<td>SWE</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Flag_of_Switzerland.svg/16px-Flag_of_Switzerland.svg.png" width="16" height="16" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Flag_of_Switzerland.svg/24px-Flag_of_Switzerland.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Flag_of_Switzerland.svg/32px-Flag_of_Switzerland.svg.png 2x" data-file-width="1000" data-file-height="1000" />&#160;&#160;</span><a href="/wiki/Switzerland_national_football_team" title="Switzerland national football team">Switzerland</a></td>
<td>SUI</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/5/53/Flag_of_Syria.svg/23px-Flag_of_Syria.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/5/53/Flag_of_Syria.svg/35px-Flag_of_Syria.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/5/53/Flag_of_Syria.svg/45px-Flag_of_Syria.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Syria_national_football_team" title="Syria national football team">Syria</a></td>
<td>SYR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/db/Flag_of_French_Polynesia.svg/23px-Flag_of_French_Polynesia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/d/db/Flag_of_French_Polynesia.svg/35px-Flag_of_French_Polynesia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/d/db/Flag_of_French_Polynesia.svg/45px-Flag_of_French_Polynesia.svg.png 2x" data-file-width="600" data-file-height="400" />&#160;</span><a href="/wiki/Tahiti_national_football_team" title="Tahiti national football team">Tahiti</a></td>
<td>TAH</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Tajikistan.svg/23px-Flag_of_Tajikistan.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Tajikistan.svg/35px-Flag_of_Tajikistan.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Tajikistan.svg/46px-Flag_of_Tajikistan.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Tajikistan_national_football_team" title="Tajikistan national football team">Tajikistan</a></td>
<td>TJK</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag_of_Tanzania.svg/23px-Flag_of_Tanzania.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag_of_Tanzania.svg/35px-Flag_of_Tanzania.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag_of_Tanzania.svg/45px-Flag_of_Tanzania.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Tanzania_national_football_team" title="Tanzania national football team">Tanzania</a></td>
<td>TAN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Flag_of_Thailand.svg/23px-Flag_of_Thailand.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Flag_of_Thailand.svg/35px-Flag_of_Thailand.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Flag_of_Thailand.svg/45px-Flag_of_Thailand.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Thailand_national_football_team" title="Thailand national football team">Thailand</a></td>
<td>THA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/2/26/Flag_of_East_Timor.svg/23px-Flag_of_East_Timor.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/2/26/Flag_of_East_Timor.svg/35px-Flag_of_East_Timor.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/2/26/Flag_of_East_Timor.svg/46px-Flag_of_East_Timor.svg.png 2x" data-file-width="900" data-file-height="450" />&#160;</span><a href="/wiki/Timor-Leste_national_football_team" title="Timor-Leste national football team">Timor-Leste</a></td>
<td>TLS</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/68/Flag_of_Togo.svg/23px-Flag_of_Togo.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/68/Flag_of_Togo.svg/35px-Flag_of_Togo.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/68/Flag_of_Togo.svg/46px-Flag_of_Togo.svg.png 2x" data-file-width="809" data-file-height="500" />&#160;</span><a href="/wiki/Togo_national_football_team" title="Togo national football team">Togo</a></td>
<td>TOG</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Tonga.svg/23px-Flag_of_Tonga.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Tonga.svg/35px-Flag_of_Tonga.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Tonga.svg/46px-Flag_of_Tonga.svg.png 2x" data-file-width="960" data-file-height="480" />&#160;</span><a href="/wiki/Tonga_national_football_team" title="Tonga national football team">Tonga</a></td>
<td>TGA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/64/Flag_of_Trinidad_and_Tobago.svg/23px-Flag_of_Trinidad_and_Tobago.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/64/Flag_of_Trinidad_and_Tobago.svg/35px-Flag_of_Trinidad_and_Tobago.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/64/Flag_of_Trinidad_and_Tobago.svg/46px-Flag_of_Trinidad_and_Tobago.svg.png 2x" data-file-width="800" data-file-height="480" />&#160;</span><a href="/wiki/Trinidad_and_Tobago_national_football_team" title="Trinidad and Tobago national football team">Trinidad and Tobago</a></td>
<td>TRI</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Flag_of_Tunisia.svg/23px-Flag_of_Tunisia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Flag_of_Tunisia.svg/35px-Flag_of_Tunisia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Flag_of_Tunisia.svg/45px-Flag_of_Tunisia.svg.png 2x" data-file-width="1200" data-file-height="800" />&#160;</span><a href="/wiki/Tunisia_national_football_team" title="Tunisia national football team">Tunisia</a></td>
<td>TUN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Flag_of_Turkey.svg/23px-Flag_of_Turkey.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Flag_of_Turkey.svg/35px-Flag_of_Turkey.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Flag_of_Turkey.svg/45px-Flag_of_Turkey.svg.png 2x" data-file-width="1200" data-file-height="800" />&#160;</span><a href="/wiki/Turkey_national_football_team" title="Turkey national football team">Turkey</a></td>
<td>TUR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Flag_of_Turkmenistan.svg/23px-Flag_of_Turkmenistan.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Flag_of_Turkmenistan.svg/35px-Flag_of_Turkmenistan.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Flag_of_Turkmenistan.svg/45px-Flag_of_Turkmenistan.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Turkmenistan_national_football_team" title="Turkmenistan national football team">Turkmenistan</a></td>
<td>TKM</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Flag_of_the_Turks_and_Caicos_Islands.svg/23px-Flag_of_the_Turks_and_Caicos_Islands.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Flag_of_the_Turks_and_Caicos_Islands.svg/35px-Flag_of_the_Turks_and_Caicos_Islands.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Flag_of_the_Turks_and_Caicos_Islands.svg/46px-Flag_of_the_Turks_and_Caicos_Islands.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Turks_and_Caicos_Islands_national_football_team" title="Turks and Caicos Islands national football team">Turks and Caicos Islands</a></td>
<td>TCA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Flag_of_Uganda.svg/23px-Flag_of_Uganda.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Flag_of_Uganda.svg/35px-Flag_of_Uganda.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Flag_of_Uganda.svg/45px-Flag_of_Uganda.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Uganda_national_football_team" title="Uganda national football team">Uganda</a></td>
<td>UGA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/49/Flag_of_Ukraine.svg/23px-Flag_of_Ukraine.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/49/Flag_of_Ukraine.svg/35px-Flag_of_Ukraine.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/49/Flag_of_Ukraine.svg/45px-Flag_of_Ukraine.svg.png 2x" data-file-width="1200" data-file-height="800" />&#160;</span><a href="/wiki/Ukraine_national_football_team" title="Ukraine national football team">Ukraine</a></td>
<td>UKR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_United_Arab_Emirates.svg/23px-Flag_of_the_United_Arab_Emirates.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_United_Arab_Emirates.svg/35px-Flag_of_the_United_Arab_Emirates.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_United_Arab_Emirates.svg/46px-Flag_of_the_United_Arab_Emirates.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/United_Arab_Emirates_national_football_team" title="United Arab Emirates national football team">United Arab Emirates</a></td>
<td>UAE</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/23px-Flag_of_the_United_States.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/35px-Flag_of_the_United_States.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/46px-Flag_of_the_United_States.svg.png 2x" data-file-width="1235" data-file-height="650" />&#160;</span><a href="/wiki/United_States_men%27s_national_soccer_team" title="United States men's national soccer team">United States</a></td>
<td>USA</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Uruguay.svg/23px-Flag_of_Uruguay.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Uruguay.svg/35px-Flag_of_Uruguay.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Uruguay.svg/45px-Flag_of_Uruguay.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Uruguay_national_football_team" title="Uruguay national football team">Uruguay</a></td>
<td>URU</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Flag_of_the_United_States_Virgin_Islands.svg/23px-Flag_of_the_United_States_Virgin_Islands.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Flag_of_the_United_States_Virgin_Islands.svg/35px-Flag_of_the_United_States_Virgin_Islands.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Flag_of_the_United_States_Virgin_Islands.svg/45px-Flag_of_the_United_States_Virgin_Islands.svg.png 2x" data-file-width="750" data-file-height="500" />&#160;</span><a href="/wiki/United_States_Virgin_Islands_national_soccer_team" title="United States Virgin Islands national soccer team">U.S. Virgin Islands</a></td>
<td>VIR</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/84/Flag_of_Uzbekistan.svg/23px-Flag_of_Uzbekistan.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/8/84/Flag_of_Uzbekistan.svg/35px-Flag_of_Uzbekistan.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/8/84/Flag_of_Uzbekistan.svg/46px-Flag_of_Uzbekistan.svg.png 2x" data-file-width="500" data-file-height="250" />&#160;</span><a href="/wiki/Uzbekistan_national_football_team" title="Uzbekistan national football team">Uzbekistan</a></td>
<td>UZB</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Vanuatu.svg/23px-Flag_of_Vanuatu.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Vanuatu.svg/35px-Flag_of_Vanuatu.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Vanuatu.svg/46px-Flag_of_Vanuatu.svg.png 2x" data-file-width="600" data-file-height="360" />&#160;</span><a href="/wiki/Vanuatu_national_football_team" title="Vanuatu national football team">Vanuatu</a></td>
<td>VAN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/06/Flag_of_Venezuela.svg/23px-Flag_of_Venezuela.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/06/Flag_of_Venezuela.svg/35px-Flag_of_Venezuela.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/06/Flag_of_Venezuela.svg/45px-Flag_of_Venezuela.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Venezuela_national_football_team" title="Venezuela national football team">Venezuela</a></td>
<td>VEN</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/23px-Flag_of_Vietnam.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/35px-Flag_of_Vietnam.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/45px-Flag_of_Vietnam.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Vietnam_national_football_team" title="Vietnam national football team">Vietnam</a></td>
<td>VIE</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/5/59/Flag_of_Wales_2.svg/23px-Flag_of_Wales_2.svg.png" width="23" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/5/59/Flag_of_Wales_2.svg/35px-Flag_of_Wales_2.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/5/59/Flag_of_Wales_2.svg/46px-Flag_of_Wales_2.svg.png 2x" data-file-width="830" data-file-height="498" />&#160;</span><a href="/wiki/Wales_national_football_team" title="Wales national football team">Wales</a></td>
<td>WAL</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/89/Flag_of_Yemen.svg/23px-Flag_of_Yemen.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/8/89/Flag_of_Yemen.svg/35px-Flag_of_Yemen.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/8/89/Flag_of_Yemen.svg/45px-Flag_of_Yemen.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Yemen_national_football_team" title="Yemen national football team">Yemen</a></td>
<td>YEM</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/06/Flag_of_Zambia.svg/23px-Flag_of_Zambia.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/06/Flag_of_Zambia.svg/35px-Flag_of_Zambia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/06/Flag_of_Zambia.svg/45px-Flag_of_Zambia.svg.png 2x" data-file-width="2100" data-file-height="1400" />&#160;</span><a href="/wiki/Zambia_national_football_team" title="Zambia national football team">Zambia</a></td>
<td>ZAM</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Flag_of_Zimbabwe.svg/23px-Flag_of_Zimbabwe.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Flag_of_Zimbabwe.svg/35px-Flag_of_Zimbabwe.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Flag_of_Zimbabwe.svg/46px-Flag_of_Zimbabwe.svg.png 2x" data-file-width="1008" data-file-height="504" />&#160;</span><a href="/wiki/Zimbabwe_national_football_team" title="Zimbabwe national football team">Zimbabwe</a></td>
<td>ZIM</td>
</tr>
</table>
</td>
</tr>
</table>
<table class="wikitable" style="font-size:90%;">
<tr>
<th>Country</th>
<th>Code</th>
<th>Confederation</th>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Flag_of_Bonaire.svg/23px-Flag_of_Bonaire.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Flag_of_Bonaire.svg/35px-Flag_of_Bonaire.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Flag_of_Bonaire.svg/45px-Flag_of_Bonaire.svg.png 2x" data-file-width="600" data-file-height="400" />&#160;</span><a href="/wiki/Bonaire_national_football_team" title="Bonaire national football team">Bonaire</a></td>
<td>BOE</td>
<td><a href="/wiki/CONCACAF" title="CONCACAF">CONCACAF</a></td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/2/29/Flag_of_French_Guiana.svg/23px-Flag_of_French_Guiana.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/2/29/Flag_of_French_Guiana.svg/35px-Flag_of_French_Guiana.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/2/29/Flag_of_French_Guiana.svg/45px-Flag_of_French_Guiana.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/French_Guiana_national_football_team" title="French Guiana national football team">French Guiana</a></td>
<td>GYF</td>
<td><a href="/wiki/CONCACAF" title="CONCACAF">CONCACAF</a></td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/02/Flag_of_Gibraltar.svg/23px-Flag_of_Gibraltar.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/02/Flag_of_Gibraltar.svg/35px-Flag_of_Gibraltar.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/02/Flag_of_Gibraltar.svg/46px-Flag_of_Gibraltar.svg.png 2x" data-file-width="1000" data-file-height="500" />&#160;</span><a href="/wiki/Gibraltar_national_football_team" title="Gibraltar national football team">Gibraltar</a></td>
<td>GIB</td>
<td><a href="/wiki/UEFA" title="UEFA">UEFA</a></td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/a/ae/Flag_of_the_United_Kingdom.svg/23px-Flag_of_the_United_Kingdom.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/a/ae/Flag_of_the_United_Kingdom.svg/35px-Flag_of_the_United_Kingdom.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/a/ae/Flag_of_the_United_Kingdom.svg/46px-Flag_of_the_United_Kingdom.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Great_Britain_national_football_team" title="Great Britain national football team" class="mw-redirect">Great Britain</a></td>
<td>GBR</td>
<td>N/A</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/04/Flag_of_Guadeloupe_%28local%29.svg/23px-Flag_of_Guadeloupe_%28local%29.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/04/Flag_of_Guadeloupe_%28local%29.svg/35px-Flag_of_Guadeloupe_%28local%29.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/04/Flag_of_Guadeloupe_%28local%29.svg/45px-Flag_of_Guadeloupe_%28local%29.svg.png 2x" data-file-width="600" data-file-height="400" />&#160;</span><a href="/wiki/Guadeloupe_national_football_team" title="Guadeloupe national football team">Guadeloupe</a></td>
<td>GPE</td>
<td>CONCACAF</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Flag_of_Kosovo.svg/21px-Flag_of_Kosovo.svg.png" width="21" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Flag_of_Kosovo.svg/32px-Flag_of_Kosovo.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Flag_of_Kosovo.svg/42px-Flag_of_Kosovo.svg.png 2x" data-file-width="840" data-file-height="600" />&#160;</span><a href="/wiki/Kosovo_national_football_team" title="Kosovo national football team">Kosovo</a></td>
<td>KOS</td>
<td>N/A</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/5/52/Flag_of_Martinique.svg/23px-Flag_of_Martinique.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/5/52/Flag_of_Martinique.svg/35px-Flag_of_Martinique.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/5/52/Flag_of_Martinique.svg/45px-Flag_of_Martinique.svg.png 2x" data-file-width="750" data-file-height="500" />&#160;</span><a href="/wiki/Martinique_national_football_team" title="Martinique national football team">Martinique</a></td>
<td>MTQ</td>
<td>CONCACAF</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/en/thumb/c/c3/Flag_of_France.svg/23px-Flag_of_France.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/en/thumb/c/c3/Flag_of_France.svg/35px-Flag_of_France.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/c/c3/Flag_of_France.svg/45px-Flag_of_France.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/R%C3%A9union_national_football_team" title="Réunion national football team">Réunion</a></td>
<td>REU</td>
<td><a href="/wiki/Confederation_of_African_Football" title="Confederation of African Football">CAF</a></td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Flag_of_Sint_Maarten.svg/23px-Flag_of_Sint_Maarten.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Flag_of_Sint_Maarten.svg/35px-Flag_of_Sint_Maarten.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Flag_of_Sint_Maarten.svg/45px-Flag_of_Sint_Maarten.svg.png 2x" data-file-width="675" data-file-height="450" />&#160;</span><a href="/wiki/Sint_Maarten_national_football_team" title="Sint Maarten national football team">Sint Maarten</a></td>
<td>SXM</td>
<td>CONCACAF</td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag_of_Tuvalu.svg/23px-Flag_of_Tuvalu.svg.png" width="23" height="12" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag_of_Tuvalu.svg/35px-Flag_of_Tuvalu.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag_of_Tuvalu.svg/46px-Flag_of_Tuvalu.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;</span><a href="/wiki/Tuvalu_national_football_team" title="Tuvalu national football team">Tuvalu</a></td>
<td>TUV</td>
<td><a href="/wiki/Oceania_Football_Confederation" title="Oceania Football Confederation">OFC</a></td>
</tr>
<tr>
<td><span class="flagicon"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Flag_of_Zanzibar.svg/23px-Flag_of_Zanzibar.svg.png" width="23" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Flag_of_Zanzibar.svg/35px-Flag_of_Zanzibar.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Flag_of_Zanzibar.svg/45px-Flag_of_Zanzibar.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;</span><a href="/wiki/Zanzibar_national_football_team" title="Zanzibar national football team">Zanzibar</a></td>
<td>ZAN</td>
<td>CAF</td>
</tr>
</table>
</td>
</tr>
</table>
