use Hex::Command;

package Hex::Command::SwapPlayerColors;
use Moose;
extends 'Hex::Command';

has 'GameID' => (is => 'rw', isa => 'Int');

1;
