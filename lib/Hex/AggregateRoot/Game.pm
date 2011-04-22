package Hex::AggregateRoot::Game;

use Moose;

extends 'Hex::AggregateRoot';

use Hex::Event::StonePlaced;

sub lookup {
    my ($self) = @_;

    return {
        'Hex::Event::GameStarted' => \&apply_game_started,
    };
}

sub apply_game_started {
    my ($self) = @_;
}

sub place_stone {
    my ($self) = @_;

    $self->apply_event(Hex::Event::StonePlaced->new());
}

1;
