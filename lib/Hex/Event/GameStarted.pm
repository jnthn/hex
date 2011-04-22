use Hex::Event;

package Hex::Event::GameStarted;
use Moose;
extends 'Hex::Event';

has 'FirstPlayerHandle'  => (is => 'rw', isa => 'Str');
has 'SecondPlayerHandle' => (is => 'rw', isa => 'Str');
has 'Size'               => (is => 'rw', isa => 'Int');
has 'PlayerTimeLimit'    => (is => 'rw');

1;
