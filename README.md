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

由于整个合约代码的执行需要一个虚拟的环境，所以需要安装一个是新以太坊虚拟机的节点，教程选择 TestRPC，现在已经改名字叫 ganache-cli,然后连 truffle一起安装好:

`sudo npm install ganache-cli truffle` 

可查看版本信息确认是否安装好

#### 3.创建 Dapp 项目

创建空文件夹 react-box,注意一定是空文件夹，然后命令行：

`truffle unbox react-box`

静等5分钟...

#### 4.项目结构

安装好项目后，会看到 tuffle 自动创建好的文件夹，就像 create-react-app 一样。

`contracts`:编写智能合约的文件夹，所有智能合约都放置这这个里面

`migration`:部署合约配置的文件夹

`src`:React 的前端调用代码

`test`:只能合约测试用例文件夹

这里需要先编译一下，也可以后来再编译：

在命令行输入 `truffle compile` 

编译合约，会在项目根目录形成一个 build/contract/xxx.json 的 abi，用于前端调用

注意每次写好智能合约都需要重新部署和编译

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

    1.在Google浏览器中安装 `MetaMask` 插件，小狐狸钱包，注册账号，记得账号在注册时会给你关键词，整个关键词一定要保存好！！！为了以后找回密码啥的

    2.打开 [remix-IDE](http://remix2.ju3ban.net)将合约拷贝到里面，这个编辑器是国内的，比国际的那个好用，这个坑我也是搞了好久才跳出来，mmp,有时候真的需要前辈指导一下，会少跳很多坑。

##### 注意

    1.MetaMask钱包一定是在线状态,并且一定要有一定的以太币支付给旷工

    2.确保Environment是Injected Web3，如果切换不过来，关掉浏览器重新启动

如何搞到 Testnet 以太币，[查看链接](https://blog.csdn.net/fidelhl/article/details/52573274)

[官方](http://remix.ethereum.org/#optimize=false&version=soljson-v0.4.24+commit.e67f0147.js)的编辑器炸了,可改用[国内](http://remix2.ju3ban.net)的编辑器，也可以正常部署

##### 接着

    1.Compile 合约；
    
    2.点击 Run ,配置网络环境，选择`injected Web3`，意思是发布到公链，`Account` 是部署合约的钱包地址，也就是 狐狸的地址，（点击 浏览器的小狐狸插件，点击名字边上的 '...', 然后 点击 `Copy Address to clipboard`就会获得钱包地址），注意钱包里必须有钱！！！其他配置走默认。
    
    3.支付给矿工代币，等待一会儿会儿，显示 Success 之后，就完成部署了。
    
    4.回到编辑器的 Run 页面，会看到部署成功之后产生的合约信息，以及暴露的方法，注意，以后读取数据是免费的，如果是写入数据，还是需要代币！！！
    
### 前端调用

    1.上面部署完合约之后，记下合约地址，会到项目中，`src` 下就是前端代码这个项目前端是 React 的，查看 Vue 的，[戳-这个就是](https://github.com/cyhhao/eth-canvas)
    
    2.将部署好的合约也拷贝到 `/contracts` 文件夹下然后按上面说的， `truffle-compile` 编译一下

然后在App.js中调用:

    

### 然后重点来了，前方高能！！！！

上面的那些都是小菜，下面的才是真正难的（相对来说，毕竟难者不会，会者不难

那就是 Solidity 

语法对于这个没有后端基础的我，很是懵逼。整理一下常用的搞一搞。

下面这个是
