#' @title Turn a Check into an Expectation
#'
#' @description
#' \code{makeExceptionFunction} can be used to automatically create an expectation
#' function based on a check function from \CRANpkg{checkmate} (see example).
#'
#' @param check.fun [\code{function}]\cr
#'  Function which checks the input. Must return \code{TRUE} on success and a string with the error message otherwise.
#' @param env [\code{environment}]\cr
#'  The environment of the created function. Default is the \code{\link[base]{parent.frame}}.
#' @return \code{function}.
#' @export
#' @examples
#' # Simple custom check function
#' checkFalse = function(x) if (!identical(x, FALSE)) "Must be FALSE" else TRUE
#'
#' # Create the respective expect function
#' expect_false = makeExpectationFunction(checkFalse)
#' print(expect_false)
makeExpectationFunction = function(check.fun, env = parent.frame()) {
  fun.name = if (!is.character(check.fun)) deparse(substitute(check.fun)) else check.fun
  check.fun = match.fun(check.fun)
  fun.args = formals(args(check.fun))
  x.name = names(fun.args[1L])
  x = NULL
  body = sprintf(template, x.name, fun.name, paste0(names(fun.args), collapse = ", "))

  new.fun = function() TRUE
  formals(new.fun) = fun.args
  body(new.fun) = parse(text = body)
  environment(new.fun) = env

  return(new.fun)
}

# 1: name of x
# 2: name of function to call
# 3: function arguments, as collapsed string
template = '{
    res = %2$s(%3$s)

    tinytest::tinytest(
      result = isTRUE(res),
      call = sys.call(sys.parent(1)),
      diff = if (is.character(res)) res else "",
      short = %1$s
    )
}'
