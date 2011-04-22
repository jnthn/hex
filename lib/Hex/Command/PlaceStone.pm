use Hex::Command;

package Hex::Command::PlaceStone;
use Moose;
extends 'Hex::Command';

has 'GameID' => (is => 'rw', isa => 'Int');
has 'Cell'   => (is => 'rw', isa => 'Str');

1;
