//
//  NSURLs.h
//  Waistcoat
//
//  Created by zhy on 2017/9/14.
//  Copyright © 2017年 zhy. All rights reserved.
//

#ifndef NSURLs_h
#define NSURLs_h

#define checkHost @"www.baidu.com" //检查网络是否可达

//全部  &type=0 1 2
#define FastNewsAll @"http://114.215.192.70/v3/league/newsflash?a8id=135715701397&channel=AppStore&os_ver=11.0&pageSize=20&platform=iOS&sign=ebfd4da2592e74e17f453392bfa957d5&time=1508747612&token=&uid=135715701397&version=234"


#define kTeamDetailMain @"http://118.178.1.136/v2/data/team/detail?a8id=180719461717&channel=AppStore&os_ver=11.0&platform=iOS&sign=de6f656bae5b839e4f354cf1da4b534c&time=1508306629&token=&uid=180719461717&version=234"
//赛程
#define kTeamDetailSC @"http://118.178.1.136/v3/team/games?a8id=180719461717&channel=AppStore&os_ver=11.0&pageSize=20&platform=iOS&sign=de6f656bae5b839e4f354cf1da4b534c&time=1508306629&token=&uid=180719461717&version=234"

//新闻
#define kTeamDetailNews @"http://118.178.1.136/v3/follow/team_news?a8id=180719461717&channel=AppStore&os_ver=11.0&page=0&pageSize=20&platform=iOS&sign=d12526abd739566fe54e95023a47d719&time=1508306806&token=&type=0&uid=180719461717&version=234"

//动态
#define kTeamAvtive @"http://118.178.1.136/v3/follow/team_news?a8id=180719461717&channel=AppStore&os_ver=11.0&page=0&pageSize=20&platform=iOS&sign=825e8876c5b980b224907847217148bf&teamId=cavaliers&time=1508306855&token=&type=1&uid=180719461717&version=234"
//球员
#define kTeamDetailPlayer @"http://cdn2.fungotv.com/a8_sport/data/player-list.html"

#define KTeamData @"http://121.40.193.144/v3/follow/team_list?a8id=180719461717&channel=AppStore&os_ver=11.0&platform=iOS&sign=142961417223862231880284fa339d2b&time=1508290237&token=&type=normal&uid=180719461717&version=234"

//热门
#define kHot @"http://118.178.1.136/v3/league/newsList?a8id=115417601971&channel=AppStore&leagueIds=104%2C1%2C4%2C2%2C6%2C9%2C3%2C5%2C8%2C7%2C108&leagueTags=4%2C6%2C7%2C8&os_ver=11.0&pageSize=20&platform=iOS&sign=3e86f478524ed4b5ec3a4019bcee6ea0&time=1506733865&token=&type=1&uid=115417601971&version=234"

//视频
#define KVideoUrl @"http://118.178.1.136/right/news/news_list?a8id=135715701397&channel=AppStore&os_ver=11.0&pageSize=20&platform=iOS&sign=97df96b4ee4c9ef9a3674e45f8bf916d&time=1508728685&title=%E8%A7%86%E9%A2%91&token=&type=3&uid=135715701397&version=234"

//集锦
#define kVideoHighlight  @"http://118.178.1.136/v3/game/videoList?a8id=115417601971&channel=AppStore&os_ver=11.0&pageSize=20&platform=iOS&sign=0edccf16ca77c08738d54f05c303f19e&time=1507530420&token=&uid=115417601971&version=234"

//专题
#define KspecialTopicUrl @"http://118.178.1.136/v3/topic/list?a8id=135715701397&channel=AppStore&os_ver=11.0&pageSize=9999&platform=iOS&sign=194cf66bb2c10e2c70549e532b5e031a&time=1508728577&token=&uid=135715701397&version=234"

//欧冠
#define OUGUANUrl @"http://118.178.1.136/v3/league/newsList?a8id=135715701397&channel=AppStore&id=8&leagueId=8&os_ver=11.0&pageSize=20&platform=iOS&sign=a71e9770ad18cc28f1afb728c3e517a7&tag=2&time=1508728652&title=%E6%AC%A7%E5%86%A0&token=&type=0&uid=135715701397&version=234"

//竞彩
#define kSMG @"http://118.178.1.136/v3/league/newsList?a8id=115417601971&channel=AppStore&id=104&leagueId=104&os_ver=11.0&pageSize=20&platform=iOS&sign=5c806df5a79f5c8fd722bb78d17caf31&tag=2&time=1507533799&title=%E7%AB%9E%E5%BD%A9&token=&type=0&uid=115417601971&version=234"


//国足
#define kChinaFootBall @"http://118.178.1.136/v3/league/newsList?a8id=115417601971&channel=AppStore&id=6&os_ver=11.0&pageSize=20&platform=iOS&sign=b3033b32fdf2a4d16d6e13fe15b6934c&tag=1&tagId=6&time=1507533056&title=%E4%B8%AD%E5%9B%BD%E8%B6%B3%E7%90%83&token=&type=0&uid=115417601971&version=234"

//法甲
#define F_JIA @"http://118.178.1.136/v3/league/newsList?a8id=135715701397&channel=AppStore&id=7&leagueId=7&os_ver=11.0&pageSize=20&platform=iOS&sign=4d0da4eb95917541447b30add8ef4f82&tag=2&time=1508728800&title=%E6%B3%95%E7%94%B2&token=&type=0&uid=135715701397&version=234"

