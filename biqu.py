#coding=utf-8
#文件名：/Users/ymq/Desktop/biqu.py

__author__ = 'CQC'
# -*- coding:utf-8 -*-
import urllib
import urllib2
import re
import thread
import time
import sys


reload(sys)


sys.setdefaultencoding('utf8')
class BookOBJ:

    def __init__(self, name, author, lastTime, lastUpdata, info):
        
        self.name = name
        self.author = author
        self.lastTime = lastTime
        self.lastUpdata = lastUpdata
        self.info = info
        
        charpter = []
    
    def showinfo(self):
        print u"书名：%s" %(self.name)
        print u"作者：%s" %(self.author)
        print u"最近更新时间：%s" %(self.lastTime)
        print u"最新章节：%s" %(self.lastUpdata)
        print u"书籍介绍：%s" %(self.info)               
                
        
    

#笔趣阁爬虫
class BiQuGe:

    def __init__(self):
        self.rankBoos = {}
        self.currentBook = BookOBJ('', '', '', '', '')
        self.type = 0 #0查看排行 1查看电子书信息
        self.stop = False
        self.selectRank = ''
        self.currentCharpterurl = ''
        self.currentCharpterurlIndex = 0
        
    def sendRequest(self, url):
        try:
            #构建请求的request
            request = urllib2.Request(url)
            #利用urlopen获取页面代码
            response = urllib2.urlopen(request)
            #将页面转化为UTF-8编码
            pageCode = response.read().decode('utf-8', 'ignore')
            return pageCode

        except urllib2.URLError, e:
            if hasattr(e,"reason"):
                print u"连接笔趣阁失败,错误原因",e.reason
                return None


    def loadData(self):
        pageCode = self.sendRequest('http://www.qu.la/paihangbang/')
        if not pageCode:
            print "获取数据失败"
            return None
        pattern = re.compile('<div.*?index_toplist.*?span>(.*?)</span.*?<div.*?tabData.*?href="(.*?)".*?title="(.*?)".*?href="(.*?)".*?title="(.*?)".*?href="(.*?)".*?title="(.*?)".*?href="(.*?)".*?title="(.*?)".*?href="(.*?)".*?title="(.*?)"',re.S)
        items = re.findall(pattern,pageCode)

        pageStories = []
        count = 1;
        for item in items:

            booksName = []
            bookids = [];
            childData = [];
            for index in range(len(item)):
                child = item[index].encode('utf-8');
                if index != 0:
                    if index % 2 == 1:
                        bookids.append(child)
                    else:
                        booksName.append(child)
            for index,bookid in enumerate(bookids):
                name = booksName[index]
                bookDic = {}
                bookDic[bookid] = name;
                childData.append(bookDic);
            aaa = item[0].encode('utf-8')
            print '[' + str(count) + ']' + aaa
            count = count + 1
            pageStories.append(childData)
        return pageStories

    def getBooksInfoReuqest(self, bookid):
        try:
            url = "http://www.qu.la" + bookid
            request = urllib2.Request(url)
            response = urllib2.urlopen(request)
            pageCode = response.read().decode('utf-8', 'ignore')
            return pageCode
        except Exception as e:
            if hasattr(e,"reason"):
                print u'获取书籍信息失败' + e.reason
                return None

    def getBooksInfo(self, bookid):
        pageCode = self.getBooksInfoReuqest(bookid)
        if not pageCode:
            print "获取数据失败"
            return None
        # 中文正则表达式匹配，需要加‘u’
        str1 = u"者："
        str3 = u"最后更新："
        str4 = u"最新更新："
        str2 = "<div.*?maininfo.*?h1>(.*?)</h1.*?" + str1 + "(.*?)</p.*?" + str3 + "(.*?)</p.*?" + str4 + '<a.*?>(.*?)</a.*?div.*?intro">(.*?)</'

        pattern = re.compile(str2,re.S)
        items = re.findall(pattern,pageCode)
        for item in items:
            self.currentBook = BookOBJ(item[0],item[1],item[2],item[3],item[4])
            self.currentBook.showinfo()
        
 
        #出现换行情况当用.*?匹配    
        str6 = '<dd.*?href="(.*?)">(.*?)</a.*?/dd>'
        pattern2 = re.compile(str6,re.S)
        items2 = re.findall(pattern2,pageCode)
        self.currentBook.charpter = items2
        
    def getCharpterInfo(self, charpterUrl):
        url = "http://www.qu.la" + charpterUrl
        print "======" + charpterUrl
        pageCode = self.sendRequest(url)
        pattern1 =re.compile(u"[\u4e00-\u9fa5]+")
        str = '<div.*?content">(.*?)<script'
        pattern = re.compile(str, re.S)
        items = re.findall(pattern,pageCode)
        for item in items:
            item = item.replace("&nbsp;","")
            item = item.replace("<br/>","\n  ")
            print item
        

    def getBooks(self):
        selectBook = None
        if self.type == 0:
   
            selectBook = raw_input("请输入排行榜：")
            if selectBook == "R":
                self.rankBoos = self.loadData()
            elif selectBook == "Q":
                self.stop = True
                return
            else:
                self.type = 1
                self.selectRank = selectBook
                books = self.rankBoos[int(selectBook) - 1]
                for index, x in enumerate(books):
                    print '[' + str(index + 1) + ']' + x.values()[0]
                    

        elif self.type == 1:
            selectBookName = raw_input("请输入书籍名：")
            if selectBookName == "UP":
                self.type = 0
                return
            else:
                self.type = 3
                books = self.rankBoos[int(self.selectRank) - 1]
                book = books[int(selectBookName) - 1]
                print book.keys()[0]
                self.getBooksInfo(book.keys()[0])
                
                            
        elif self.type == 3:
            for i, j in enumerate(self.currentBook.charpter):
                print j[1]            
            selectchapter = raw_input("请输入章节数(非章节名称)：")
            if selectchapter == "UP":
                self.type = 1
               
            elif selectchapter == "Q":
                self.stop = True
                return
            else:
                self.type = 4
                self.currentCharpterurl = ""
                for i, j in enumerate(self.currentBook.charpter):
                    if i == int(selectchapter) - 1:
                        self.currentCharpterurl = j[0]
                        self.currentCharpterurlIndex = i;
                        break
            return
                    
        elif self.type == 4:
           
            self.getCharpterInfo(self.currentCharpterurl)
            selectchapter = raw_input("请输入章节数:/输入回车阅读下一章：")
            print selectchapter
            if selectchapter == "Q":
                self.stop = True
                return
            elif selectchapter == "UP":
                self.type = 3
                return            
            elif len(selectchapter) > 0:
                self.currentCharpterurlIndex = selectchapter
                self.currentCharpterurl = self.currentBook.charpter[int(self.currentCharpterurlIndex)][0]
               
            elif selectchapter == "":
                self.currentCharpterurlIndex = self.currentCharpterurlIndex + 1
                self.currentCharpterurl = self.currentBook.charpter[self.currentCharpterurlIndex][0]

    def start(self):
        self.rankBoos = self.loadData()
        while not self.stop:
            self.getBooks()

		
		

