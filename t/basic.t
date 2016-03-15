use strict;
use 5.016;
use Test::More;
use Plack::Test;
use HTTP::Request::Common;
use Path::Class ();
use File::Temp ();

my $corpus = Path::Class::File->new(__FILE__)->absolute->parent->parent->subdir(qw( corpus ));

note "corpus = $corpus";

package MyApp {

  use Dancer2;
  
  set template => 'mason1';
  set appdir => File::Temp::tempdir( CLEANUP => 1 );
  set views => $corpus->subdir('views')->stringify,
  set engines => {
    template => {
      mason1 => {
      },
    },
  };
  
  get '/nolayout' => sub { template 'index', {}, { layout => undef  } };
  get '/layout'   => sub { template 'index', {}, { layout => 'main' } };

}

my $app = MyApp->to_app;
my $plack = Plack::Test->create($app);

test_psgi $app, sub {

  my $res = $plack->request( GET '/nolayout' );
  is $res->code, 200, '[GET /nolayout] Request successful';
  like $res->content, qr/hello, world/, '[GET /nolayout] Correct content';
  
  note $res->content;

};

test_psgi $app, sub {

  my $res = $plack->request( GET '/layout' );
  is $res->code, 200, '[GET /layout] Request successful';
  like $res->content, qr/hello, world/, '[GET /layout] Correct content';
  like $res->content, qr/hello title/, '[GET /layout] has title';

  note $res->content;
};

done_testing;


