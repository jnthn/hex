use Hex::Command;

package Hex::Command::ResignGame;
use Moose;
extends 'Hex::Command';

has 'GameID' => (is => 'rw', isa => 'Int');

1;
