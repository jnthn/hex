package TestRepository;

use Moose;

extends 'Repository';

has 'storage' => (
    is => 'rw',
);

sub add {
    my ($self, $id, $aggregate) = @_;

    die "Must supply an id"
        unless defined $id;
    die "Must supply an aggregate"
        unless defined $aggregate;
    die "Second argument must be of type AggregateRoot"
        unless $aggregate->isa('Hex::AggregateRoot');

    $self->storage($aggregate);
}

sub get_by_id {
    my ($self, $id) = @_;

    die "Aggregate with id $id not found"
        unless defined $self->storage();

    return $self->storage();
}

sub save {
    # This is a test repository, so we don't want to save
}

sub reset {
    my ($self) = @_;

    $self->storage(undef);
    return;
}

1;
