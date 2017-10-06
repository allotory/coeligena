CREATE DATABASE coeligena;

USE coeligena;

/*
 * 验证用户表
 */
CREATE TABLE IF NOT EXISTS auto_user (
    id                  INT UNSIGNED        NOT NULL AUTO_INCREMENT, /* 验证用户 ID（唯一标识） */
    email               VARCHAR(128)        NULL, /* 邮箱*/
    phone               VARCHAR(16)         NULL, /* 手机 */
    password            VARCHAR(256)        NOT NULL, /* 密码 */
    salt                VARCHAR(128)        NOT NULL, /* 密码加密盐 */
    create_time         TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 创建时间（时间戳） */
    last_login_time     TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 最近一次登录时间（时间戳）*/
    last_login_ip       VARCHAR(15)         NOT NULL, /* 最近登录的IP地址 */
    is_forbidden_status TINYINT(1) UNSIGNED NOT NULL, /* 是否状态：1-表示禁用，0-表示启用 */
    forbidden_time      TIMESTAMP           NOT NULL, /* 禁用截止日期 */
    remark              VARCHAR(256)                 DEFAULT NULL, /* 备注信息 */
    PRIMARY KEY (id),
    INDEX (email),
    INDEX (phone),
    INDEX (password)
);

/*
 * 角色表
 * 一定数量的权限的集合，权限的载体
 */
CREATE TABLE IF NOT EXISTS role (
    id          INT UNSIGNED        NOT NULL AUTO_INCREMENT, /* 角色 ID（唯一标识） */
    rolename    VARCHAR(32)         NOT NULL, /* 角色名 */
    pid         INT UNSIGNED                 DEFAULT '0', /* 父角色 ID */
    status      TINYINT(1) UNSIGNED NOT NULL, /* 启用状态：0-表示禁用，1-表示启用 */
    create_time TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 创建时间（时间戳） */
    update_time TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 更改时间（时间戳）*/
    remark      VARCHAR(256)                 DEFAULT NULL, /* 备注信息 */
    PRIMARY KEY (id)
);

/*
 * 验证用户与角色对应表
 */
CREATE TABLE IF NOT EXISTS role_auth_user (
    id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
    role_id      INT UNSIGNED NOT NULL DEFAULT '0', /* 角色 ID（唯一标识） */
    auth_user_id INT UNSIGNED NOT NULL DEFAULT '0', /* 验证用户 ID（唯一标识） */
    PRIMARY KEY (id)
);

/*
 * 权限表
 */
CREATE TABLE IF NOT EXISTS permission (
    id          INT UNSIGNED         NOT NULL AUTO_INCREMENT, /* 权限 ID（唯一标识） */
    name        VARCHAR(32)          NOT NULL, /* 权限名称（英文名，对应应用控制器、应用、方法名） */
    title       VARCHAR(64)                   DEFAULT NULL, /* 权限名称 */
    status      TINYINT(1)                    DEFAULT '0', /* 启用状态：0-表示禁用，1-表示启用 */
    remark      VARCHAR(256)                  DEFAULT NULL, /* 备注信息 */
    sort        SMALLINT(6) UNSIGNED          DEFAULT '50', /* 排序值（默认值为50） */
    pid         SMALLINT(6) UNSIGNED NOT NULL, /* 父权限 ID（如:方法pid对应相应的控制器） */
    level       TINYINT(1) UNSIGNED  NOT NULL, /* 权限类型：1-表示应用（模块）, 2-表示控制器, 3-表示方法 */
    create_time TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 创建时间（时间戳） */
    update_time TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 更改时间（时间戳）*/
    PRIMARY KEY (id)
);

/**
 * 角色权限对应表
 */
CREATE TABLE IF NOT EXISTS role_permission (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    role_id       INT UNSIGNED NOT NULL DEFAULT '0', /* 角色 ID（唯一标识） */
    permission_id INT UNSIGNED NOT NULL DEFAULT '0', /* 权限 ID（唯一标识） */
    PRIMARY KEY (id)
);


/*
 * 用户信息表
 */
