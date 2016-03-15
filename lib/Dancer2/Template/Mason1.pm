package Dancer2::Template::Mason1;

use Moo;
use 5.010;
use Dancer2::Core::Types;
use HTML::Mason::Interp;

# ABSTRACT: Mason 1 engine for Dancer2
# VERSION

=head1 SYNOPSIS

C<config.yml>:

 template 'mason1';

C<MyApp.pm>:

 get '/foo' => sub {
   template foo => {
     title => 'bar';
   };
 };

C<views/foo.mc>:

 <%args>
 $title
 </%args>
 
 <html>
   <head>
     <title><% $title %></title>
   </head>
   <body>
     <p>Hello World!</p>
   </body>
 </html>

=head1 DESCRIPTION

This module provides a template engine that allows you to use L<HTML::Mason> 
(also known as Mason 1.x) with L<Dancer2>.

=head1 CONFIGURATION

Parameters to L<HTML::Mason::Interp>'s C<new> can be passed like so:

 engines:
   mason1:
     data_dir: /path/to_data_dir

C<comp_root> defaults to the C<views> configuration setting, or if it is
undefined, to the C</views> subdirectory of the application.

C<data_dir> defaults to C</data> subdirectory in the project root
directory.

=head1 SEE ALSO

=over 4

=item L<Dancer2>

=item L<HTML::Mason>

=back

=cut

with 'Dancer2::Core::Role::Template';

has '+engine' => ( isa => InstanceOf['HTML::Mason::Interp'] );
has '+default_tmpl_ext' => ( default => 'mc' );

sub _build_engine
{
  my($self) = @_;
  
  my %config = (
    %{ $self->config },
  );
  
  $config{comp_root} //= $self->views;
  $config{data_dir}  //= $self->settings->{appdir};
  
  return HTML::Mason::Interp->new(%config);
}

sub render
{
  my($self, $template, $tokens) = @_;
  
  my $root = $self->views;
  $template =~ s/^\Q$root//;  # cut the leading path
  
  my $output = '';
  my $request = $self->engine->make_request(
    args => [%$tokens],
    out_method => \$output,
    comp       => $template,
    # request params
  );
  
  $request->exec;
  
  return $output;
}

1;
