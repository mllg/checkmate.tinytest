# 1: name of object to test (typically x)
# 2: name of function to call
# 3: function arguments, as collapsed string
template = '{
    call = sys.call(sys.parent(1L))
    res = %2$s(%3$s)

    if (isTRUE(res))
      return(tinytest::tinytest(TRUE, call = call))

    tinytest::tinytest(FALSE,
      call = sys.call(sys.parent(1)),
      diff = if (is.character(res)) res else "",
      short = %1$s
    )
}'

as_expectation = function(check.fun, env = parent.frame()) {
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


#' @title Expectations for 'tinytest'
#'
#' @description
#' Expectations for package \CRANpkg{tinytest}.
#' See the respective help page in \CRANpkg{checkmate} (replace `expect_` with `check_`) for a
#' description of the function arguments.
#' E.g., for the help page of `expect_numeric`, see \code{link[checkmate]{check_numeric}}.
#'
#' @keywords internal
#' @name checkmate.tinytest
NULL

#' @rdname checkmate.tinytest
#' @export
expect_access = as_expectation(checkmate::check_access)

#' @rdname checkmate.tinytest
#' @export
expect_array = as_expectation(checkmate::check_array)

#' @rdname checkmate.tinytest
#' @export
expect_atomic = as_expectation(checkmate::check_atomic)

#' @rdname checkmate.tinytest
#' @export
expect_atomic_vector = as_expectation(checkmate::check_atomic_vector)

#' @rdname checkmate.tinytest
#' @export
expect_bit = as_expectation(checkmate::check_bit)

#' @rdname checkmate.tinytest
#' @export
expect_character = as_expectation(checkmate::check_character)

#' @rdname checkmate.tinytest
#' @export
expect_choice = as_expectation(checkmate::check_choice)

#' @rdname checkmate.tinytest
#' @export
expect_class = as_expectation(checkmate::check_class)

#' @rdname checkmate.tinytest
#' @export
expect_complex = as_expectation(checkmate::check_complex)

#' @rdname checkmate.tinytest
#' @export
expect_count = as_expectation(checkmate::check_count)

#' @rdname checkmate.tinytest
#' @export
expect_data_frame = as_expectation(checkmate::check_data_frame)

#' @rdname checkmate.tinytest
#' @export
expect_data_table = as_expectation(checkmate::check_data_table)

#' @rdname checkmate.tinytest
#' @export
expect_date = as_expectation(checkmate::check_date)

#' @rdname checkmate.tinytest
#' @export
expect_directory_exists = as_expectation(checkmate::check_directory_exists)

#' @rdname checkmate.tinytest
#' @export
expect_disjunct = as_expectation(checkmate::check_disjunct)

#' @rdname checkmate.tinytest
#' @export
expect_double = as_expectation(checkmate::check_double)

#' @rdname checkmate.tinytest
#' @export
expect_environment = as_expectation(checkmate::check_environment)


#' @rdname checkmate.tinytest
#' @export
expect_factor = as_expectation(checkmate::check_factor)

#' @rdname checkmate.tinytest
#' @export
expect_file_exists = as_expectation(checkmate::check_file_exists)

#' @rdname checkmate.tinytest
#' @export
expect_flag = as_expectation(checkmate::check_flag)

#' @rdname checkmate.tinytest
#' @export
expect_formula = as_expectation(checkmate::check_formula)

#' @rdname checkmate.tinytest
#' @export
expect_function = as_expectation(checkmate::check_function)

#' @rdname checkmate.tinytest
#' @export
expect_int = as_expectation(checkmate::check_int)

#' @rdname checkmate.tinytest
#' @export
expect_integer = as_expectation(checkmate::check_integer)

#' @rdname checkmate.tinytest
#' @export
expect_integerish = as_expectation(checkmate::check_integerish)

#' @rdname checkmate.tinytest
#' @export
expect_list = as_expectation(checkmate::check_list)

#' @rdname checkmate.tinytest
#' @export
expect_logical = as_expectation(checkmate::check_logical)

#' @rdname checkmate.tinytest
#' @export
expect_matrix = as_expectation(checkmate::check_matrix)

#' @rdname checkmate.tinytest
#' @export
expect_multi_class = as_expectation(checkmate::check_multi_class)

#' @rdname checkmate.tinytest
#' @export
expect_named = as_expectation(checkmate::check_named)

#' @rdname checkmate.tinytest
#' @export
expect_names = as_expectation(checkmate::check_names)

#' @rdname checkmate.tinytest
#' @export
expect_number = as_expectation(checkmate::check_number)

#' @rdname checkmate.tinytest
#' @export
expect_numeric = as_expectation(checkmate::check_numeric)

#' @rdname checkmate.tinytest
#' @export
expect_path_for_output = as_expectation(checkmate::check_path_for_output)

#' @rdname checkmate.tinytest
#' @export
expect_posixct = as_expectation(checkmate::check_posixct)

#' @rdname checkmate.tinytest
#' @export
expect_r6 = as_expectation(checkmate::check_r6)

#' @rdname checkmate.tinytest
#' @export
expect_raw = as_expectation(checkmate::check_raw)

#' @rdname checkmate.tinytest
#' @export
expect_scalar = as_expectation(checkmate::check_scalar)

#' @rdname checkmate.tinytest
#' @export
expect_scalar_na = as_expectation(checkmate::check_scalar_na)

#' @rdname checkmate.tinytest
#' @export
expect_set_equal = as_expectation(checkmate::check_set_equal)

#' @rdname checkmate.tinytest
#' @export
expect_string = as_expectation(checkmate::check_string)

#' @rdname checkmate.tinytest
#' @export
expect_subset = as_expectation(checkmate::check_subset)

#' @rdname checkmate.tinytest
#' @export
expect_tibble = as_expectation(checkmate::check_tibble)