CREATE TABLE IF NOT EXISTS user (
    id                 INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, /* 用户ID（唯一标识） */
    fullname           VARCHAR(64)      NOT NULL, /* 全名 */
    gender             INT(11)          NOT NULL DEFAULT '0', /* 性别  1:male , 2:female , 3: other */
    avatar_path        VARCHAR(512)              DEFAULT NULL, /* 头像路径 */
    location           VARCHAR(128)              DEFAULT NULL, /* 居住位置 */
    business           VARCHAR(128)              DEFAULT NULL, /* 行业 */
    employment         VARCHAR(128)              DEFAULT NULL, /* 公司或组织名称 */
    position           VARCHAR(128)              DEFAULT NULL, /* 职位 */
    education          VARCHAR(128)              DEFAULT NULL, /* 学校或教育机构 */
    major              VARCHAR(128)              DEFAULT NULL, /* 专业 */
    description        VARCHAR(256)              DEFAULT NULL, /* 个人描述 */
    autograph          VARCHAR(128)              DEFAULT NULL, /* 签名 */
    approval_count     INT(11)          NOT NULL DEFAULT '0', /* 获得赞同数 */
    thank_count        INT(11)          NOT NULL DEFAULT '0', /* 获得感谢数 */
    question_count     INT(11)          NOT NULL DEFAULT '0', /* 提问数 */
    answer_count       INT(11)          NOT NULL DEFAULT '0', /* 回答数 */
    invite_count       INT(11)          NOT NULL DEFAULT '0', /* 邀请回答数 */
    profile_view_count INT(11)          NOT NULL DEFAULT '0', /* 主页浏览数 */
    collect_count      INT(11)          NOT NULL DEFAULT '0', /* 收藏夹数 */
    personality_url    VARCHAR(64)               DEFAULT NULL, /* 个性网址 */
    is_email_active    INT(11)          NOT NULL DEFAULT '0', /* 邮箱是否激活 0：否， 1：是 */
    is_phone_active    INT(11)          NOT NULL DEFAULT '0', /* 手机是否激活 0：否， 1：是 */
    auth_user_id       INT              NOT NULL DEFAULT '0', /* 用户ID */
    PRIMARY KEY (id),
    INDEX (auth_user_id)
);


/*
 * 账户激活数据表
 */
CREATE TABLE IF NOT EXISTS activation (
    id               INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, /* 账户激活数据 ID */
    active_code      VARCHAR(32)      NOT NULL, /* 账户激活码 */
    active_type_code VARCHAR(16)      NOT NULL, /* 账户激活码类型：email url 或 phone code */
    creat_time       TIMESTAMP                 DEFAULT CURRENT_TIMESTAMP, /* 激活码创建时间 */
    expire_time      TIMESTAMP                 DEFAULT NULL, /* 激活码过期时间 */
    create_ip        VARCHAR(15)      NOT NULL, /* 激活码创建时 IP */
    active_time      TIMESTAMP                 DEFAULT NULL, /* 触发激活时间 */
    active_ip        VARCHAR(15)               DEFAULT NULL, /* 激活时 IP */
    user_id          INT(11)          NOT NULL, /* 用户 ID */
    PRIMARY KEY (id),
    INDEX (active_code),
    INDEX (active_type_code)
);

/* 
 * 用户关注表
 *
 * 	关注
 *	粉丝
 *	双向关注(互粉)
 *	无关系
	
 *	查询关注列表
 *	查询粉丝列表
 *	查询双向关注列表
 *	判断两个用户的关系
 *	查询带关系状态的任一列表
 * */
CREATE TABLE IF NOT EXISTS relationship (
    id          INT(11) NOT NULL AUTO_INCREMENT, /* 关系ID（唯一标识） */
    user_id     INT(11) NOT NULL, /* 用户ID */
    followed_id INT(11) NOT NULL, /* 当前用户关注的人  */
    PRIMARY KEY (id),
    INDEX (user_id),
    INDEX (followed_id)
);

/* 
 * 问题表 
 */
CREATE TABLE IF NOT EXISTS question (
    id               INT(11)      NOT NULL AUTO_INCREMENT, /* 问题ID（唯一标识） */
    question_content VARCHAR(255) NOT NULL, /* 问题标题 */
    question_detail  TEXT         NOT NULL DEFAULT NULL, /* 问题内容 */
    question_time    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 提问时间 */
    update_time      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 问题更新时间 */
    answer_count     INT(11)      NOT NULL DEFAULT '0', /* 答案数 */
    view_count       INT(11)      NOT NULL DEFAULT '0', /* 浏览次数 */
    follower_count   INT(11)      NOT NULL DEFAULT '0', /* 关注人数 */
    comment_count    INT(11)      NOT NULL DEFAULT '0', /* 评论数 */
    question_ip      VARCHAR(15)  NOT NULL, /* 提问 IP 地址 */
    is_locked        INT(11)      NOT NULL DEFAULT '0', /* 是否被锁定 1：是， 0：否 */
    is_anonymous     INT(11)      NOT NULL DEFAULT '0', /* 是否匿名 1：是， 0：否 */
    user_id          INT(11)      NOT NULL, /* 提问用户 */
    PRIMARY KEY (id),
    INDEX (user_id)
);