#糗事百科爬虫类
class QSBK:

    #初始化方法，定义一些变量
    def __init__(self):
        self.pageIndex = 1
        self.user_agent = 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)'
        #初始化headers
        self.headers = { 'User-Agent' : self.user_agent }
        #存放段子的变量，每一个元素是每一页的段子们
        self.stories = []
        #存放程序是否继续运行的变量
        self.enable = False
    #传入某一页的索引获得页面代码
    def getPage(self,pageIndex):
        try:
            url = 'http://www.qiushibaike.com/hot/page/' + str(pageIndex)
            #构建请求的request
            request = urllib2.Request(url,headers = self.headers)
            #利用urlopen获取页面代码
            response = urllib2.urlopen(request)
            #将页面转化为UTF-8编码
            pageCode = response.read().decode('utf-8')
            return pageCode

        except urllib2.URLError, e:
            if hasattr(e,"reason"):
                print u"连接糗事百科失败,错误原因",e.reason
                return None


    #传入某一页代码，返回本页不带图片的段子列表
    def getPageItems(self,pageIndex):
        pageCode = self.getPage(pageIndex)
        if not pageCode:
            print "页面加载失败...."
            return None
        pattern = re.compile('<h2>(.*?)</.*?span>(.*?)</.*?number">(.*?)</.*?number">(.*?)</',re.S)

        items = re.findall(pattern,pageCode)

        #用来存储每页的段子们
        pageStories = []
        #遍历正则表达式匹配的信息
        for item in items:
                pageStories.append([item[0].strip(),item[1].strip(),item[2].strip(),item[3].strip()])
        return pageStories

    #加载并提取页面的内容，加入到列表中
    def loadPage(self):
        #如果当前未看的页数少于2页，则加载新一页
        if self.enable == True:
            if len(self.stories) < 2:
                #获取新一页
                pageStories = self.getPageItems(self.pageIndex)
                #将该页的段子存放到全局list中
                if pageStories:
                    self.stories.append(pageStories)
                    #获取完之后页码索引加一，表示下次读取下一页
                    self.pageIndex += 1
    
    #调用该方法，每次敲回车打印输出一个段子
    def getOneStory(self,pageStories,page):
        #遍历一页的段子
        for story in pageStories:
            #等待用户输入
            input = raw_input()
            #每当输入回车一次，判断一下是否要加载新页面
            self.loadPage()
            #如果输入Q则程序结束
            if input == "Q":
                self.enable = False
                return
            print u"第%d页\t发布人:%s\t赞:%s\t评论:%s\n%s" %(page,story[0],story[2],story[3],story[1])
    
    #开始方法
    def start(self):
        print u"正在读取糗事百科,按回车查看新段子，Q退出"
        #使变量为True，程序可以正常运行
        self.enable = True
        #先加载一页内容
        self.loadPage()
        #局部变量，控制当前读到了第几页
        nowPage = 0
        while self.enable:
            if len(self.stories)>0:
                #从全局list中获取一页的段子
                pageStories = self.stories[0]
                #当前读到的页数加一
                nowPage += 1
                #将全局list中第一个元素删除，因为已经取出
                del self.stories[0]
                #输出该页的段子
                self.getOneStory(pageStories,nowPage)


# spider = QSBK()
# spider.start()

spider = BiQuGe()
spider.start()
