use Hex::Event;

package Hex::Event::PlayerColorsSwapped;
use Moose;
extends 'Hex::Event';

has 'GameID'       => (is => 'rw', isa => 'Int');
has 'PlayerHandle' => (is => 'rw', isa => 'Str');

1;