/*
 * 问题关注表
 */
CREATE TABLE IF NOT EXISTS follow (
    id          INT(11)   NOT NULL AUTO_INCREMENT, /* 问题关注ID（唯一标识）*/
    question_id INT(11)   NOT NULL, /* 被关注的问题ID（唯一标识） */
    follower_id INT(11)   NOT NULL, /* 问题关注人ID（唯一标识）*/
    follow_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 问题关注时间 */
    PRIMARY KEY (id),
    INDEX (question_id),
    INDEX (follower_id)
);

/*
 * 问题评论表
 */
CREATE TABLE IF NOT EXISTS question_comment (
    id                INT(11)   NOT NULL AUTO_INCREMENT, /* 评论ID（唯一标识） */
    question_id       INT(11)   NOT NULL DEFAULT '0', /* 被评论的问题ID（唯一标识） */
    reviewer_id       INT(11)   NOT NULL DEFAULT '0', /* 评论用户ID（唯一标识） */
    parent_comment_id INT(11)   NOT NULL DEFAULT '0', /* 被回复评论的ID（唯一标识） */
    comment_content   TEXT      NOT NULL, /* 评论内容 */
    comment_time      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 评论时间 */
    approval_count    INT(11)   NOT NULL DEFAULT '0', /* 赞同数量 */
    PRIMARY KEY (id),
    INDEX (question_id),
    INDEX (reviewer_id),
    INDEX (parent_comment_id)
);

/*
 * 问题话题节点表
 */
CREATE TABLE IF NOT EXISTS topic_nodes (
    id                 INT(11)      NOT NULL AUTO_INCREMENT, /* 话题节点 ID（唯一标识） */
    topic_name         VARCHAR(256) NOT NULL, /* 话题名称 */
    topic_introduction TEXT         NOT NULL DEFAULT '', /* 话题描述 */
    image_path         VARCHAR(512) NOT NULL DEFAULT '', /* 话题图片路径 */
    follow_count       INT(11)      NOT NULL DEFAULT '0', /* 话题关注者数量 */
    create_time        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 话题创建时间 */
    is_merged_to       INT(11)      NOT NULL DEFAULT '0', /* 是否合并到其他节点 */
    PRIMARY KEY (id)
);

/*
 * 问题话题关系表
 */
CREATE TABLE IF NOT EXISTS topic_relations (
    id              INT(11) NOT NULL AUTO_INCREMENT, /* 话题关系 ID（唯一标识） */
    parent_topic_id INT(11) NOT NULL DEFAULT '0', /* 父话题 ID */
    child_topic_id  INT(11) NOT NULL DEFAULT '0', /* 子话题 ID */
    PRIMARY KEY (id)
);

/*
 * 问题话题编辑锁定表
 */
CREATE TABLE IF NOT EXISTS topic_lock (
    id                     INT(11) NOT NULL AUTO_INCREMENT, /* 话题编辑锁定 ID（唯一标识） */
    is_locked_all          INT(11) NOT NULL DEFAULT '0', /* 是否完全锁定 0：是，1：否 */
    is_locked_name         INT(11) NOT NULL DEFAULT '0', /* 是否锁定话题名称 0：是，1：否 */
    is_locked_introduction INT(11) NOT NULL DEFAULT '0', /* 是否锁定话题描述 0：是，1：否 */
    is_locked_image        INT(11) NOT NULL DEFAULT '0', /* 是否锁定话题图片编辑 0：是，1：否 */
    is_locked_parent       INT(11) NOT NULL DEFAULT '0', /* 是否锁定父话题 0：是，1：否 */
    is_locked_child        INT(11) NOT NULL DEFAULT '0', /* 是否锁定子话题 0：是，1：否 */
    topic_id               INT(11) NOT NULL, /* 话题 ID */
    PRIMARY KEY (id)
);

/*
 * 问题话题合并表
 *  合并本话题至意义相近的其他话题。
 *  本话题会被删除，相关内容会自动迁移至目标话题中，同时添加话题别名。
 *  请将不常用的话题合并至常用话题。
 */
CREATE TABLE IF NOT EXISTS topic_merge (
    id           INT(11)   NOT NULL AUTO_INCREMENT, /* 话题合并 ID（唯一标识） */
    merged_to_id INT(11)   NOT NULL, /* 合并到话题 ID */
    merged_time  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 合并时间 */
    topic_id     INT(11)   NOT NULL, /* 话题 ID */
    PRIMARY KEY (id)
);

/*
 * 问题话题别名表
 */
