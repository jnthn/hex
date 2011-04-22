package Hex::AggregateRoot::Game;

use Moose;

extends 'Hex::AggregateRoot';

use Hex::Event::StonePlaced;

sub lookup {
    my ($self) = @_;

    return {
        'Hex::Event::GameStarted' => \&apply_game_started,
        'Hex::Event::StonePlaced' => \&apply_stone_placed,
    };
}

sub apply_game_started {
    my ($self) = @_;
}

sub apply_stone_placed {
    my ($self) = @_;
}

sub place_stone {
    my ($self, $cell) = @_;

    $self->apply_event(Hex::Event::StonePlaced->new(
        Cell => $cell,
    ));
}

1;
