use Hex::Event;

package Hex::Event::GameResigned;
use Moose;
extends 'Hex::Event';

has 'GameID'             => (is => 'rw', isa => 'Int');
has 'WinnerPlayerHandle' => (is => 'rw', isa => 'Str');
has 'LoserPlayerHandle'  => (is => 'rw', isa => 'Str');

1;
