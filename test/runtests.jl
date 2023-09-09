using Test
using ReadLIBSVM
using Downloads: download

# wine.scale
path = download("https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/multiclass/wine.scale")
d1 = read_libsvm(path)
raw = read(path)
d2 = read_libsvm(raw)
@test d1 == d2
@test sort(unique(d1[:y])) == [1, 2, 3]

# breast-cancer
path = download("https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/breast-cancer")
d1 = read_libsvm(path)
raw = read(path)
d2 = read_libsvm(raw)
@test d1 == d2
@test sort(unique(d1[:y])) == [2, 4]

# breast-cancer_scale
path = download("https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/breast-cancer_scale")
d1 = read_libsvm(path)
raw = read(path)
d2 = read_libsvm(raw)
@test d1 == d2
@test sort(unique(d1[:y])) == [2, 4]

# bodyfat
path = download("https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/regression/bodyfat")
d1 = read_libsvm(path)
raw = read(path)
d2 = read_libsvm(raw)
@test d1 == d2

# bodyfat_scale
path = download("https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/regression/bodyfat_scale")
d1 = read_libsvm(path)
raw = read(path)
d2 = read_libsvm(raw)
@test d1 == d2
