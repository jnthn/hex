use Test::More tests => 1;
use lib 'lib';
use TestFixture;
use Hex::Command::PlaceStone;
use Hex::Event::GameStarted;
use Hex::Event::StonePlaced;
use Hex::AggregateRoots::Game;

TestFixture->new(
    root => Hex::AggregateRoots::Game->new(),
    given => [Hex::Event::GameStarted->new(
        FirstPlayerHandle => 'jnthn',
        SecondPlayerHandle => 'masak',
        Size => '15',
        PlayerTimeLimit => 'P1h'
    )],
    when => sub {
        Hex::Command::PlaceStone->new(
            GameID => 42,
            Cell => 'B5'
        )
    },
    then => [Hex::Event::StonePlaced->new(
        GameID => 42,
        PlayerHandle => 'jnthn',
        Cell => 'B5'
    )]
)->run();
