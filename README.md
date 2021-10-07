Obfuscation LLVM 13.0
===========

### 编译
```
cd obfuscator
mkdir build
cd build

# 关闭编译测试用例: -DLLVM_INCLUDE_TESTS=OFF 
# 关闭使用 NewPassManager 来生成代码: -DLLVM_ENABLE_NEW_PASS_MANAGER=OFF
cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_CREATE_XCODE_TOOLCHAIN=ON -DLLVM_ENABLE_NEW_PASS_MANAGER=OFF -DLLVM_INCLUDE_TESTS=OFF ..
make -j7
```

LLVM 13.0 开始默认启用 `NewPassManager`，使用旧有的方式集成代码后，生成的工具链使用时混淆功能 **不会生效**。

> 因为 CGOpts.LegacyPassManager 配置为 NO, 所以代码执行的时候旧的实现逻辑不会走，可以在 BackendUtil.cpp 中搜索 EmitAssemblyWithNewPassManager 找到相关代码。

临时的解决方法是编译时使用 `-DLLVM_ENABLE_NEW_PASS_MANAGER=OFF` 关闭使用 `NewPassManager`，使用 `LegacyPassManager`。

### 混淆模式

#### 控制流扁平化
这个模式主要是把一些if-else语句，嵌套成do-while语句

* -mllvm -fla：激活控制流扁平化
* -mllvm -split：激活基本块分割。在一起使用时改善展平。
* -mllvm -split_num=3：如果激活了传递，则在每个基本块上应用3次。默认值：1

#### 指令替换
这个模式主要用功能上等效但更复杂的指令序列替换标准二元运算符(+ , – , & , | 和 ^)

* -mllvm -sub：激活指令替换
* -mllvm -sub_loop=3：如果激活了传递，则在函数上应用3次。默认值：1

#### 虚假控制流程
这个模式主要嵌套几层判断逻辑，一个简单的运算都会在外面包几层if-else，所以这个模式加上编译速度会慢很多因为要做几层假的逻辑包裹真正有用的代码。

这个模式编译的时候要浪费相当长时间！

* -mllvm -bcf：激活虚假控制流程
* -mllvm -bcf_loop=3：如果激活了传递，则在函数上应用3次。默认值：1
* -mllvm -bcf_prob=40：如果激活了传递，基本块将以40％的概率进行模糊处理。默认值：30

#### 字符串加密
将明文字符串加密，目前实现暂时只支持局部变量的字符串加密，全局的貌似没效果，有能力可以参考 [Hikari](https://github.com/HikariObfuscator/Core) 优化一下。

* -mllvm -sobf：激活字符串加密

### 使用方式

#### 直接使用

```
build/bin/clang test.c -o test -mllvm -sub -mllvm -fla -mllvm -bcf
```

#### 集成到Xcode
```
# 生成工具链
sudo make install-xcode-toolchain

# 将工具链移动到开发者目录，以便集成到xcode
mv /usr/local/Toolchains  /Library/Developer/
```

* 选择新的工具链，`Xcode -> Toolchains -> org.llvm.13.0.0`
* 在目标工程编译设置中将 `Enable Index-While-Building` 改成 `NO`
* 在目标工程编译设置中设置 `Other C Flags`，填入需要的混淆模式，如：`-mllvm -sub -mllvm -fla -mllvm -bcf`

### 参考资料
* [HikariObfuscator](https://github.com/HikariObfuscator/)
* [Armariris](https://github.com/GoSSIP-SJTU/Armariris)
* [OLLVM代码混淆移植与使用](https://www.jianshu.com/p/e0637f3169a3)
* [llvm-pass-tutorial](https://github.com/LeadroyaL/llvm-pass-tutorial)
* [编写LLVM Pass模块知识点梳理](https://blog.csdn.net/u010940020/article/details/99721684)

