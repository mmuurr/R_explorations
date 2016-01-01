## R treats default and supplied arguments to functions differently.
## The difference is subtle and may be considered a 'gotcha' by some, but generally won't affect most people until they start dealing with non-standard evaluation.
## A detailed description of the difference is here: https://cran.r-project.org/doc/manuals/r-release/R-lang.html#Argument-evaluation
## Arguments supplied to a function call are (i) promises and (ii) evaluated _in the executing frame **from which the function call is being made**_.
## Default arguments in a function call are evaluated _in the executing frame **of the function itself**_.

## In the example below, the difference in `eval`'s `envir` argument is shown.
## The default value for `envir` is `parent.frame()`.
## The supplied argument in the example is `parent.frame()`.
## The output of each call, however, varies depending on whether or not `parent.frame` is used as the default or is supplied.

a <- "outer"
f <- function() {
    a <- "inner"
    default_result <- eval(quote(a)) ## envir's default value is parent.frame()
    supplied_result <- eval(quote(a), envir = parent.frame())
    list(default_result, supplied_result)
}
f()

## In the `default_result` case, `envir` is computed from _within the executing frame of `eval` itself_.
## `parent.frame()` thus points back to the executing frame of `f`.
## Thus the `"inner"` version of `a` is found.

## In the `supplied_result` case, `envir` is computed as a promse from _within the current executing frame of `f`_.
## `parent.frame()` in this case points back up to the global environment.
## Thus the `"outer"` version of `a` is found this time around.
