# Prorsumの作者のnoppoManさんにProrsumのインストールの仕方を教えてもらった時のメモ

Terminal.appを開いて
以下のコマンドを打つ

```
$ mkdir ProrsumSample
$ cd ProrsumSample
$ swift package init
$ vim Package.swift
```

Package.swiftを以下のように編集

```
import PackageDescription

let package = Package(
    name: "ProrsumSample",
    dependencies: [
        .Package(url: "https://github.com/noppoMan/Prorsum.git", majorVersion: 0, minor: 1),
    ]
)
```

ESC押して、:wqのvimコマンドで、Package.swiftを保存して閉じる

```
$ swift build
$ vim Sources/main.swift
```
Sources/main.swiftを以下のように編集する

``` swift
import Prorsum
import Foundation

let server = try! HTTPServer { (request, writer) in
    do {
        let response = Response(
            headers: ["Server": "Prorsum Micro HTTP Server"],
            body: .buffer("hello Server Side Swift".data)
        )

        try writer.serialize(response)

        writer.close()
    } catch {
        fatalError("\(error)")
    }
}

try! server.bind(host: "0.0.0.0", port: 3000)
print("Server listening at 0.0.0.0:3000")
try! server.listen()

RunLoop.main.run()
```

ESC押して、:wqのvimコマンドで、Sources/main.swiftを保存して閉じる

Terminal.appを開いて
以下のコマンドを打つ

```
$ swift build
$ .build/debug/ProrsumSample
```

最後の.build/debug/ProrsumSampleは、プロジェクト名に合わせて変えてく:wqださいとのこと

Terminal.appで、サーバー立ち上げたまま、Command+Tでタブを開き、
gnuplotをインストールする

```
$ brew install gnuplot
$ vim apache-benchmark.p
```

apache-benchmark.p

```
# output as png image
set terminal png

# save file to "benchmark.png"
set output "benchmark.png"

# graph title
set title "ab -n 10000 -c 100 -g out.data http://127.0.0.1:3000/"

#nicer aspect ratio for image size
set size 1,0.7

# y-axis grid
set grid y

#x-axis label
set xlabel "request"

#y-axis label
set ylabel "response time (ms)"

#plot data from "out.data" using column 9 with smooth sbezier lines
plot "out.data" using 9 smooth sbezier with lines title "something"
```

ESC押して、:wqのvimコマンドで、apache-benchmark.pを保存して閉じる

```
$ gnuplot apache-benchmark.p
$ open benchmark.png
```

