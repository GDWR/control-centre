output "urls" {
  value = concat(
    module.gdwrsite.urls,
    module.colours.urls,
    module.urlshort.urls
  )
}
