use Test::More tests => 1;
use lib 'lib';
use TestFixture;
use Hex::Command::PlaceStone;
use Hex::Event::GameStarted;
use Hex::Event::StonePlaced;
use Hex::AggregateRoot::Game;
use Hex::CommandHandlers::Game;

TestFixture->new(
    root => Hex::AggregateRoot::Game->new(),
    given => [Hex::Event::GameStarted->new(
        GameID => 42,
        FirstPlayerHandle => 'jnthn',
        SecondPlayerHandle => 'masak',
        Size => '15',
        PlayerTimeLimit => 'P1h'
    )],
    when => Hex::Command::PlaceStone->new(
        GameID => 42,
        Cell => 'B5'
    ),
    then => [Hex::Event::StonePlaced->new(
        GameID => 42,
        PlayerHandle => 'jnthn',
        Cell => 'B5'
    )]
)->run();
