package Hex::AggregateRoot;

use Moose;

has 'id' => (
    is => 'ro',
    isa => 'Str'
);

has 'version' => (
    is => 'ro',
    isa => 'Int'
);

has 'changes' => (
    is => 'rw',
    isa => 'ArrayRef[Event]',
    reader => 'get_uncommitted_changes',
);

sub mark_changes_as_committed {
    my ($self) = @_;

    @{ $self->changes() } = ();
}

sub apply_event {
    my ($self, $event, $add) = @_;

    my $handler = $self->lookup()->{ref $event}
        or return; # original code fails here...
    $handler->($self);

    $add //= 1;
    if ($add) {
        push @{$self->changes()}, $event;
    }
}

sub load_from_history {
    my ($self, $events_ref) = @_;

    my @events = @{$events_ref};
    for my $event (@events) {
        $self->apply_event($event, 0);
    }
}

1;
