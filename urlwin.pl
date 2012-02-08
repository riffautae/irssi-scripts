# Print clickable URLS to a window named "urls"
use Irssi;
use vars qw($VERSION %IRSSI); 
$VERSION = "1.03";
%IRSSI = (
    authors     => "riffautae",
    contact     => "riffautae\@gmail.com", 
    name        => "urlwin",
    description => "Print clickable URL's to a window named \"urls\" and bold the domain names.",
    license     => "Public Domain",
    url         => "http://github.com/riffautae/irssi-scripts",
    changed     => "Fri Sep 19 21:27:00 EDT 2008"
);

$reg = qr#((?:https?|ftp)://)((?:[^\s<>"/]*\.)*[\w\-]+\.[\w\-]+(?::[0-9]+)?)((?:/[^\s]+)?)#;

sub check_url ($) {
    my ($text) = @_;

        if ( $text =~ $reg )
        {
                return 1;
        }
}

sub sig_printtext {
  my ($server, $data, $nick, $mask, $target) = @_;

  if (check_url($data)) {
    $window = Irssi::window_find_name('urls');

        $data =~ s/\%/\%\%/g;

        $data =~ s/$reg/\%0\1\%_\2\%_\3\%n/g;

    $text = "\%g".$target."\%n: <\%B".$nick."\%n> ".$data;
    
    $window->print($text, MSGLEVEL_CLIENTCRAP) if ($window);
  }
}

$window = Irssi::window_find_name('urls');
Irssi::print("Create a window named 'urls'") if (!$window);

Irssi::signal_add('message public', 'sig_printtext');
