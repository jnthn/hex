package Hex::CommandHandlers::Game;

use Hex::EventAggregator;
use Hex::Command::PlaceStone;

has 'repository' => (
    is => 'ro',
    isa => 'Hex::Repository',
    required => 1,
);

Hex::EventAggregator->subscribe(
    'Hex::Command::PlaceStone' => \&handle_place_stone
);

sub handle_place_stone {
    my ($self, $command) = @_;

    my $game = $self->repository->get_by_id($c->GameID);
    $aggregate->place_stone($game, $c->Cell);
}

1;
