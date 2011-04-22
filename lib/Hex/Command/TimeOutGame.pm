use Hex::Command;

package Hex::Command::TimeOutGame;
use Moose;
extends 'Hex::Command';

has 'GameID'                => (is => 'rw', isa => 'Int');
has 'TimingOutPlayerHandle' => (is => 'rw', isa => 'Str');

1;
