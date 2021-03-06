<%--
  Created by IntelliJ IDEA.
  User: Ellery
  Date: 2017/8/7
  Time: 21:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>机器学习 - 收藏夹 - ${siteInfoDO.siteName}</title>
    <meta name="description" content="一个真实的网络瞎编社区，帮助你寻找答案，分享知识。">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/favicon.ico" type="image/x-icon">

    <!-- css -->
    <%@include file="includeCss.jsp"%>
</head>
<body>

<!-- navbar -->
<%@include file="navbar.jsp"%>

<!-- main content -->
<div class="container">
    <div class="row custom-content-margin">
        <div class="col-sm-9">

            <div class="custom-feed-item custom-card">
                <a href="#">
                    <h4 class="custom-media-heading">
                        机器学习
                        <span class="badge custom-badge">123 new</span>
                    </h4>
                </a>
                <div class="custom-meta-panel">
                    <a href="#" class="custom-meta-item">
                        <i class="fa fa-comment"></i>
                        添加评论
                    </a>
                    <span class="custom-bull">•</span>
                    <a href="${pageContext.request.contextPath}/collection/123/log" class="custom-meta-item">
                        修改记录
                    </a>
                </div>
            </div>

            <!-- left main feed -->
            <div class="custom-card">
                <!-- feed items -->
                <div>
                    <!-- feed item -->
                    <div class="custom-feed-item">
                        <!-- feed -->
                        <div>
                            <h2 class="custom-contentItem-title2">
                                <a href="${pageContext.request.contextPath}/question/123">
                                    JVM符号引用转换直接引用的过程?
                                </a>
                            </h2>
                            <!-- feed author info -->
                            <div class="custom-feed-src-info custom-feed-author-info">
                                <div class="custom-author-info-content" style="margin-left: 0px;">
                                    <div class="custom-author-info-head">
                                        <a href="#">Ellery</a>
                                    </div>
                                    <div class="custom-author-info-detail">
                                        <div class="custom-author-badge">
                                            <div class="custom-author-badge-text">
                                                Microsoft Cortana Engineer Oracle Kernel Engineer.
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- end feed author info -->

                            <!-- feed detail -->
                            <div>
                                <!-- feed content -->
                                <div class="custom-rich-content">
                                    <div class="custom-rich-content-inner">
                                        符号引用是只包含语义信息，而解析（resolve）过后的直接引用则是与具体实现息息相关的。
                                        所以当谈及某个符号引用被resolve成怎样的直接引用时，必须要结合某个具体实现来讨论才行。
                                        <button class="custom-contentItem-more custom-btn-plain" type="button">
                                            <span class="custom-margin-right5">阅读全文</span>
                                            <i class="fa fa-chevron-down"></i>
                                        </button>
                                    </div>
                                    <div>
                                        <div class="custom-contentItem-actions">
                                            <span>
                                                <button class="custom-vote-btn" aria-label="赞同" type="button">
                                                    <i class="fa fa-caret-up"></i> 651
                                                </button>
                                                <button class="custom-vote-btn" aria-label="反对" type="button">
                                                    <i class="fa fa-caret-down"></i>
                                                </button>
                                            </span>
                                            <button class="custom-contentItem-action custom-btn-plain" type="button">
                                                <span style="display: inline-flex;align-items: center;">
                                                    <i class="fa fa-comment custom-margin-right5"></i>
                                                    8 条评论
                                                </span>
                                            </button>
                                            <div class="custom-drop-option2">
                                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                                                    <i class="fa fa-paper-plane"></i> 分享
                                                </a>
                                                <ul class="dropdown-menu" role="menu">
                                                    <li><a href="#">复制链接</a></li>
                                                    <li><a href="#">新浪微博</a></li>
                                                    <li><a href="#">扫一扫</a></li>
                                                </ul>
                                            </div>
                                            <button class="custom-contentItem-action custom-btn-plain" type="button">
                                                <span style="display: inline-flex;align-items: center;">
                                                    <i class="fa fa-star custom-margin-right5"></i>
                                                    收藏
                                                </span>
                                            </button>
                                            <button class="custom-contentItem-action custom-btn-plain" type="button">
                                                <span style="display: inline-flex;align-items: center;">
                                                    <i class="fa fa-heart custom-margin-right5"></i>
                                                    感谢
                                                </span>
                                            </button>
                                            <div class="custom-drop-option2">
                                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                                                    •••
                                                </a>
                                                <ul class="dropdown-menu" role="menu">
                                                    <li><a href="#">没有帮助</a></li>
                                                    <li><a href="#">举报</a></li>
                                                </ul>
                                            </div>
                                            <button class="custom-contentItem-action custom-btn-plain custom-contentItem-right" type="button">
                                                <span style="display: inline-flex;align-items: center;">
                                                    <span class="custom-margin-right5">收起</span>
                                                    <i class="fa fa-chevron-up"></i>
                                                </span>
                                            </button>
                                        </div>
                                    </div>
                                </div><!-- end feed content -->
                            </div><!-- feed detail -->
                        </div><!-- end feed -->
                    </div><!-- end feed item -->
                </div>
            </div>

            <div class="custom-card">
                <a href="javascript:void(0);" class="custom-question-more">
                    <i class="fa fa-spinner fa-spin" aria-hidden="true"></i>
                </a>
            </div>
        </div>
        <!-- sidebar -->
        <div class="col-sm-3 custom-sidebar-padding">

            <div class="list-group custom-feed-item custom-card custom-color-9f">
                <a href="#" class="list-group-item custom-group-item">
                    取消关注
                </a>
            </div>
            <!-- creator info -->
            <div class="custom-card">
                <div class="custom-card-header">
                    <div class="custom-card-headerText">关于创建者</div>
                </div>
                <div class="custom-card-section">
                    <div class="custom-answer-author">
                        <div class="custom-answer-author-avatar">
                            <a href="#">
                                <img class="custom-avatar48" src="<%=request.getContextPath()%>/resources/images/avatar/a.jpg" alt="...">
                            </a>
                        </div>
                        <div class="custom-answer-author-content">
                            <div class="custom-answer-author-name custom-font-size15">机器学习</div>
                            <div class="custom-answer-author-headline">724473人关注</div>
                        </div>
                    </div>
                </div>
            </div><!-- end creator info -->
            <!-- collection info -->
            <div class="custom-card">
                <div class="custom-card-header">
                    <div class="custom-card-headerText">收藏夹状态</div>
                </div>
                <div class="custom-card-section">
                    <div class="custom-color-9f custom-font-size14">
                        最近活动于
                        <a href=""> 10:49 </a> •
                        <a href="${pageContext.request.contextPath}/collection/123/log">查看收藏夹日志</a>
                        <a href=""> 1991 </a> 人关注了该收藏夹
                    </div>
                </div>
            </div><!-- end collection info -->
            <div class="list-group custom-margin-bottom10 custom-story-item custom-card custom-color-9f">
                <a href="#" class="list-group-item custom-group-item">
                    举报收藏夹
                </a>
            </div>
            <!-- hot collect -->
            <div class="custom-card">
                <div class="custom-card-header">
                    <div class="custom-card-headerText">热门收藏</div>
                    <span class="custom-right">
                        <a href="#" class="custom-item-link">
                            换一换 <i class="fa fa-angle-double-right"></i>
                        </a>
                    </span>
                </div>
                <div class="custom-card-section">
                    <div class="custom-answer-author">
                        <div class="custom-answer-author-content">
                            <div class="custom-answer-author-name custom-font-size15">机器学习</div>
                            <div class="custom-answer-author-headline">724473人关注 • 123条内容</div>
                        </div>
                    </div>
                </div>
                <div class="custom-card-section">
                    <div class="custom-answer-author">
                        <div class="custom-answer-author-content">
                            <div class="custom-answer-author-name custom-font-size15">励学自行</div>
                            <div class="custom-answer-author-headline">3473人关注 • 123条内容</div>
                        </div>
                    </div>
                </div>
            </div><!-- end hot collect -->
            <!-- sidebar footer -->
            <div class="custom-footer">
                <a href="#" target="_blank">${siteInfoDO.siteName}指南 • </a>
                <a href="#" target="_blank">${siteInfoDO.siteName}协议 • </a>
                <a href="#" target="_blank">隐私政策 • </a>
                <a href="#" target="_blank">移动应用 • </a>
                <a href="#" target="_blank">工作 • </a>
                <a href="#" target="_blank">申请开通${siteInfoDO.siteName}机构账号</a><br/>
                <a href="#" target="_blank">侵权举报 • </a>
                <a href="#" target="_blank">网上有害信息举报专区</a><br/>
                <a href="#" target="_blank">儿童色情信息举报专区</a><br/>
                <a href="#" target="_blank">联系我们</a>
                <a href="#" target="_blank">&copy;${siteInfoDO.copyRight}</a>
            </div><!-- end sidebar footer -->
        </div><!-- end sidebar -->
    </div>
</div>

<!-- js -->
<%@include file="includeJs.jsp"%>
</body>
</html>
