test_that("character comparison", {
  verify_output(test_path("test-compare-value-chr.txt"), {
    "no difference"
    compare_character(c("a", "b"), c("a", "b"))

    "single change"
    compare_character(c("a", "b", "c"), c("a", "b"))
    compare_character(c("a", "b"), c("a", "b", "c"))
    compare_character(c("a", "B", "c"), c("a", "b", "c"))

    "multiple contexts"
    compare_character(
      c("a", "b", letters, "a", "b", "c", letters, "X"),
      c("a", "b", "c", letters, "a", "b", letters, "Y")
    )

    "truncation"
    compare_character(c("X", letters), letters)
    compare_character(c(letters, "X"), letters)

    "large diff"
    compare(letters, c(letters[1:20], "a"))
  })
})

test_that("multiline comparison", {
  verify_output(test_path("test-compare-value-lines.txt"), {
    compare_character("A\nthe apple is red\nC\n", "A\nthe apple was red\nC\n")
    compare_character("A\nthe apple is red and green\nC\n", "A\nthe apple is red\nC\n")
    compare_character("A\nthe apple is red and green\nC\n", "A\nI like bananas\nC\n")

    "trailing newlines are correctly compared"
    compare("x\n", "x")
  })
})

test_that("numeric comparison", {
  verify_output(test_path("test-compare-value-num.txt"), {
    "no difference"
    compare_numeric(1:3, 1:3)
    compare_numeric(c(1, NA), c(1, NA))
    compare_numeric(c(NA, 1), c(1, NA))

    "simple change"
    compare_numeric(c(1, 2, 3), c(1, 2))
    compare_numeric(c(1, 2), c(1, 2, 3))
    compare_numeric(c(1, 10, 3), c(1, 2, 3))

    "equal length"
    x <- c(1, 2, 3)
    compare_numeric(x, x + c(-1, 0, 1) * 1e-3)
    compare_numeric(x, x + c(-1, 0, 1) * 1e-4)
    compare_numeric(x, x + c(-1, 0, 1) * 1e-5)
    compare_numeric(x, x + c(-1, 0, 1) * 1e-6)
    compare_numeric(x, x + c(-1, 0, 1) * 1e-7)
    compare_numeric(x, x + c(-1, 0, 1) * 1e-8)
    compare_numeric(x, x + c(-1, 0, 1) * 1e-8, tolerance = 0)
    compare_numeric(x, x + c(-1, 0, 1) * 1e-9, tolerance = 0)
    compare_numeric(x, x + c(-1, 0, 1) * 1e-10, tolerance = 0)

    "unequal length"
    compare_numeric(c(1, 2, NA), c(1, 2 + 1e-7, NA, 3))
  })
})
