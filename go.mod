module github.com/yanjingang/riot

require (
	github.com/AndreasBriese/bbloom v0.0.0-20180913140656-343706a395b7
	// github.com/BurntSushi/toml v0.3.0
	github.com/StackExchange/wmi v0.0.0-20180725035823-b12b22c5341f
	// github.com/coreos/etcd v3.3.10+incompatible // indirect
	// github.com/coreos/bbolt v1.3.0
	// github.com/coreos/etcd v3.3.9+incompatible
	github.com/dgraph-io/badger v1.5.4
	github.com/dgryski/go-farm v0.0.0-20180109070241-2de33835d102
	github.com/fsnotify/fsnotify v1.4.7
	github.com/go-ego/gpy v0.0.0-20181128170341-b6d42325845c
	github.com/go-ego/gse v0.0.0-20190531154331-cad84f3c1a94
	github.com/go-ego/murmur v0.0.0-20181129155752-fac557227e04
	github.com/go-ole/go-ole v1.2.1
	github.com/go-vgo/grpclb v0.0.0-20181128171039-89526b0a742e
	github.com/go-vgo/gt v0.0.0-20181207163017-e40d098f9006
	github.com/gogo/protobuf v1.1.1
	// github.com/golang/lint v0.0.0-20181026193005-c67002cb31c3 // indirect
	github.com/golang/protobuf v1.2.0
	github.com/golang/snappy v0.0.0-20180518054509-2e65f85255db
	github.com/pelletier/go-toml v1.2.0
	github.com/pkg/errors v0.8.0
	github.com/shirou/gopsutil v2.18.11+incompatible
	github.com/syndtr/goleveldb v0.0.0-20181128100959-b001fa50d6b2
	github.com/vcaesar/tt v0.0.0-20190311143935-d2abd51da7af
	//github.com/go-ego/gpy v0.0.0-20181128170341-b6d42325845c
	github.com/yanjingang/gpy v0.0.0-20190603131731-6c748fd36146
	// github.com/go-ego/gse v0.0.0-20190129002529-45bfc8a37d9a
	github.com/yanjingang/gse v0.0.0-20190603131105-4e1b9272e1bc
	github.com/yincongcyincong/proxy-web v0.0.0-20190211080025-041af66fdf9a // indirect
	// not github
	go.etcd.io/bbolt v1.3.1-etcd.7
	go.etcd.io/etcd v3.3.10+incompatible
	// golang.org/x/lint v0.0.0-20181026193005-c67002cb31c3 // indirect
	golang.org/x/net v0.0.0-20181207154023-610586996380
	google.golang.org/grpc v1.17.0
// honnef.co/go/tools v0.0.0-20180920025451-e3ad64cb4ed3 // indirect
)

replace (
	go.etcd.io/bbolt v1.3.1-etcd.7 => github.com/etcd-io/bbolt v1.3.1-etcd.7
	go.etcd.io/etcd v3.3.10+incompatible => github.com/etcd-io/etcd v3.3.10+incompatible
	golang.org/x/net v0.0.0-20181114220301-adae6a3d119a => github.com/golang/net v0.0.0-20181114220301-adae6a3d119a
	golang.org/x/sys v0.0.0-20181122145206-62eef0e2fa9b => github.com/golang/sys v0.0.0-20181122145206-62eef0e2fa9b
	golang.org/x/text v0.3.0 => github.com/golang/text v0.3.0
	google.golang.org/grpc v1.17.0 => github.com/grpc/grpc-go v1.17.0
)
