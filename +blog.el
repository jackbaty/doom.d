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


;; (setq auth-sources '("~/.authinfo"))

;; (let* ((credentials (auth-source-user-and-password "wordpress"))
;;        (username (nth 0 credentials))
;;        (password (nth 1 credentials))
;;        (config `("wordpress"
;;                  :url "https://baty.net/xmlrpc.php"
;;                  :username ,username
;;                  :password ,password
;;                  :default-categories ("Misc"))))
;;   (setq org2blog/wp-blog-alist config))
;;




;; Possible fix for ox-hugo hanging on save
(setq org-element-use-cache nil)

;; For ox-hugo shortcode
(with-eval-after-load 'ox-hugo
  (add-to-list 'org-hugo-special-block-type-properties '("sidenote" . (:trim-pre t :trim-post t))))
