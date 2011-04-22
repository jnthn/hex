package Hex::AggregateRoot::Game;

use Moose;

extends 'Hex::AggregateRoot';

sub lookup {
    my ($self) = @_;

    return {
        'Hex::Event::GameStarted' => \&apply_game_started,
    };
}

sub apply_game_started {
    my ($self) = @_;
}

1;
