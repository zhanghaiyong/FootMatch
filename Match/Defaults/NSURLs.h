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

#define kHot @"http://118.178.1.136/v3/league/newsList?a8id=115417601971&channel=AppStore&leagueIds=104%2C1%2C4%2C2%2C6%2C9%2C3%2C5%2C8%2C7%2C108&leagueTags=4%2C6%2C7%2C8&os_ver=11.0&pageSize=20&platform=iOS&sign=3e86f478524ed4b5ec3a4019bcee6ea0&time=1506733865&token=&type=1&uid=115417601971&version=234"

#define kHotDetail @"http://a8.tvesou.com/right/news/news_html?a8id=115417601971&channel=AppStore&os_ver=11.0&platform=iOS&sign=1190ed8cad12a0eef425bcdb64c324f3&time=1506780665&token=&uid=115417601971&version=234&zId="

#define kHotDetailComment @"http://pinglun.a8tiyu.com/comment/hotNew?channel=AppStore&hotNum=20&machineCode=e85ae7f61b563f361677d5f64acb823396a9b028&newNum=30&os_ver=11.0&platform=iOS&sign=5a7817d12e3057b6a55a4e31a198d635&time=1506780977&userId=115417601971&userIp=110.188.59.231&userLogo=&userNickname=&version=234&zId="

#define kHotVideoDetailComment @"http://pinglun.a8tiyu.com/comment/newPage?channel=AppStore&machineCode=e85ae7f61b563f361677d5f64acb823396a9b028&os_ver=11.0&pageIndex=0&pageSize=4&platform=iOS&sign=674cf1e1044e81c2711e41477c6b6212&time=1506789623&userId=115417601971&userIp=110.188.59.231&userLogo=&userNickname=&version=234&zId="

#define kVideoHighlight  @"http://118.178.1.136/v3/game/videoList?a8id=115417601971&channel=AppStore&os_ver=11.0&pageSize=20&platform=iOS&sign=0edccf16ca77c08738d54f05c303f19e&time=1507530420&token=&uid=115417601971&version=234"

#define kChinaFootBall @"http://118.178.1.136/v3/league/newsList?a8id=115417601971&channel=AppStore&id=6&os_ver=11.0&pageSize=20&platform=iOS&sign=b3033b32fdf2a4d16d6e13fe15b6934c&tag=1&tagId=6&time=1507533056&title=%E4%B8%AD%E5%9B%BD%E8%B6%B3%E7%90%83&token=&type=0&uid=115417601971&version=234"

#define kSMG @"http://118.178.1.136/v3/league/newsList?a8id=115417601971&channel=AppStore&id=104&leagueId=104&os_ver=11.0&pageSize=20&platform=iOS&sign=5c806df5a79f5c8fd722bb78d17caf31&tag=2&time=1507533799&title=%E7%AB%9E%E5%BD%A9&token=&type=0&uid=115417601971&version=234"

#define kNBATeam @"http://cdn2.fungotv.com/a8_sport/dataAll/rank.html?time=1507537928329"

#define circleList @"http://quanzi.caipiao.163.com/circle_getBoardList.html?product=caipiao_client&mobileType=iphone&ver=4.33&channel=appstore&apiVer=1.1&apiLevel=27&deviceId=13774C71-1660-4DA5-801B-6443F41E41FE"

#define hotPosts @"http://quanzi.caipiao.163.com/circle_getHotPosts.html?product=caipiao_client&mobileType=iphone&ver=4.33&channel=appstore&apiVer=1.1&apiLevel=27&deviceId=13774C71-1660-4DA5-801B-6443F41E41FE&sort=hot"

#define KCircleDetail @"http://quanzi.caipiao.163.com/circle_getPosts.html?product=caipiao_client&mobileType=iphone&ver=4.33&channel=appstore&apiVer=1.1&apiLevel=27&deviceId=13774C71-1660-4DA5-801B-6443F41E41FE&sort=hot"


#define KPostDetail @"http://quanzi.caipiao.163.com/circle_postInfo.html?product=caipiao_client&mobileType=iphone&ver=4.33&channel=appstore&apiVer=1.1&apiLevel=27&deviceId=13774C71-1660-4DA5-801B-6443F41E41FE"


#endif /* NSURLs_h */
