package TestFixture;

use Moose;

use Hex::AggregateRoot;
use Hex::Event;

has 'root' => (
    is => 'ro',
    isa => 'Hex::AggregateRoot',
);

has 'given' => (
    is => 'ro',
    isa => 'ArrayRef[Hex::Event]',
);

has 'when' => (
    is => 'ro',
    isa => 'CodeRef',
);

has 'then' => (
    is => 'ro',
    isa => 'ArrayRef[Hex::Event] | Str',
);

sub run {
    my ($self) = @_;

    my $root = $self->root();
    $root->load_from_history( $self->given() );
    my @events;
    eval {
        $self->when()->();
        @events = $root->get_changes();
    }
    # hm, handle the result here somehow
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
