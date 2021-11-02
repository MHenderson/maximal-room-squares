library(testthat)

expect_equal(remove_all_if_exist_G(combn(1:3, 2, simplify = FALSE), 1), list(c(2, 3)))

expect_equal(remove_all_if_exist_G(combn(1:3, 2, simplify = FALSE), 1:3), list())

expect_equal(remove_all_if_exist_G(combn(1:9, 2, simplify = FALSE), 1:3), combn(4:9, 2, simplify = FALSE))

expect_equal(remove_all_if_exist_G(combn(1:9, 2, simplify = FALSE), list()), combn(1:9, 2, simplify = FALSE))

expect_equal(remove_all_if_exist_G(combn(1:9, 2, simplify = FALSE), 1:9), list())
