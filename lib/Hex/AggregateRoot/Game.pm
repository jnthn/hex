package Hex::AggregateRoot::Game;

use Moose;

extends 'Hex::AggregateRoot';

sub lookup {
    my ($self) = @_;

    return {
        'Hex::Event::GameStarted' => \&startGame,
    };
}

sub startGame {
    my ($self) = @_;

    die "OH HAI!";
}

1;
