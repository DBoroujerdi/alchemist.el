;;; alchemist-macroexpand.el --- Macro expansion support -*- lexical-binding: t -*-

;; Copyright © 2014-2017 Samuel Tonini

;; Author: Samuel Tonini <tonini.samuel@gmail.com

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Xref support

;;; Code:

(require 'alchemist-server)
(require 'alchemist-scope)

;; todo

;; maintain 2 lists
;; - list of caller names - human readable names
;; - list of caller name to positions (list (name . buffer . position)) see goto
;; these should come from a call to the alchemist server
;; user is then given the results as a completing read, which will then
;; lookup the location in the second list and go to it - possiby somem reuse in the goto module

;; traverse back using M-,


(defconst alchemist-xref--defmodule-regex
  "^\\s-*\\(defmodule\\)[ \n\t]+\\([a-z_\?!.]+\\)\\(.*\\)\\(do\\|\n\\)?$")

(defvar alchemist-xref-filter-output nil)

(defun alchemist-xref-module-callers ()
  (interactive)
  (let ((module (alchemist-scope-module)))

    (alchemist-server-xref-candidates (alchemist-xref-build-server-arg "module" arg)
                                      #'alchemist-xref-filter)

    ))


(defun alchemist-xref-filter (_process output)
  (setq alchemist-xref-filter-output (cons output alchemist-xref-filter-output))
  (if (alchemist-server-contains-end-marker-p output)
      ;; todo process output
      (message "finished!!!")
      (message output)
        (setq alchemist-xref-filter-output nil)))


(defun alchemist-xref-build-server-arg (type arg)
  (if (not (equal major-mode 'alchemist-iex-mode))
      (alchemist-company-build-scope-arg arg)
    (format "{ \"%s\", \"%s\"}" type arg)))


(defun alchemist-xref-get-function-callers ()
    "todo"
    )


;; todo does not work with function ending in ?

;; todo can generalise these a bit, like mix test funtions

;; Private funcions


(provide 'alchemist-xref)

;;; alchemist-xref.el ends here
