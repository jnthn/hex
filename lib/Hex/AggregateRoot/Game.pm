package Hex::AggregateRoot::Game;

use Hex::Event::StonePlaced;

use Moose;

extends 'Hex::AggregateRoot';

has 'id' => (
    is  => 'rw',
    isa => 'Int',
);

has 'player_black' => (
    is  => 'rw',
    isa => 'Str',
);

has 'player_white' => (
    is  => 'rw',
    isa => 'Str',
);

has 'player_on_turn' => (
    is  => 'rw',
    isa => 'Str',
);

has 'board' => (
    is => 'rw'
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
    $self->player_black($event->FirstPlayerHandle);
    $self->player_on_turn($event->FirstPlayerHandle);
    $self->player_white($event->SecondPlayerHandle);
    
    my @board = map { [] } 1..$event->Size;
    $self->board(\@board);
}

sub apply_stone_placed {
    my ($self, $event) = @_;
    
    my $board = $self->board();
    $event->Cell =~ /^([A-Z])(\d+)$/;
    $board->[ord($1) - ord('A')]->[$2 - 1] = $self->player_on_turn();
    
    $self->player_on_turn(
        $self->player_on_turn() eq $self->player_black() ?
            $self->player_white() :
            $self->player_black());
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
