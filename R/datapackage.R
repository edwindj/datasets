#' creates a dummy datapackage.json
#' simple data format
datapackage <- function(x, dir=".", title="", description="", ...){
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd))
  
  dp <- list( name = deparse(substitute(x))
            , datapackage_version = "1.0b5"
            , title=title
            , description = description
            )
  
  l <- list(...)
  for (n in names(l)){
    dp[n] <- l[n]
  }
  
  dp$resources = table_schema(x, dp$name)  
  writeLines(toJSON(dp, pretty=T), "datapackage.json")
  invisible(dp)
}

table_schema <- function(x, name, ...){
  #TODO csv writing to different function
  path <- paste0(name, ".csv")
  write.csv(x, file=path, row.names=FALSE)
  
  fields <- lapply(colnames(x), function(n){
    field <- x[[n]]
    list( name = n 
        , title= n
        , type = switch( class(field)
                        , "integer" = "integer"
                        , "numeric" = "number"
                        , "string"
                       )
        , description=""
        )
  }) 
  list(path=path, schema=list(fields=fields))
}

# testing 
require(RJSONIO)
dp <- datapackage( iris
                 , title="Edgar Anderson's Iris Data"
                 , description="This famous (Fisher's or Anderson's)
iris data set gives the measurements in centimeters of the 
variables sepal length and width and petal length and width,
respectively, for 50 flowers from each of 3 species of iris. 
The species are Iris _setosa_, _versicolor_, and _virginica_")
cat(as.yaml(dp))
#cat(toJSON(dp))