//意甲
#define YI_JIA @"http://118.178.1.136/v3/league/newsList?a8id=135715701397&channel=AppStore&id=5&leagueId=5&os_ver=11.0&pageSize=20&platform=iOS&sign=dd548156b1165e72b75be0ac2563458b&tag=2&time=1508728844&title=%E6%84%8F%E7%94%B2&token=&type=0&uid=135715701397&version=234"

//德甲
#define DE_JIA @"http://118.178.1.136/v3/league/newsList?a8id=135715701397&channel=AppStore&id=3&leagueId=3&os_ver=11.0&pageSize=20&platform=iOS&sign=dc82dff50dbc66211c0ca24ab193019a&tag=2&time=1508728890&title=%E5%BE%B7%E7%94%B2&token=&type=0&uid=135715701397&version=234"

//中超
#define ZHONG_CHAO @"http://118.178.1.136/v3/league/newsList?a8id=135715701397&channel=AppStore&id=9&leagueId=9&os_ver=11.0&pageSize=20&platform=iOS&sign=f40ba3225caa4d443a58efc4c49c66cb&tag=2&time=1508728922&title=%E4%B8%AD%E8%B6%85&token=&type=0&uid=135715701397&version=234"

//西甲
#define XI_JIA @"http://118.178.1.136/v3/league/newsList?a8id=135715701397&channel=AppStore&id=6&leagueId=6&os_ver=11.0&pageSize=20&platform=iOS&sign=d8332d6e84bbffcf906a191b920e6993&tag=2&time=1508728966&title=%E8%A5%BF%E7%94%B2&token=&type=0&uid=135715701397&version=234"

//CBA
#define K_CBA @"http://118.178.1.136/v3/league/newsList?a8id=135715701397&channel=AppStore&id=2&leagueId=2&os_ver=11.0&pageSize=20&platform=iOS&sign=f15b2dd22880db45a74c737995d06aa4&tag=2&time=1508729010&title=CBA&token=&type=0&uid=135715701397&version=234"

//英超
#define YING_CHAO @"http://118.178.1.136/v3/league/newsList?a8id=135715701397&channel=AppStore&id=4&leagueId=4&os_ver=11.0&pageSize=20&platform=iOS&sign=fa1cbd9120025511d86ee053a382983e&tag=2&time=1508729050&title=%E8%8B%B1%E8%B6%85&token=&type=0&uid=135715701397&version=234"

//NBA
#define K_NBA @"http://118.178.1.136/v3/league/newsList?a8id=135715701397&channel=AppStore&id=1&leagueId=1&os_ver=11.0&pageSize=20&platform=iOS&sign=885003aebf3db3b06375d102ea89a37e&tag=2&time=1508729272&title=NBA&token=&type=0&uid=135715701397&version=234"

#define kHotDetail @"http://a8.tvesou.com/right/news/news_html?a8id=115417601971&channel=AppStore&os_ver=11.0&platform=iOS&sign=1190ed8cad12a0eef425bcdb64c324f3&time=1506780665&token=&uid=115417601971&version=234&zId="

#define kHotDetailComment @"http://pinglun.a8tiyu.com/comment/hotNew?channel=AppStore&hotNum=20&machineCode=e85ae7f61b563f361677d5f64acb823396a9b028&newNum=30&os_ver=11.0&platform=iOS&sign=5a7817d12e3057b6a55a4e31a198d635&time=1506780977&userId=115417601971&userIp=110.188.59.231&userLogo=&userNickname=&version=234&zId="

#define kHotVideoDetailComment @"http://pinglun.a8tiyu.com/comment/newPage?channel=AppStore&machineCode=e85ae7f61b563f361677d5f64acb823396a9b028&os_ver=11.0&pageIndex=0&pageSize=4&platform=iOS&sign=674cf1e1044e81c2711e41477c6b6212&time=1506789623&userId=115417601971&userIp=110.188.59.231&userLogo=&userNickname=&version=234&zId="


#define kNBATeam @"http://cdn2.fungotv.com/a8_sport/dataAll/rank.html?time=1507537928329"

#define circleList @"http://quanzi.caipiao.163.com/circle_getBoardList.html?product=caipiao_client&mobileType=iphone&ver=4.33&channel=appstore&apiVer=1.1&apiLevel=27&deviceId=13774C71-1660-4DA5-801B-6443F41E41FE"

#define hotPosts @"http://quanzi.caipiao.163.com/circle_getHotPosts.html?product=caipiao_client&mobileType=iphone&ver=4.33&channel=appstore&apiVer=1.1&apiLevel=27&deviceId=13774C71-1660-4DA5-801B-6443F41E41FE&sort=hot"

#define KCircleDetail @"http://quanzi.caipiao.163.com/circle_getPosts.html?product=caipiao_client&mobileType=iphone&ver=4.33&channel=appstore&apiVer=1.1&apiLevel=27&deviceId=13774C71-1660-4DA5-801B-6443F41E41FE&sort=hot"


#define KPostDetail @"http://quanzi.caipiao.163.com/circle_postInfo.html?product=caipiao_client&mobileType=iphone&ver=4.33&channel=appstore&apiVer=1.1&apiLevel=27&deviceId=13774C71-1660-4DA5-801B-6443F41E41FE"


#endif /* NSURLs_h */
