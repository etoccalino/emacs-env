
;;
;; Configuration Elfeed (Available on MELPA)
;;

(custom-set-variables
 ;; Elfeed configuration
 '(elfeed-db-directory "~/.emacs.d/elfeed")
 '(elfeed-feeds
   '(("http://etoccalino.com/rss")
     ("http://daringfireball.net/feeds/articles")
     ("http://feeds.feedburner.com/TheBigPicture")
     ("http://feeds.feedburner.com/IeeeSpectrum")
     ("http://feeds.feedburner.com/IeeeSpectrumComputing")
     ("http://feeds.feedburner.com/IeeeSpectrumRobotics")
     ("http://feeds.feedburner.com/codinghorror")
     ("http://syndication.thedailywtf.com/TheDailyWtf")
     ("http://martinfowler.com/feed.atom")
     ("http://www.bhorowitz.com/blog.rss")
     ("http://feeds.hanselman.com/ScottHanselman")
     ("http://neopythonic.blogspot.com/feeds/posts/default")
     ("http://feeds.feedburner.com/BigPictureAgriculture")
     ("http://feeds.wired.com/wiredbusinessblog")
     ("http://feeds.wired.com/wired/index")
     ("http://feeds.feedburner.com/TechCrunch/")
     ("http://nullprogram.com/feed/")
     ("http://xkcd.com/rss.xml")
     ("http://feeds.feedburner.com/oatmealfeed")
     ("http://www.ohjoysextoy.com/feed/")
     ("http://www.businessweek.com/feeds/blogs/the-management-blog.rss")
     ("http://www.reddit.com/r/Python/.rss")
     ("https://www.archlinux.org/feeds/news/")
     ))
 '(elfeed-search-filter "@6-months-ago ")
 '(elfeed-search-refresh-rate 30)
)

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