CREATE TABLE IF NOT EXISTS topic_alias (
    id          INT(11)      NOT NULL AUTO_INCREMENT, /* 话题别名 ID（唯一标识） */
    topic_alias VARCHAR(256) NOT NULL, /* 话题别名 */
    topic_id    INT(11)      NOT NULL, /* 话题 ID */
    PRIMARY KEY (id)
);

/*
 * 问题话题日志表
 */
CREATE TABLE IF NOT EXISTS topic_logs (
    id            INT(11)     NOT NULL AUTO_INCREMENT, /* 话题日志 ID（唯一标识） */
    topic_id      INT(11)     NOT NULL, /* 话题节点 ID（唯一标识） */
    user_id       INT(11)     NOT NULL, /* 操作人员 ID（唯一标识） */
    event         VARCHAR(64) NOT NULL, /* 日志事件 */
    reason        TEXT        NOT NULL, /* 修改理由 */
    revision_text TEXT        NOT NULL, /* 实际修改结果（HTML） */
    log_time      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 日志记录时间 */

    PRIMARY KEY (id)
);

/*
 * 问题标签表
 */
CREATE TABLE IF NOT EXISTS question_tag (
    id                INT(11) NOT NULL AUTO_INCREMENT, /* 标签ID（唯一标识） */
    question_topic_id INT(11) NOT NULL, /* 话题 ID */
    question_id       INT(11) NOT NULL DEFAULT '0', /* 标签的问题ID（唯一标识） */
    PRIMARY KEY (id),
    INDEX (question_id)
);

/*
 * 问题日志表
 *
 * event 包括 添加了问题，添加了话题，编辑了问题，编辑了补充说明，移除了补充说明，移除了话题等
 */
CREATE TABLE IF NOT EXISTS question_log (
    id            INT(11)     NOT NULL AUTO_INCREMENT, /* 日志ID（唯一标识） */
    question_id   INT(11)     NOT NULL, /* 问题 ID（唯一标识） */
    user_id       INT(11)     NOT NULL, /* 操作人员 ID（唯一标识） */
    event         VARCHAR(64) NOT NULL, /* 日志事件 */
    reason        TEXT        NOT NULL, /* 修改理由 */
    revision_text TEXT        NOT NULL, /* 实际修改结果（HTML） */
    log_time      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 日志记录时间 */
    PRIMARY KEY (id),
    INDEX (question_id),
    INDEX (user_id)
);

/**
 * 问题回答邀请表
 */
CREATE TABLE IF NOT EXISTS invite (
    id          INT(11)   NOT NULL AUTO_INCREMENT, /* 邀请ID（唯一标识） */
    question_id INT(11)   NOT NULL, /* 问题ID */
    inviter_id  INT(11)   NOT NULL, /* 邀请人ID */
    invitee_id  INT(11)   NOT NULL, /* 被邀请人ID */
    invite_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 邀请时间 */
    PRIMARY KEY (id),
    INDEX (question_id),
    INDEX (inviter_id),
    INDEX (invitee_id)
);

/* 
 * 回答表
 */
CREATE TABLE IF NOT EXISTS answer (
    id                 INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, /* 答案ID（唯一标识） */
    question_id        INT(11) UNSIGNED NOT NULL, /* 问题ID（唯一标识） */
    author_id          INT(11) UNSIGNED NOT NULL, /* 作者ID（唯一标识） */
    answer_content     MEDIUMTEXT       NOT NULL, /* 答案 */
    answer_time        TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 回答或更新时间 */
    against_count      INT(11)          NOT NULL DEFAULT '0', /* 反对数 */
    approval_count     INT(11)          NOT NULL DEFAULT '0', /* 支持数 */
    comment_count      INT(11)          NOT NULL DEFAULT '0', /* 评论数 */
    uninterested_count INT(11)          NOT NULL DEFAULT '0', /* 不感兴趣数 */
    thanks_count       INT(11)          NOT NULL DEFAULT '0', /* 感谢数 */
    is_top_answer      INT(11)          NOT NULL DEFAULT '0', /* 是否是精华答案 */
    is_anonymous       INT(11)          NOT NULL DEFAULT '0', /* 是否匿名 1：是， 0：否 */
    is_force_fold      INT(11)          NOT NULL DEFAULT '0', /* 是否强制折叠 1：是， 0：否 */
    PRIMARY KEY (id),
    INDEX (question_id),
    INDEX (author_id)
);

/*
 * 答案投票表
 */
CREATE TABLE IF NOT EXISTS vote (
    id        INT(11)     NOT NULL AUTO_INCREMENT, /* 投票ID（唯一标识） */
    answer_id INT(11)     NOT NULL, /* 答案ID（唯一标识） */
    voter_id  INT(11)     NOT NULL, /* 投票用户ID */
    vote_time TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 答案投票时间 */
    vote_type VARCHAR(16) NOT NULL, /* 投票 up、down、unconcern */
    PRIMARY KEY (id),
    INDEX (answer_id),
    INDEX (voter_id)
);

