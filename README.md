# Dapp（unbox 搭建）
### 整体流程，终于搞懂了，amazing~

    1.创建 Dapp 项目
    2.在项目中的 contracts 文件夹中编写合约
    3.在以太坊网络上部署合约，要交钱的，但是可以免费获取测试环境的以太币...
    4.本地编译合约，形成 .json 的 abi
    5.在前端调用
    sixsixsix~饿美zing~斯钙伊~
### 创建Dapp项目并部署合约

#### 1.安装 Node 

自行下载安装，node -v 查看版本信息，显示则安装成功

#### 2.安装以太坊客户端，即上面说的 Dapp

由于整个合约代码的执行需要一个虚拟的环境，所以需要安装一个以太坊虚拟机的节点，教程选择 TestRPC，就是  ganache-cli,然后连 truffle一起安装好:

`sudo npm install ganache-cli truffle` 注意 Windows 下不需要 sudo,sudo 是 Mac 下的权限

可查看版本信息确认是否安装好：

`npm ganache-cli -v `

`npm truffle -v `

#### 3.创建 Dapp 项目

创建空文件夹 react-unbox,注意一定是空文件夹，然后命令行：

`truffle unbox react-box`

静等5分钟...

#### 4.项目结构

安装好项目后，会看到 tuffle 自动创建好的文件夹。

`contracts`:编写智能合约的文件夹，所有智能合约都放置这这个里面

`migration`:部署合约配置的文件夹

`src`:React 的前端调用代码

`test`:智能合约测试用例文件夹

这里需要先编译一下，也可以后来再编译：

在命令行输入 `truffle compile` 

编译合约，会在项目根目录形成一个 build/contract/xxx.json 的 abi，用于前端调用

注意每次修改了智能合约后都需要重新部署和编译。

#### 5.编写智能合约，这个是最难的，公司项目花了两天两夜才勉勉强强写出来一个可用的 V1.0.0

在`contract`文件夹下创建 Voting.sol 文件，这个就是将来要部署到以太坊官网上的合约，所以代码要精简，因为是要钱的，老大今天跟我说他那个朋友部署一个合约花了1000多块钱，OMG~ 

下面是个例子，拷贝以下代码例子：

    pragma solidity ^0.4.18;

    contract SimpleStorage {
        uint storedData;

        function set(uint x) public {
            storedData = x;
        }

        function get() public view returns (uint) {
            return storedData;
        }
    }


