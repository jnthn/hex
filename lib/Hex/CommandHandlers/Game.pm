package Hex::CommandHandlers::Game;

use Moose;

use Hex::EventAggregator;
use Hex::Command::PlaceStone;

has 'repository' => (
    is => 'ro',
    isa => 'Hex::Repository',
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
    $game->place_stone($game, $command->Cell);
}

1;
