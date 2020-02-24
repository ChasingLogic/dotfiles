;;; chasinglogic-text-utils.el --- Modes and packages which make working with text better

;; Copyright (C) 2020 Mathew Robinson

;; Author: Mathew Robinson <mathew@chasinglogic.io>
;; Created: 24 Feb 2020

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; 

;;; Code:

;; Expand Region
;;
;;     Expand region takes the idea of, what I consider, one of the best
;;     key bindings in Emacs `M-h' (`mark-paragraph') and makes it work
;;     incrementally with semantic units. It's beautiful and useful. For
;;     consistency I bind it to `C-M-h'.
(use-package expand-region
  :bind ("C-M-h" . expand-region))

;; Avy
;;     only compare it to EasyMotion for Vim but it's actually much
;;     better IMO. It has many "jumping" commands for going to words,
;;     subwords, characters, lines etc. Here I only bind a few of the
;;     most useful ones to me.
(use-package avy
  :general
  (leader!
    "jj" 'avy-goto-word-1
    "jw" 'avy-goto-word-1
    "jl" 'avy-goto-line
    "jh" 'avy-goto-heading)
  :bind
  (("M-j"     . 'avy-goto-word-1)
   ("C-c j c" . 'avy-goto-char)
   ("C-c j j" . 'avy-goto-word-1)
   ("C-c j l" . 'avy-goto-line)
   ("C-c j h" . 'avy-goto-heading))
  :config
  ;; When non-nil, a gray background will be added during the selection.
  (setq avy-background t))

;; Ace Window
;;
;;     One of the hardest parts coming to Emacs from Vim was learning
;;     window management. The default keybinding =C-x o= felt cumbersome
;;     to press not to mention use. Luckily there is a package (again
;;     from `abo-abo') that solves this problem. Ace Window will
;;     highlight windows with a number and let you jump to them by
;;     pressing the corresponding number. It's also smart and when there
;;     are only two windows will simply cycle between them without
;;     prompting. I bind it to `M-o' as the original command bound to
;;     that key I never use and I prefer meta bindings for commonly
;;     pressed commands.
(require 'term)
(use-package ace-window
  :commands 'ace-window
  :init (defun chasinglogic-ace-window (arg)
          "Create a window if only one window and/or call ace-window"
          (interactive "p")
          (when (eq (length (window-list)) 1)
            (split-window-horizontally))
          (ace-window arg))
  :config (setq aw-scope 'frame)
  :bind (("M-o" . chasinglogic-ace-window)
         (:map term-raw-map
               ("M-o" . ace-window))))

;; Yasnippet
;;
;; Yasnippet is definitely in my top 5 packages. It's the most
;; powerful and simple snippet system I've ever used. You can program
;; snippets with elisp to generate code or you can write simple
;; TextMate style snippets that just define tab stops. No
;; configuration required on this one just type a snippet identifier
;; and press tab.
(use-package yasnippet
  :diminish 'yas-minor-mode
  :config (yas-global-mode 1))

;; Electric pair mode automatically pairs common programming
;; operators: =(=, ={=, ="=, ='=, etc. I find this behavior annoying
;; in prose modes so I use a custom hook to only enable it for
;; programming modes.
(defun enable-electric-pair-local-mode ()
  "Enable eletric pair mode locally."
  (electric-pair-local-mode 1))
(add-hook 'prog-mode-hook 'enable-electric-pair-local-mode)

;; Show Paren Mode I'm just going to steal the description of this
;; straight from the documentation: Toggle visualization of matching
;; parens (Show Paren mode).
(show-paren-mode 1)

;; Abbrev mode is a simple but magical minor mode. I make some
;; spelling mistakes all the time. At this point some of them have
;; become muscle memory and so while I know the spelling is wrong I
;; don't know if I'll ever be able to change them. This is where
;; Abbrev mode comes in. I register abbreviations on a major mode or
;; global basis and `abbrev-mode' will automatically expand them to
;; the correction whenever I type them.
(add-hook 'text-mode-hook 'abbrev-mode)

;; Automatically Do important programming stuff Emacs has a series of
;; modes that I call the "electric modes", as they all start with
;; `electric-'. All of these modes perform important editing functions
;; automatically.
;;
;; Electric indent mode on-the-fly reindents your code as you type. It
;; checks for newlines and other common chars that are configured via
;; the variable `electric-indent-chars'. This mode is invaluable and
;; saves me a lot of formatting time.
(electric-indent-mode 1)

;; Electric layout mode automatically inserts newlines around some
;; characters. The variable `electric-layout-rules' defines when and
;; how to insert newlines. The short of it is for many modes this auto
;; formats code.
(electric-layout-mode 1)

(provide 'chasinglogic-text-utils)

;;; chasinglogic-text-utils.el ends here