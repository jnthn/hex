package TestRepository;

use Moose;

extends 'Repository';

has 'storage' => (
    is => 'rw',
    isa => 'Hex::AggregateRoot',
);

sub add {
    my ($self, $id, $aggregate) = @_;

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

    %{ $self->storage } = ();
    return;
}

1;
