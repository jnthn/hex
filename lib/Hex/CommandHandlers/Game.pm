use Hex::EventAggregator;
use Hex::Command::PlaceStone;

Hex::EventAggregator->subscribe(
    Hex::Command::PlaceStone,
    sub {
        my $c = shift;
        print "yay in command handler\n";
    }
);

1;