/* 
 * 回答评论表
 */
CREATE TABLE IF NOT EXISTS answer_comment (
    id                INT(11)   NOT NULL AUTO_INCREMENT, /* 评论ID（唯一标识） */
    answer_id         INT(11)   NOT NULL DEFAULT '0', /* 被评论的答案ID（唯一标识） */
    reviewer_id       INT(11)   NOT NULL DEFAULT '0', /* 评论用户ID（唯一标识） */
    parent_comment_id INT(11)   NOT NULL DEFAULT '0', /* 被回复评论的ID（唯一标识） */
    comment_content   TEXT      NOT NULL, /* 评论内容 */
    comment_time      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 评论时间 */
    approval_count    INT(11)   NOT NULL DEFAULT '0', /* 赞同数量 */
    PRIMARY KEY (id),
    INDEX (answer_id),
    INDEX (reviewer_id),
    INDEX (parent_comment_id)
);

/*
 * 评论赞同表（不包括答案投票）
 */
CREATE TABLE IF NOT EXISTS comment_approval (
    id            INT(11)   NOT NULL AUTO_INCREMENT, /* 赞同ID（唯一标识） */
    comment_id    INT(11)   NOT NULL, /* 被赞同评论ID（唯一标识） */
    approval_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 评论点赞时间 */
    user_id       INT(11)   NOT NULL, /* 用户ID（唯一标识） */
    PRIMARY KEY (id),
    INDEX (comment_id),
    INDEX (user_id)
);

/*
 * 答案感谢表
 */
CREATE TABLE IF NOT EXISTS thanks (
    id         INT(11)   NOT NULL AUTO_INCREMENT, /* 感谢ID（唯一标识） */
    answer_id  INT(11)   NOT NULL, /* 被感谢答案ID */
    thanker_id INT(11)   NOT NULL, /* 感谢用户ID */
    thank_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 感谢答案时间 */
    PRIMARY KEY (id),
    INDEX (answer_id),
    INDEX (thanker_id)
);

/*
 * 回答没有帮助表
 */
CREATE TABLE IF NOT EXISTS nohelp (
    id          INT(11)   NOT NULL AUTO_INCREMENT, /* 回答没有帮助ID（唯一标识） */
    answer_id   INT(11)   NOT NULL, /* 没有帮助的回答 ID */
    user_id     INT(11)   NOT NULL, /* 用户 ID */
    nohelp_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 回答没有帮助时间 */
    PRIMARY KEY (id),
    INDEX (answer_id),
    INDEX (user_id)
);

/**
 * 回答草稿表
 */
CREATE TABLE IF NOT EXISTS draft (
    id            INT(11)    NOT NULL AUTO_INCREMENT, /* 草稿ID（唯一标识） */
    question_id   INT(11)    NOT NULL, /* 草稿问题 id */
    draft_content MEDIUMTEXT NOT NULL, /* 草稿内容 */
    last_update   TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 草稿更新时间 */
    is_anonymous  INT(11)    NOT NULL DEFAULT '0', /* 草稿是否匿名 1：是， 0：否 */
    user_id       INT(11)    NOT NULL, /* 草稿回答用户 */
    PRIMARY KEY (id),
    INDEX (user_id)
);

/*
 * 答案收藏夹表
 */
CREATE TABLE IF NOT EXISTS collection_folder (
    id            INT(11)      NOT NULL AUTO_INCREMENT, /* 收藏夹ID（唯一标识） */
    foldername    VARCHAR(256) NOT NULL, /* 收藏夹名称 */
    description   VARCHAR(256)          DEFAULT NULL, /* 收藏夹描述 */
    owner_id      INT(11)      NOT NULL, /* 创建者ID */
    answers_num   INT(11)      NOT NULL, /* 包含答案数量 */
    followers_num INT(11)      NOT NULL, /* 关注者数量 */
    is_public     INT(11)      NOT NULL DEFAULT '1', /* 是否公开 0：否， 1：是 */
    PRIMARY KEY (id),
    INDEX (owner_id)
);

/*
 * 答案收藏表
 */
CREATE TABLE IF NOT EXISTS collection (
    id                   INT(11) NOT NULL AUTO_INCREMENT, /* 收藏ID（唯一标识） */
    answer_id            INT(11) NOT NULL, /* 被收藏的答案ID */
    collection_folder_id INT(11) NOT NULL, /* 所属收藏夹ID */
    owner_id             INT(11) NOT NULL, /* 收藏夹所属用户ID */
    PRIMARY KEY (id),
    INDEX (answer_id),
    INDEX (collection_folder_id),
    INDEX (owner_id)
);

