#!/usr/bin/perl -I/home/phil/perl/cpan/DataTableText/lib/
#-------------------------------------------------------------------------------
# Push QuickSort code to GitHub
# Philip R Brenan at gmail dot com, Appa Apps Ltd Inc., 2025
#-------------------------------------------------------------------------------
#die "Turned off"
use v5.38;
use warnings FATAL => qw(all);
use strict;
use Carp;
use Data::Dump qw(dump);
use Data::Table::Text qw(:all);
use GitHub::Crud qw(:all);

my $home    = q(/home/phil/perl/z/quickSort/);                                  # Home folder
my $user    = q(philiprbrenan);                                                 # User
my $repo    = q(quickSortFailure);                                              # Repo
my $wf      = q(.github/workflows/main.yml);                                    # Work flow on Ubuntu
my @ext     = qw(.md .pl .py);                                                  # Extensions of files to upload to github

push my @files, searchDirectoryTreesForMatchingFiles($home, @ext);              # Files to upload

if  (1)                                                                         # Upload via github crud
 {for my $s(@files)                                                             # Upload each selected file
   {my $c = readBinaryFile $s;                                                  # Load file

    $c = expandWellKnownWordsAsUrlsInMdFormat $c if $s =~ m(README);            # Expand README

    my $t = swapFilePrefix $s, $home;                                           # File on github
    my $w = writeFileUsingSavedToken($user, $repo, $t, $c);                     # Write file into github
    lll "$w  $t";
   }
 }

if (1)                                                                          # Write workflow
 {my $d = dateTimeStamp;
  my $y = <<"END";
# Test $d

name: Test
run-name: $repo

on:
  push:
    paths:
      - '**/main.yml'
jobs:

  test:
    permissions: write-all
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout\@v4
      with:
        ref: 'main'

    - name: perl quickSortEasy.pl
      if: \${{ always() }}
      run: |
        perl quickSortEasy.pl

    - name: python3 quickSortEasy.py
      if: \${{ always() }}
      run: |
        python3 quickSortEasy.py

    - name: perl quickSort.pl
      if: \${{ always() }}
      run: |
        perl quickSort.pl
END

  my $f = writeFileUsingSavedToken $user, $repo, $wf, $y;                       # Upload workflow
  lll "$f  Ubuntu work flow for $repo";
 }
