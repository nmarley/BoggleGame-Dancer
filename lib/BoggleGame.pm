package BoggleGame;

use Dancer;
use Dancer::Plugin::Ajax;
use Boggle;
use Data::Dumper;
use JSON;

our $VERSION = '0.1';

get '/' => sub {
    my $game = Boggle->new();

    if ( session('words') ) {
        session words => '';
    }

    template 'index', { faces => \@{$game->faces} };
};


# word list stored as arrayref in session
ajax '/addword/:word' => sub {
    my $words;

    if ( session('words') ) {
        $words = session('words');
    }

    my @new_words = split /\s+/, param 'word';

    for my $new_word ( @new_words ) {
        # trim input
        $new_word =~ s/^\s+|\s+$//g;
        next unless ($new_word);

        unless ( $new_word ~~ @$words ) {
            push @$words, $new_word;
        }
    }

    session 'words' => $words;

    return encode_json( $words );
};

true;

