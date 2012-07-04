package BoggleGame;

use Dancer;
use Boggle;
use Data::Dumper;

our $VERSION = '0.1';

get '/' => sub {
    my $game = Boggle->new();
    template 'index', { faces => \@{$game->faces} };
};

true;

