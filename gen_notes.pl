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
print $output '\documentclass[a4paper,12pt,oneside]{book}

\title{Data Storage Technologies}
\author{Dr Peadar Grant}
\date{\today}

\usepackage{natbib}
\usepackage{ifpdf}
\ifpdf
\usepackage{mathptmx}
\usepackage[margin=1.0cm,bmargin=3.0cm,tmargin=2.0cm]{geometry}
\usepackage{chappg}
\fi
\usepackage{import}
\usepackage{amsmath,amssymb}
\usepackage[binary-units,detect-all]{siunitx}
\usepackage{booktabs}
\usepackage{tabularx}
\usepackage{graphicx}
% Quick auto image insertion
\newcommand{\autoimage}[3]{%
   % 1 = image file
   % 2 = caption
   % 3 = label
   \begin{figure}[htbp]
   \centering
   \includegraphics[width=0.6\linewidth]{#1}
   \caption{#2}
   \label{fig:#3}
 \end{figure}
}
\usepackage{xpatch}
\usepackage{minted}
\usemintedstyle{emacs}
% fix for minted with imports
\makeatletter
\xpatchcmd\inputminted
  {#3}
  {\import@path #3}
  {}{\fail}
\makeatother

\usepackage[pdfusetitle]{hyperref}

\begin{document}

\maketitle

\ifpdf
\tableofcontents
\else
\href{dst_notes.pdf}{PDF version}

\textbf{Required reading:} \citet{ism-book}
\fi

';


# directory naming patterns to include
my @dir_patterns = (
    't[01][01234567890]_*'
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

\bibliographystyle{plainnat}
\bibliography{dst}

\end{document}

';

close $output;
