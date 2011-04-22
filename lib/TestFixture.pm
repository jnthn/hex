package TestFixture;
use Test::More;
use TestRepository;

use Moose;

use Hex::AggregateRoot;
use Hex::EventAggregator;

has 'root' => (is => 'ro', isa => 'Hex::AggregateRoot');

has 'given' => (is => 'ro', isa => 'ArrayRef[Hex::Event]');
has 'when'  => (is => 'ro', isa => 'Hex::Command');
has 'then'  => (is => 'ro', isa => 'ArrayRef[Hex::Event] | Str');

sub run {
    my ($self) = @_;

    my $root = $self->root();
    $root->load_from_history( $self->given() );
    my @events;
    eval {
        Hex::EventAggregator->send( $self->when() );
        @events = $root->get_changes();
    };
    is_deeply(\@events, $self->then());
}

my $repository = TestRepository->new();
sub repository {
    my ($self) = @_;
    return $repository;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
