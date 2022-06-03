#!/usr/bin/env perl
# Assemble the notes chapters

use strict;
use warnings;
use DateTime;
use Cwd;
use File::Basename;
use File::Slurp;

# output stream
open ( my $output, '>', 'dst_notes.tex');

# document header
print $output '\documentclass{pgnotesbk}

\title{Data Storage Technologies}

\begin{document}

\maketitle

\ifpdf
\tableofcontents
\else
\href{dst_notes.pdf}{PDF version}
\fi

';


# directory naming patterns to include
my @dir_patterns = (
    's[12]w[01][01234567890]_*'
    );

# list of directories to scan
my @dirs;
for my $dir_pattern ( @dir_patterns ) {
    push(@dirs, grep { -d } glob $dir_pattern );
}

# file naming patterns to include
my @file_patterns = (
    '*_chapter.tex'
    );

# scan each directory
for my $dir (@dirs) {

    # list of files to process
    my @files;
    for my $file_pattern ( @file_patterns ) {
	push(@files, grep { -f } glob "$dir/${file_pattern}");
    }

    # process each file
    for my $file ( @files ) {
	my $file_name = basename($file);
	print $output "\\import{$dir}{$file_name}\n"; 
    }
    
}


print $output '

\end{document}

';

close $output;
