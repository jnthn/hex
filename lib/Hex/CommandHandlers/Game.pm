package Hex::CommandHandlers::Game;

use Moose;

use Hex::EventAggregator;
use Hex::Command::PlaceStone;

has 'repository' => (
    is => 'ro',
    isa => 'Repository',
    required => 1,
);

sub setup {
    my ($repository) = @_;

    my $ch = Hex::CommandHandlers::Game->new(repository => $repository);

    Hex::EventAggregator->subscribe(
        'Hex::Command::PlaceStone' => sub { $ch->handle_place_stone($_[0]) }
    );

    return;
}

sub handle_place_stone {
    my ($self, $command) = @_;

    my $game = $self->repository->get_by_id($command->GameID);
    die "Move out of turn"
        if $game->player_on_turn ne $command->PlayerHandle;
    
    die "Piece outside of board"
        unless piece_is_within_board($command->Cell(), $game->board_size());
    
    die "Cell is already occupied"
        if cell_is_taken($command->Cell(), $game->board());
    
    $game->place_stone($command->PlayerHandle, $command->Cell);
    $self->repository->save($game);
}

sub piece_is_within_board {
    my ($target, $board_size) = @_;
    if ($target =~ /^([A-Z])(\d+)$/) {
        return 0 if ord($1) - ord('A') + 1 > $board_size;
        return 0 if     $2                 > $board_size;
        return 1;
    }
    return 0;
}

sub cell_is_taken {
    my ($target, $board) = @_;
    $target =~ /^([A-Z])(\d+)$/;
    return defined($board->[ord($1) - ord('A')]->[$2 - 1]);
}

1;
