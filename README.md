vim-scala
=========

This is a "bundle" for Vim that builds off of the initial Scala plugin modules
by Stefan Matthias Aust and adds some more "stuff" that I find useful, including
all of my notes and customizations.

## Installation

You really should be using Tim Pope's
[Pathogen](https://github.com/tpope/vim-pathogen) module for Vim, unless you
have vim 8+ or support for packages. Then just clone the repo into your
packpath.

## Sorting of import statements
    :SortScalaImports

There are different modes for import sorting available. For details, please
consult the vimdoc help with

    :help :SortScalaImports

## Scaladoc comment indentation

By default, the plugin indents documentation comments according to the standard
Javadoc format

    /**
     * This is a doc comment using Javadoc-style indentation.
     */

To enable the indentation standard as recommended for Scaladoc comments, add the
command `let g:scala_scaladoc_indent = 1` to .vimrc file, e.g:

    /** This is a Scaladoc comment using the recommended indentation.
      * let g:scala_scaladoc_indent = 1
      */