/*
 * 收藏夹关注表
 */
CREATE TABLE IF NOT EXISTS collection_folder_follow (
    id                   INT(11) NOT NULL AUTO_INCREMENT, /* 收藏ID（唯一标识） */
    collection_folder_id INT(11) NOT NULL, /* 收藏夹ID */
    follower_id          INT(11) NOT NULL, /* 收藏夹关注者ID */
    PRIMARY KEY (id),
    INDEX (collection_folder_id),
    INDEX (follower_id)
);

/**
 * 动态表
 */
CREATE TABLE IF NOT EXISTS feeds (
    id                INT(11)     NOT NULL AUTO_INCREMENT, /* 动态ID */
    feeds_id          INT(11)     NOT NULL, /* 动态类型所对应的ID,如关注和提出问题对应的是问题ID，赞同答案和回答问题对应的是答案ID */
    feeds_type        VARCHAR(64) NOT NULL, /* 动态类型 1：关注该问题，2：赞同该回答，3：回答了该问题，4：提了一个问题*/
    parent_feeds_id   INT(11)     NOT NULL DEFAULT '0', /* 父动态类型所对应的ID，赞同答案和回答问题对应的是问题ID */
    parent_feeds_type VARCHAR(64)          DEFAULT NULL, /* 父动态类型 1：赞同该回答——对应问题，2：回答了该问题——对应问题*/
    feeds_time        TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 动态时间 */
    feeds_user_id     INT(11)     NOT NULL, /* 动态发起人 */
    PRIMARY KEY (id),
    INDEX (feeds_user_id)
);

/*
 * 屏蔽用户
 */
CREATE TABLE IF NOT EXISTS block (
    id         INT(11) NOT NULL AUTO_INCREMENT, /* 屏蔽表ID（唯一标识） */
    user_id    INT(11) NOT NULL, /* 当前用户ID */
    blocked_id INT(11) NOT NULL, /* 被屏蔽用户ID */
    PRIMARY KEY (id),
    INDEX (user_id),
    INDEX (blocked_id)
);

/*
 * 设置表
 */
CREATE TABLE IF NOT EXISTS settings (
    id                    INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, /* 话题表 ID（唯一标识） */
    is_privacy_protection INT(11)          NOT NULL DEFAULT '1', /* 是否隐私保护（站外搜索到我的内容，不会被显示姓名）0：否，1：是 */
    message_receive       INT(11)          NOT NULL DEFAULT '0', /* 别人给我发私信，0：允许所有人给我发私信，1：只允许我关注的人给我发私信 */
    stranger_inbox        INT(11)          NOT NULL DEFAULT '0', /* 开启陌生人私信箱，0：否，1：是 */
    message_email         INT(11)          NOT NULL DEFAULT '0', /* 有私信时邮件提醒，0：否，1：是 */
    invite_me             INT(11)          NOT NULL DEFAULT '0', /* 邀请我回答问题，0：接收所有人的消息，1：只接收关注人的消息 */
    new_answer            INT(11)          NOT NULL DEFAULT '0', /* 关注的问题有了新回答，0：接收所有人的消息，1：只接收关注人的消息 */
    new_article           INT(11)          NOT NULL DEFAULT '0', /* 关注的专栏有了新文章，0：接收消息，1：不接收消息 */
    new_book              INT(11)          NOT NULL DEFAULT '0', /* 关注的人有了新的电子书，0：接收消息，1：不接收消息 */
    at_comment_me         INT(11)          NOT NULL DEFAULT '0', /* @/评论我，0：接收所有人的消息，1：只接收关注人的消息，2：不接收任何人的消息*/
    agree_thank_me        INT(11)          NOT NULL DEFAULT '0', /* 赞同、感谢我，0：接收所有人的消息，1：只接收关注人的消息，2：不接收任何人的消息*/
    like_commnet          INT(11)          NOT NULL DEFAULT '0', /* 赞了我的评论，0：接收所有人的消息，1：只接收关注人的消息，2：不接收任何人的消息*/
    like_article          INT(11)          NOT NULL DEFAULT '0', /* 赞了我的文章，0：接收所有人的消息，1：只接收关注人的消息，2：不接收任何人的消息*/
    like_book             INT(11)          NOT NULL DEFAULT '0', /* 赞了我的电子书，0：接收所有人的消息，1：只接收关注人的消息，2：不接收任何人的消息*/
    admire_article        INT(11)          NOT NULL DEFAULT '0', /* 赞赏了我的文章，0：接收所有人的消息，1：只接收关注人的消息，2：不接收任何人的消息*/
    follow_me             INT(11)          NOT NULL DEFAULT '0', /* 有人关注了我，0：接收所有人的消息，1：只接收关注人的消息，2：不接收任何人的消息*/
    follow_column         INT(11)          NOT NULL DEFAULT '0', /* 有人关注了我的专栏，0：接收所有人的消息，1：只接收关注人的消息，2：不接收任何人的消息*/
    follow_collection     INT(11)          NOT NULL DEFAULT '0', /* 有人关注了我的收藏，0：接收所有人的消息，1：只接收关注人的消息，2：不接收任何人的消息*/
    weekly_email          INT(11)          NOT NULL DEFAULT '0', /* 是否接受每周精选，0：否，1：是 */
    new_product_email     INT(11)          NOT NULL DEFAULT '0', /* 新产品或活动通知，0：否，1：是 */
    PRIMARY KEY (id)
);

