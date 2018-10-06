package Fulla::Dos;

use v5.22;
use warnings;

use Function::Parameters 'method';

# constructor method for object
method new ( :$min_pause ) {

    my $args = { dos_list => {},
                 pause    => $min_pause,
               };

    bless $args, $self;
}

# check a client request for authorisation
method check ($id) {

    # DOS-Überprüfung im Server-Loop
    my $current_time = time();
    my $last_access  = $self->{dos_list}->{$id};
    
    $self->{dos_list}->{$id} = $current_time;
    
    if ($last_access) {
        my $span = $current_time - $last_access;
        if ($span < $self->{pause}) {
            # DOS
			return 1;
            next;
        }
    }
    # no DOS
	return;
}

1;
