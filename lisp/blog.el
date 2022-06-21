(setq org2blog/wp-blog-alist
      '(("wordpress"
         :url "https://baty.net/xmlrpc.php"
         :username "jbaty"
         :default-title ""
         :default-categories ("Misc")
         :tags-as-categories nil)))


(setq org2blog/wp-track-posts (list "~/org/baty.net/.org2blog.org" "wordpress"))
(setq org2blog/wp-default-categories '("Misc"))
(setq org2blog/wp-default-tags '(""))
(setq org2blog/wp-image-upload t)
(setq org2blog/wp-show-post-in-browser 'ask)



;; Possible fix for ox-hugo hanging on save
(setq org-element-use-cache nil)

;; For ox-hugo shortcode
(with-eval-after-load 'ox-hugo
  (add-to-list 'org-hugo-special-block-type-properties '("sidenote" . (:trim-pre t :trim-post t))))


(require 'org-static-blog)
(setq org-static-blog-publish-title "My Static Org Blog")
(setq org-static-blog-publish-url "https://notes.baty.net")
(setq org-static-blog-publish-directory "~/sites/notes/")
(setq org-static-blog-posts-directory "~/sites/notes/posts/")
(setq org-static-blog-drafts-directory "~/sites/notes/drafts/")
(setq org-static-blog-enable-tags t)
(setq org-export-with-toc nil)
(setq org-export-with-section-numbers nil)

;; This header is inserted into the <head> section of every page:
;;   (you will need to create the style sheet at
;;    ~/projects/blog/static/style.css
;;    and the favicon at
;;    ~/projects/blog/static/favicon.ico)
(setq org-static-blog-page-header
      "<meta name=\"author\" content=\"Jack Baty\">
<meta name=\"referrer\" content=\"no-referrer\">
<link href= \"static/style.css\" rel=\"stylesheet\" type=\"text/css\" />
<link rel=\"icon\" href=\"static/favicon.ico\">")

;; This preamble is inserted at the beginning of the <body> of every page:
;;   This particular HTML creates a <div> with a simple linked headline
(setq org-static-blog-page-preamble
      "<div class=\"header\">
  <a href=\"/\">My Static Org Blog</a>
</div>")

;; This postamble is inserted at the end of the <body> of every page:
;;   This particular HTML creates a <div> with a link to the archive page
;;   and a licensing stub.
(setq org-static-blog-page-postamble
      "<div id=\"archive\">
  <a href=\"/archive.html\">Other posts</a>
</div>
<center><a rel=\"license\" href=\"https://creativecommons.org/licenses/by-sa/3.0/\"><img alt=\"Creative Commons License\" style=\"border-width:0\" src=\"https://i.creativecommons.org/l/by-sa/3.0/88x31.png\" /></a><br /><span xmlns:dct=\"https://purl.org/dc/terms/\" href=\"https://purl.org/dc/dcmitype/Text\" property=\"dct:title\" rel=\"dct:type\">baty.net</span> by <a xmlns:cc=\"https://creativecommons.org/ns#\" href=\"https://baty.net\" property=\"cc:attributionName\" rel=\"cc:attributionURL\">Jack Baty</a> is licensed under a <a rel=\"license\" href=\"https://creativecommons.org/licenses/by-sa/3.0/\">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.</center>")

;; This HTML code is inserted into the index page between the preamble and
;;   the blog posts
(setq org-static-blog-index-front-matter
      "<h1> Jack Baty's Notes </h1>\n")
