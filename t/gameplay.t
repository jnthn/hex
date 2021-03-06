use Test::More tests => 10;
use lib 'lib';
use TestFixture;
use Hex::Command::PlaceStone;
use Hex::Command::SwapPlayerColors;
use Hex::Event::GameStarted;
use Hex::Event::StonePlaced;
use Hex::Event::PlayerColorsSwapped;
use Hex::Event::GameResigned;
use Hex::AggregateRoot::Game;
use Hex::CommandHandlers::Game;

Hex::CommandHandlers::Game::setup(TestFixture->repository());

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
        PlayerHandle => 'jnthn',
        Cell => 'B5'
    ),
    then => [Hex::Event::StonePlaced->new(
        GameID => 42,
        PlayerHandle => 'jnthn',
        Cell => 'B5'
    )]
)->run();

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
        PlayerHandle => 'masak',
        Cell => 'B5'
    ),
    then => "Move out of turn"
)->run();

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
        PlayerHandle => 'jnthn',
        Cell => 'B17'
    ),
    then => "Piece outside of board"
)->run();

TestFixture->new(
    root => Hex::AggregateRoot::Game->new(),
    given => [Hex::Event::GameStarted->new(
        GameID => 42,
        FirstPlayerHandle => 'jnthn',
        SecondPlayerHandle => 'masak',
        Size => '21',
        PlayerTimeLimit => 'P1h'
    )],
    when => Hex::Command::PlaceStone->new(
        GameID => 42,
        PlayerHandle => 'jnthn',
        Cell => 'X1'
    ),
    then => "Piece outside of board"
)->run();

TestFixture->new(
    root => Hex::AggregateRoot::Game->new(),
    given => [Hex::Event::GameStarted->new(
        GameID => 42,
        FirstPlayerHandle => 'jnthn',
        SecondPlayerHandle => 'masak',
        Size => '5',
        PlayerTimeLimit => 'P1h'
    ),
    Hex::Event::StonePlaced->new(
        GameID => 42,
        PlayerHandle => 'jnthn',
        Cell => 'A1',
    )],
    when => Hex::Command::PlaceStone->new(
        GameID => 42,
        PlayerHandle => 'masak',
        Cell => 'A1'
    ),
    then => "Cell is already occupied"
)->run();

TestFixture->new(
    root => Hex::AggregateRoot::Game->new(),
    given => [Hex::Event::GameStarted->new(
        GameID => 42,
        FirstPlayerHandle => 'jnthn',
        SecondPlayerHandle => 'masak',
        Size => '5',
        PlayerTimeLimit => 'P1h'
    )],
    when => Hex::Command::SwapPlayerColors->new(
        GameID => 42,
        PlayerHandle => 'jnthn',
    ),
    then => "Can only swap player colors immediately after the first move"
)->run();

TestFixture->new(
    root => Hex::AggregateRoot::Game->new(),
    given => [Hex::Event::GameStarted->new(
        GameID => 42,
        FirstPlayerHandle => 'jnthn',
        SecondPlayerHandle => 'masak',
        Size => '5',
        PlayerTimeLimit => 'P1h'
    ),
    Hex::Event::StonePlaced->new(
        GameID => 42,
        PlayerHandle => 'jnthn',
        Cell => 'B5'
    )],
    when => Hex::Command::SwapPlayerColors->new(
        GameID => 42,
        PlayerHandle => 'masak',
    ),
    then => [Hex::Event::PlayerColorsSwapped->new(
        GameID => 42,
        PlayerHandle => 'masak',
    )],
)->run();

TestFixture->new(
    root => Hex::AggregateRoot::Game->new(),
    given => [Hex::Event::GameStarted->new(
        GameID => 42,
        FirstPlayerHandle => 'jnthn',
        SecondPlayerHandle => 'masak',
        Size => '5',
        PlayerTimeLimit => 'P1h'
    ),
    Hex::Event::StonePlaced->new(
        GameID => 42,
        PlayerHandle => 'jnthn',
        Cell => 'B5'
    ),
    Hex::Event::PlayerColorsSwapped->new(
        GameID => 42,
        PlayerHandle => 'masak',
    )],
    when => Hex::Command::PlaceStone->new(
        GameID => 42,
        PlayerHandle => 'masak',
        Cell => 'A1'
    ),
    then => "Move out of turn"
)->run();

TestFixture->new(
    root => Hex::AggregateRoot::Game->new(),
    given => [Hex::Event::GameStarted->new(
        GameID => 42,
        FirstPlayerHandle => 'jnthn',
        SecondPlayerHandle => 'masak',
        Size => '5',
        PlayerTimeLimit => 'P1h'
    ),
    Hex::Event::StonePlaced->new(
        GameID => 42,
        PlayerHandle => 'jnthn',
        Cell => 'B5'
    ),
    Hex::Event::PlayerColorsSwapped->new(
        GameID => 42,
        PlayerHandle => 'masak',
    )],
    when => Hex::Command::SwapPlayerColors->new(
        GameID => 42,
        PlayerHandle => 'jnthn',
    ),
    then => "Can only swap player colors immediately after the first move"
)->run();

TestFixture->new(
    root => Hex::AggregateRoot::Game->new(),
    given => [Hex::Event::GameStarted->new(
        GameID => 42,
        FirstPlayerHandle => 'jnthn',
        SecondPlayerHandle => 'masak',
        Size => '5',
        PlayerTimeLimit => 'P1h'
    ),
    Hex::Event::GameResigned->new(
        GameID => 42,
        PlayerHandle => 'masak',
    )],
    when => Hex::Command::PlaceStone->new(
        GameID => 42,
        PlayerHandle => 'jnthn',
        Cell => 'A5'
    ),
    then => "Cannot make a move after the game has ended"
)->run();
