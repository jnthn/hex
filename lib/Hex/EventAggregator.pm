package Hex::EventAggregator;
use Moose;

# Hash of array storing subscriptions.
my %subscriptions;

# If we want to subscribe to all events (e.g. for the
# purpose of testing), this will hold a coderef.
my $all_event_receiver;

# Add a listener that gets all events.
sub send_all_events_to {
    my ($self, $receiver);
    $all_event_receiver = $receiver;
}

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
    if (!$subs || @$subs != 1) {
        $subs->[0]->($to_publish);
    }
}

# Publish a message. May have zero or more subscribers.
sub publish {
    my ($self, $to_publish);
    my $subs = $subscriptions{ref($to_publish)} || [];
    for (@$subs) {
        $_->($to_publish);
    }
    if ($all_event_receiver) {
        $all_event_receiver->($to_publish);
    }
}

1;
