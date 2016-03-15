# Dancer2::Template::Mason1 [![Build Status](https://secure.travis-ci.org/plicease/Dancer2-Template-Mason1.png)](http://travis-ci.org/plicease/Dancer2-Template-Mason1)

Mason 1 engine for Dancer2

# SYNOPSIS

`config.yml`:

    template 'mason1';

`MyApp.pm`:

    get '/foo' => sub {
      template foo => {
        title => 'bar';
      };
    };

`views/foo.mc`:

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

# DESCRIPTION

This module provides a template engine that allows you to use [HTML::Mason](https://metacpan.org/pod/HTML::Mason) 
(also known as Mason 1.x) with [Dancer2](https://metacpan.org/pod/Dancer2).

# CONFIGURATION

Parameters to [HTML::Mason::Interp](https://metacpan.org/pod/HTML::Mason::Interp)'s `new` can be passed like so:

    engines:
      mason1:
        data_dir: /path/to_data_dir

`comp_root` defaults to the `views` configuration setting, or if it is
undefined, to the `/views` subdirectory of the application.

`data_dir` defaults to `/data` subdirectory in the project root
directory.

# SEE ALSO

- [Dancer2](https://metacpan.org/pod/Dancer2)
- [HTML::Mason](https://metacpan.org/pod/HTML::Mason)

# AUTHOR

Graham Ollis &lt;plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
