package Hex::AggregateRoot::Game;

use Hex::Event::StonePlaced;

use Moose;

extends 'Hex::AggregateRoot';

has 'id' => (
    is  => 'rw',
    isa => 'Int',
);

has 'player_on_turn' => (
    is  => 'rw',
    isa => 'Str',
);

has 'board_size' => (
    is => 'rw',
    isa => 'Int'
);

sub lookup {
    my ($self) = @_;

    return {
        'Hex::Event::GameStarted' => \&apply_game_started,
        'Hex::Event::StonePlaced' => \&apply_stone_placed,
    };
}

sub apply_game_started {
    my ($self, $event) = @_;

    $self->id($event->GameID);
    $self->board_size($event->Size);
    $self->player_on_turn($event->FirstPlayerHandle);
}

sub apply_stone_placed {
    my ($self) = @_;
}

sub place_stone {
    my ($self, $player_handle, $cell) = @_;

    $self->apply_event(Hex::Event::StonePlaced->new(
        GameID       => $self->id,
        PlayerHandle => $player_handle,
        Cell         => $cell,
    ));
}

1;
