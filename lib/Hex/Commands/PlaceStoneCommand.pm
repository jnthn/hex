use Hex::Command;

package Hex::Commands::PlaceStoneCommand;
use Moose;
extends 'Hex::Command';

has 'GameID' => (is => 'rw', isa => 'Int');
has 'Cell'   => (is => 'rw', isa => 'Str');

1;