/*
 *  专栏表
 */
CREATE TABLE IF NOT EXISTS columns (
    id                     INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, /* 专栏表 ID（唯一标识） */
    column_name            VARCHAR(128)     NOT NULL, /* 专栏名称 */
    column_intro           VARCHAR(255)     NOT NULL, /* 专栏介绍 */
    column_followers_count INT(11)          NOT NULL DEFAULT '0', /* 专栏关注人数 */
    article_count          INT(11)          NOT NULL DEFAULT '0', /* 专栏关注人数 */
    column_create_time     TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 专栏创建时间 */
    is_locked              INT(11)          NOT NULL DEFAULT '0', /* 专栏是否被锁定 1：是，0：否 */
    column_author_id       INT(11)          NOT NULL,
    PRIMARY KEY (id)
);

/*
 * 专栏文章表
 */
CREATE TABLE IF NOT EXISTS article (
    id                  INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, /* 屏蔽表ID（唯一标识） */
    article_title       VARCHAR(255)     NOT NULL, /* 文章标题 */
    article_content     MEDIUMTEXT       NOT NULL, /* 文章正文 */
    title_image         VARCHAR(255)              DEFAULT '', /* 文章题图 */
    compose_time        TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 创作时间 */
    compose_update_time TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 文章更新时间 */
    comments_count      INT(11)          NOT NULL DEFAULT '0', /* 评论数量 */
    views_count         INT(11)          NOT NULL DEFAULT '0', /* 浏览数量 */
    approval_count      INT(11)          NOT NULL DEFAULT '0', /* 文章点赞数量 */
    is_locked           INT(11)          NOT NULL DEFAULT '0', /* 文章是否被锁定 1：是，0：否 */
    author_id           INT(11)          NOT NULL, /* 文章作者 ID */
    PRIMARY KEY (id)
);

/*
 * 专栏主题表
 */
CREATE TABLE IF NOT EXISTS column_topics (
    id            INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, /* 专栏文章主题表ID（唯一标识） */
    topic_name    VARCHAR(64)      NOT NULL, /* 专栏主题名称 */
    article_count INT(11)          NOT NULL DEFAULT '0', /* 专栏主题包含文章数 */
    column_id     INT(11)          NOT NULL, /* 专栏 ID */
    PRIMARY KEY (id)
);

/*
 * 专栏文章主题关联表
 */
CREATE TABLE IF NOT EXISTS article_topics (
    id              INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, /* 专栏文章主题表ID（唯一标识） */
    column_topic_id INT(11)          NOT NULL, /* 专栏主题 ID */
    article_id      INT(11)          NOT NULL, /* 文章 ID */
    PRIMARY KEY (id)
);

/**
 * 专栏文章草稿表
 */
CREATE TABLE IF NOT EXISTS article_draft (
    id               INT(11)    NOT NULL AUTO_INCREMENT, /* 草稿ID（唯一标识） */
    column_id        INT(11)    NOT NULL, /* 草稿专栏 id */
    draft_content    MEDIUMTEXT NOT NULL, /* 草稿内容 */
    last_update_time TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 草稿更新时间 */
    is_anonymous     INT(11)    NOT NULL DEFAULT '0', /* 草稿是否匿名 1：是， 0：否 */
    user_id          INT(11)    NOT NULL, /* 草稿作者 */
    PRIMARY KEY (id),
    INDEX (user_id)
);

