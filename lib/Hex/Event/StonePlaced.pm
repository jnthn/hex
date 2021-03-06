use Hex::Event;

package Hex::Event::StonePlaced;
use Moose;
extends 'Hex::Event';

has 'GameID'       => (is => 'rw', isa => 'Int');
has 'PlayerHandle' => (is => 'rw', isa => 'Str');
has 'Cell'         => (is => 'rw', isa => 'Str');

1;
