package wtsi_clarity::epp::sm::qc_complete;

use Moose;
use Carp;
use XML::LibXML;
use Readonly;
use DateTime;

use wtsi_clarity::util::request;
use wtsi_clarity::util::clarity_elements;

## no critic(ValuesAndExpressions::RequireInterpolationOfMetachars)
Readonly::Scalar my $ARTIFACT_PATH => q(/prc:process/input-output-map/input/@post-process-uri);
Readonly::Scalar my $SAMPLE_PATH   => q(/art:artifact/sample/@uri);
Readonly::Scalar my $TARGET_NAME   => q(QC Complete);
## use critic

extends 'wtsi_clarity::util::clarity_elements_fetcher';
with 'wtsi_clarity::util::clarity_elements';
with 'wtsi_clarity::util::clarity_elements_fetcher_role';

our $VERSION = '0.0';

sub get_targets_uri {
  return ( $ARTIFACT_PATH , $SAMPLE_PATH);
};

sub update_one_target_data {
  my ($self, $targetDoc, $targetURI, $value) = @_;

  $self->set_udf_element_if_absent($targetDoc, $TARGET_NAME, $value);

  return $targetDoc->toString();
};

sub get_data {
  my ($self, $targetDoc, $targetURI) = @_;
  return DateTime->now->strftime('%Y-%m-%d');
};

1;

__END__

=head1 NAME

wtsi_clarity::epp::sm::qc_complete

=head1 SYNOPSIS

  wtsi_clarity::epp:sm::qc_complete->new(process_url => 'http://my.com/processes/3345')->run();

=head1 DESCRIPTION

  Updates the 'QC Complete' field of all samples in the process to the current date.

=head1 SUBROUTINES/METHODS

=head2 get_targets_uri
  Implementation needed by wtsi_clarity::util::clarity_elements_fetcher_role.
  The targets are the samples find inside each artifact of the process.

=head2 update_one_target_data
  Implementation needed by wtsi_clarity::util::clarity_elements_fetcher_role.
  The targets should only be updated if the target value is not present.

=head2 get_data
  Implementation needed by wtsi_clarity::util::clarity_elements_fetcher_role.
  The value used to update the target is today's date.

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item Moose

=item Carp

=item XML::LibXML

=item Readonly

=item JSON

=back

=head1 AUTHOR

Benoit Mangili E<lt>bm10@sanger.ac.ukE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2014 Genome Research Ltd.

This file is part of wtsi_clarity project.

wtsi_clarity is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

=cut