/**
 * 	（^为直接插入存储 ， #为动态读取）
 * 
 * 用户对用户：
 * 	1. 私信 ^ -- PrivateMsg
 * 
 * 系统对用户：
 * 	1. 提醒
 * 		别人邀请你回答一个问题^	-- InviteMsg
 * 		*别人评论了你的回答^		-- CommentAnswerMsg
 * 		*别人评论了你的问题^		-- CommentQuestionMsg
 * 		*别人回答了你的问题^		-- AnswerQuestionMsg
 * 		@用户 提到了你^			-- AtYouMsg
 * 		二级回复 回复了你的评论^	-- ReplyCommentMsg
 * 	2. 系统通知
 * 		*别人关注了你^			-- FollowingYouMsg
 * 		*你关注的问题有了一个新回答 #-- NewAnswerMsg
 * 		*系统公告#				-- SystemNotice
 * 		*别人赞同了你的回答^		-- AgreeAnswerMsg
 * 		*别人感谢了你的回答^		-- ThankYouAnswerMsg
 */

/*
 * 消息内容表
 */
CREATE TABLE IF NOT EXISTS message_text (
    id           INT(11)     NOT NULL AUTO_INCREMENT, /* 消息内容ID（唯一标识） */
    content      TEXT        NOT NULL, /* 消息内容 */
    message_name VARCHAR(64) NOT NULL, /* 消息英文名称  */
    PRIMARY KEY (id)
);

/*
 * 公共消息表
 */
CREATE TABLE IF NOT EXISTS public_message (
    id               INT(11)     NOT NULL AUTO_INCREMENT, /* 公共消息ID（唯一标识） */
    text_id          INT(11)     NOT NULL, /* 消息内容ID */
    send_time        TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 发送时间 */
    message_type     VARCHAR(64) NOT NULL, /* 消息类型  */
    message_group_id INT(11)     NOT NULL, /* 关注问题的用户组  0:默认所有人*/
    PRIMARY KEY (id),
    INDEX (text_id),
    INDEX (message_group_id)
);

/*
 * 消息记录表
 */
CREATE TABLE IF NOT EXISTS message_log (
    id               INT(11)     NOT NULL AUTO_INCREMENT, /* 用户消息ID（唯一标识） */
    sender_id        INT(11)     NOT NULL, /* 发送用户ID */
    receiver_id      INT(11)     NOT NULL, /* 接收用户ID */
    text_id          INT(11)     NOT NULL, /* 消息内容ID */
    send_time        TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 发送时间  设置时间时不需要更新*/
    read_time        TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 阅读时间 */
    message_type     VARCHAR(64) NOT NULL, /* 消息类型  */
    sender_isdel     SMALLINT    NOT NULL, /* 发送用户是否删除 0:否 ，1：是 */
    receiver_isdel   SMALLINT    NOT NULL, /* 接收用户是否删除 0:否 ，1：是 */
    is_read          SMALLINT    NOT NULL, /* 是否已读 0:否 ，1：是  */
    message_group_id INT(11)     NOT NULL, /* 关注问题的用户组 */
    PRIMARY KEY (id),
    INDEX (sender_id),
    INDEX (receiver_id),
    INDEX (text_id),
    INDEX (message_group_id)
);

/**
 * 消息组表
 */
CREATE TABLE IF NOT EXISTS message_group (
    id          INT(11) NOT NULL AUTO_INCREMENT, /* 消息组 ID（唯一标识） */
    user_id     INT(11) NOT NULL, /* 用户 ID */
    question_id INT(11) NOT NULL, /* 问题 ID */
    answer_id   INT(11) NOT NULL, /* 答案 ID */
    PRIMARY KEY (id),
    INDEX (user_id),
    INDEX (question_id),
    INDEX (answer_id)
);

/**
 * 举报类型表
 */
CREATE TABLE IF NOT EXISTS report_type (
    id                  INT(11)     NOT NULL AUTO_INCREMENT, /* 举报类型主键 ID（唯一标识） */
    report_type_content VARCHAR(64) NOT NULL, /* 举报类型 */
    is_common           INT(11)     NOT NULL, /* 判断是否是通用类型（即答案评论类型） */
    PRIMARY KEY (id)
);

/**
 * 举报表
 */
CREATE TABLE IF NOT EXISTS report (
    id                 INT(11)   NOT NULL AUTO_INCREMENT, /* 举报主键ID（唯一标识） */
    report_type_id     INT(11)   NOT NULL, /* 举报类型 ID */
    report_category    INT(11)   NOT NULL, /* 举报内容所属分类 0：问题，1：答案，2：评论 */
    report_category_id INT(11)   NOT NULL, /* 举报内容所属分类对应的问题、评论、答案id */
    report_time        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, /* 举报时间 */
    user_id            INT(11)   NOT NULL, /* 举报用户 ID（唯一标识） */
    PRIMARY KEY (id),
    INDEX (report_type_id),
    INDEX (user_id)
);
