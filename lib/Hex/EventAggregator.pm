package Hex::EventAggregator;
use Moose;

# Hash of array storing subscriptions.
my %subscriptions;

# Subscribe a handler to a message.
sub subscribe {
    my ($self, $type, $handler) = @_;
    $subscriptions{$type} ||= [];
    push @{$subscriptions{$type}}, $handler;
}

# Send a message. Must have exactly one handler.
sub send {
    my ($self, $to_publish);
    my $subs = $subscriptions{ref($to_publish)};
    if ($subs && @$subs == 1) {
        $subs->[0]->($to_publish);
    }
    else {
        die "No handler for command " . ref($to_publish);
    }
}

# Publish a message. May have zero or more subscribers.
sub publish {
    my ($self, $to_publish);
    my $subs = $subscriptions{ref($to_publish)} || [];
    for (@$subs) {
        $_->($to_publish);
    }
}

1;
