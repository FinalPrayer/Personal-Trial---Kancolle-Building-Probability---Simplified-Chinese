import Cocoa
/*
    舰娘 - 出货计算算法
本程序用于给所有未出过货的人提供正能量，计算出绝对能出货的次数。
使用最基本的概率模型，先求出不能出货的次数，再通过概率减除，得出绝对能出货的次数。
*/

//为了防止不必要的运算浪费电脑资源，设置开关
//0 = off, 1 = on
let onoff = 1

//设置基本变量
//最大测试次数
let maxtests = 999
//假设最非洲概率
let african_value = 0.995
//输入大和的建造报告
let 伞级使用模型 = "4000 6000 6000 2000 +20"
let 大和成功次数 = 1057
let 武藏成功次数 = 1063
let 四六六二尝试次数 = 40686
let 伊401使用公式 = "4000 6000 6000 2000 +1"
let 伊401成功次数 = 685
let 伊401尝试次数 = 15534
let Bismarck使用公式 = "4000 6000 7000 2000 +20"
let Bismarck成功次数 = 516
let Bismarck尝试次数 = 7302
let 大凤使用公式 = "4000 2000 5000 5200 +20"
let 大凤成功次数 = 587
let 大凤尝试次数 = 11935





/*
函数区域
这里用于放置制作概率模型需要用到的函数。
*/
func failprobs(timesuccess: Double, timetrial: Double) -> Double {
    let probability = timesuccess / timetrial
    let fail_prob = 1 - probability
    return fail_prob
}
func successProb(failprobs: Double, attemp: Double) -> Double {
    let fails = pow(failprobs, attemp)
    let success = 1 - fails
    return success
}

//运算区域
if onoff == 1{
    //放置变量
    var african_yamato = 0
    var african_musou = 0
    var african_umbrella = 0
    var african_i401 = 0
    var african_bismarck = 0
    var african_taihou = 0
    //数据转换
    let yamato_success = Double(大和成功次数)
    let musou_success = Double(武藏成功次数)
    let fsst_attemp = Double(四六六二尝试次数)
    let i401_success = Double(伊401成功次数)
    let i401_attemp = Double(伊401尝试次数)
    let Bismarck_success = Double(Bismarck成功次数)
    let Bismarck_attemp = Double(Bismarck尝试次数)
    let taihou_success = Double(大凤成功次数)
    let taihou_attemp = Double(大凤尝试次数)
    println("伞级使用模型: \(伞级使用模型)")
    //大和模型
    for index in 1...maxtests {
        var attemps = Double(index)
        var 大和成功模型 = successProb(failprobs(yamato_success, fsst_attemp), attemps)
        if 大和成功模型 > african_value {
            african_yamato = index
            println("大和成功次数：\(african_yamato) 次")
            break
        }
    }
    //武藏模型
    for index in 1...maxtests {
        var attemps = Double(index)
        var 武藏成功模型 = successProb(failprobs(musou_success, fsst_attemp), attemps)
        if 武藏成功模型 > african_value {
            african_musou = index
            println("武藏成功次数：\(african_musou) 次")
            break
        }
    }
    //由于伞级使用同一条公式（4000 6000 6000 2000 +20），合并在一起。
    if african_yamato == african_musou {
        african_umbrella = african_yamato
        println("使用同样公式，大和和武藏次数一样，取\(african_umbrella)次\n")
    } else if (african_yamato > african_musou) {
        african_umbrella = african_yamato
        println("使用同样公式，大和需要比武藏多，取\(african_umbrella)次\n")
    } else {
        african_umbrella = african_musou
        println("使用同样公式，武藏需要比大和多，取\(african_umbrella)次\n")
    }
    //伊401模型
    println("伊401使用模型: \(伊401使用公式)")
    for index in 1...maxtests {
        var attemps = Double(index)
        var 伊401成功模型 = successProb(failprobs(i401_success, i401_attemp), attemps)
        if 伊401成功模型 > african_value {
            african_i401 = index
            println("伊401成功次数：\(african_i401) 次\n")
            break
        }
    }
    //Bismarck模型
    println("Bismarck使用模型: \(Bismarck使用公式)")
    for index in 1...maxtests {
        var attemps = Double(index)
        var Bismarck成功模型 = successProb(failprobs(Bismarck_success, Bismarck_attemp), attemps)
        if Bismarck成功模型 > african_value {
            african_bismarck = index
            println("Bismarck成功次数：\(african_bismarck) 次\n")
            break
        }
    }
    //大凤模型
    println("大凤使用模型: \(大凤使用公式)")
    for index in 1...maxtests {
        var attemps = Double(index)
        var 大凤成功模型 = successProb(failprobs(taihou_success, taihou_attemp), attemps)
        if 大凤成功模型 > african_value {
            african_taihou = index
            println("大凤成功次数：\(african_taihou) 次\n")
            break
        }
    }
    let graduate = african_umbrella + african_i401 + african_bismarck + african_taihou
    println("假设运气一直呈现最非洲状态(成功率达到\(african_value*100)%)")
    println("将需要跟着玄学公式，大建\(graduate)次才能毕业")
}
