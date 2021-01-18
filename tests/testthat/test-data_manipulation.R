ships <- read.csv("../../data/ships.csv")
DUMMY <- read.csv("./DUMMY.csv")

# subsetShip
test_that("subsetting specific ships works", {
  result <- subsetShip(ships, "LEB-7")
  result <- result$SHIPNAME
  result <- unique(result)
  expect_equal(result, "LEB-7")
})

# addCoordinates
test_that("coordinates are added", {
  result <- addCoordinates(subsetShip(ships, "LEB-7"))
  result <- names(result)
  result_lon <- "lon_two" %in% result
  result_lat <- "lat_two" %in% result
  expect_true(result_lon)
  expect_true(result_lat)
})

# computeDistance
test_that("distance is computed correctly", {
  result <- computeDistance(addCoordinates(subsetShip(ships, "LEB-7")))
  result <- unname(result$dist)
  expect_equal(result, 2222.503)
})

# selectLatest
test_that("latest observation is selected", {
  result <- selectLatest(DUMMY)
  result <- result$date
  result <- result[1]
  expect_equal(result, "20/12/2017")
})
