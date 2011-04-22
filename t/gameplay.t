use Test;
use lib 'lib';
use TestFixture;
use Hex::Command::PlaceStone;
use Hex::Event::GameStarted;
use Hex::Event::StonePlacedEvent;

plan(1);

AggregateTest->new(
    given => [Hex::Event::GameStarted->new(
        FirstPlayerHandle => 'jnthn',
        SecondPlayerHandle => 'masak',
        Size => '15',
        PlayerTimeLimit => 'P1h'
    )],
    when => {
        Hex::Command::PlaceStone->new(
            GameID => 42,
            Cell => 'B5'
        )
    },
    then => [Hex::Event::StonePlacedEvent->new(
        GameID => 42,
        PlayerHandle => 'jnthn',
        Cell => 'B5'
    )]
)->run();
