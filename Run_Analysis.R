x1 <- read.table("X_train.txt")
x2 <- read.table("X_test.txt")
X <- rbind(x1, x2)

s1 <- read.table("subject_train.txt")
s2 <- read.table("subject_test.txt")
S <- rbind(s1,s2)

y1 <- read.table("y_train.txt")
y2 <- read.table("y_test.txt")
Y <- rbind(y1, y2)

var <- read.table("features.txt")
names(X) <- var$V2
features <- grep("-mean\\(\\)|-std\\(\\)", var[, 2])
X <- X[, features]


activities <- read.table("activity_labels.txt")

Y[,1] = activities[Y[,1], 2]
names(Y) <- "Activity"
names(S) <- "Subjects"

data <- cbind(S,Y, X)


uniqueSubjects = unique(S)[,1]
numSubjects = length(unique(S)[,1])
numActivities = length(activities[,1])
numCols = dim(data)[2]
result = data[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
  for (a in 1:numActivities) {
    result[row, 1] = uniqueSubjects[s]
    result[row, 2] = activities[a, 2]
    tmp <- data[data$Subjects==s & cleaned$Activity==activities[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
