package TestRepository;

use Moose;

extends 'Repository';

has 'storage' => (
    is => 'ro',
    isa => 'HashRef[Hex::AggregateRoot]',
    default => { {} },
);

sub add {
    my ($self, $id, $aggregate) = @_;

    $self->storage->{$id} = $aggregate;
}

sub get_by_id {
    my ($self, $id) = @_;

    $self->storage->{$id}
        or die "Aggregate with id $id not found";
}

sub save {
}

1;