#### 6.通过 remix + MetaMask 将写好的合约部署到 Ropsten Test Network

    1.在Google浏览器中安装 `MetaMask` 插件，小狐狸钱包，注册账号，记得账号在注册时会给你关键词，整个关键词一定要保存好！！！不能透漏给 他人，也为了以后找回密码啥的

    2.打开 [remix-IDE](http://remix2.ju3ban.net)将合约拷贝到里面，这个编辑器是国内的，比国际的那个好用，这个坑我也是搞了好久才跳出来，mmp,有时候真的需要前辈指导一下，会少跳很多坑。

##### 注意

    1.MetaMask 钱包一定是在线状态,并且一定要有一定的以太币支付给旷工

    2.确保 Environment 是 Injected Web3，如果切换不过来，关掉浏览器重新启动

如何搞到 Testnet 以太币，[查看链接](https://blog.csdn.net/fidelhl/article/details/52573274)

[官方](http://remix.ethereum.org/#optimize=false&version=soljson-v0.4.24+commit.e67f0147.js)的编辑器炸了,可改用[国内](http://remix2.ju3ban.net)的编辑器，也可以正常部署

##### 接着

    1.Compile 合约；
    
    2.点击 Run ,配置网络环境，选择`injected Web3`，意思是发布到公链，`Account` 是部署合约的钱包地址，也就是 狐狸的地址，（点击 浏览器的小狐狸插件，点击名字边上的 '...', 然后 点击 `Copy Address to clipboard`就会获得钱包地址），注意钱包里必须有钱！！！其他配置走默认。
    
    3.支付给矿工代币，等待一会儿会儿，显示 Success 之后，就完成部署了。
    
    4.回到编辑器的 Run 页面，会看到部署成功之后产生的合约信息，以及暴露的方法，注意，以后读取数据是免费的，如果是写入数据，还是需要代币！！！
    
### 前端调用

    1.上面部署完合约之后，记下合约地址，会到项目中，`src` 下就是前端代码这个项目前端是 React 的，查看 Vue 的，[戳-这个就是](https://github.com/cyhhao/eth-canvas)
    
    2.将部署好的合约也拷贝到 `/contracts` 文件夹下然后按上面说的， `truffle-compile 合约目录` 编译一下

然后在App.js中调用，下面代码仅供参考，真正可运行的代码以上面项目的代码为准:

上代码：

    import React, { Component } from 'react';
    import SimpleStorageContract from '../build/contracts/Orders.json';//  引入 turffle compile 生成的 ABI 文件 
    import getWeb3 from './utils/getWeb3';// 引入 web3，这个方便与以太坊节点进行交互，完全不用关心 JSON RPC 的实现细节，JSON RPC 是啥？就是与区块链数据交换的格式；
    import axios from 'axios';// 请求数据的轻量级 AJAX

    import './css/oswald.css'
    import './css/open-sans.css'
    import './css/pure-min.css'
    import './App.css'

    // 存储合约的地址（就是你在 remix 上部署好的合约地址）
    const contractAddress = "0x18518ba64e05d685b7239a3d3f0b963b369b305f";

    // 初始化合约实例
    const simpleStorageInstance = null;
    class App extends Component {
      constructor(props) {
        super(props)

        this.state = {
          storageValue: 0,
          web3: null,
          inputVal:''
        }
      }

      componentWillMount() {
        // 获取 web3 的实例
        getWeb3
        .then(results => {
          this.setState({
            web3: results.web3
          })
          this.instantiateContract()
        })
        .catch(() => {
          console.log('Error finding web3.')
        })
      }

      instantiateContract() {
        const { web3 } = this.state;
        // 引用 truffle-contract
        const contract = require('truffle-contract')// 编译合约的
        // 通过 abi 初始化合约对象
        const simpleStorage = contract(SimpleStorageContract)
        // 连接到以太坊的节点
        simpleStorage.setProvider(web3.currentProvider)

        console.log('连接成功', simpleStorage);
        // 获取账户列表.异步的
        web3.eth.getAccounts((error, accounts) => {
          console.log('账户列表', accounts)
          simpleStorage.at(contractAddress).then((instance) => {
            simpleStorageInstance = instance
            console.log('合约实例创建成功',simpleStorageInstance);
            // 调用合约中的 writeOrder() 方法,设置一个值
            return simpleStorageInstance.writeOrder(37249608,'cxh',1528878748, '15931662302', '1380', '12', {from: web3.eth.accounts[0]});
          }).then((result) => {
            console.log(result);
            return simpleStorageInstance.writeOrder(37249609,'hxc',9285870876, '15931662302', '1380', '12', {from: web3.eth.accounts[0]});
          }).then((result) => {
            // 调用合约中的 get() 方法,获取值
            console.log(result)
            return simpleStorageInstance.readOrder.call(37249608);
          }).then((result) => {
            // 改变前端视图
            console.log(result);
            return this.setState({ storageValue: 123 });
          })
        })
      }

    oninputchange = (e) => {
      console.log(e.target.value);
      this.setState({
        storageValue:e.target.value
      })
    }
      render() {
        const { storageValue } = this.state;
        return (
          <div className="App">
            <div>cxh肝的第一个以太坊小demo</div>
            <main className="container">
              <div className="pure-g">
                <input
                  type="text"
                  value={storageValue}
                  onChange={this.oninputchange}
                />
                <button
                  onClick={this.writeAndsetNumber}
                  >点击设置介个数字</button>
              </div>
            </main>
          </div>
        );
      }
    }

    export default App;


    

### 补充一点，solidity 的东西

上面的那些都是小菜，下面的才是真正难的（相对来说，毕竟难者不会，会者不难

那就是 Solidity 

语法对于这个没有后端基础的我，很是懵逼。整理一下常用的搞一搞。

下面这个是一个小的合约实例，开始真的憋坏我，看文档看了就跟没看一样，抬手就不会写，后来机智如我，先将我的需求用 js 写出来，然后有目的的写 solidity,果然就好多啦，于是有了下面这个 V1.0.0 版本，注释略粗糙，旨在能看得懂简单代码，以后会系统学习 solidity 语法，到时再整理笔记：

	pragma solidity ^0.4.24;// 声明 solidity 的版本
	contract Orders {// 定义一个合约名字叫 Orders

		// struct 是一种变量的类型，叫结构体，可以简单的理解为 js 中的对象类型
		struct Order{
			// 声明变量
			string uin;//  string 类型
			string name;
			uint16 ctime;// 无符号整型，长度为16
			string phone;
			string price;
			string lease_time;
		}

		Order[] public Orderlist;// solidity 里的一种数据类型，可以理解为 js 中的数组 

		// 在合约部署完成后，需要修改，用 getAddress 方法
		address owenr = 0x348d80a445a4ffad846b491c5c673711a9ba74e8;// 用户 address 是 solidity 里的数据格式，表示用户地址 
		address user = getAddress();// owner: 0xa7d4831d700991304d690a078c6e65c5c281492c

		// 声明一个方法，此方法的权限是 public,意为可供外部调用的方法，返回一个 Boolean 类型的值
		function isOwner() public view returns (bool) {
			return address(owenr) == address(user);
		}

		function getAddress() public view returns (address) {
			return msg.sender;
		}

		// 写操作
		function writeOrder(string order_id, string user_name, uint16 ctime, string phone, string price, string lease_time) public view returns (string rusult){
			if (isOwner()) {
			// 管理员，可不限时间修改
				Orderlist.push(Order({
					uin: order_id,
					name: user_name,
					ctime: ctime,
					phone: phone,
					price: price,
					lease_time: lease_time
				}));
				return '写入成功';
			} else {
				return '您暂时没有此权限';
			}

		}

		// 读操作
		function readOrder(uint8 index) public view returns (string, string, uint16, string, string, string) {
			// uint8 index = getIndex(order_id);
			if (Orderlist.length==0){
				return ('暂无数据', '暂无数据', 12345, '暂无数据', '暂无数据', '暂无数据');
			} else {
				Order storage result = Orderlist[index];
				return (result.uin, result.name, result.ctime, result.phone, result.price, result.lease_time);
			}

		}

	}

以上，就是一个以太坊 Dapp 的开发流程。进一步了解如何部署到公链，异步 Dapp-node 项目
