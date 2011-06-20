import scala.io._
import scala.actors._
import Actor._

// START:loader
object PageLoader {
 def getPageSize(url : String) = {
	val page = new Page(url)
	page.fetch()
	page.size
 }
}
// END:loader

class Page(url : String) {
	var contents = "" 
 	def fetch() = { contents = Source.fromURL(url).mkString }
	def size() = contents.length
	def links() = {
		val linkMatch = """href=""".r
		linkMatch findAllIn contents toList
	}
}

val urls = List("http://www.amazon.com/", 
               "http://www.twitter.com/",
               "http://www.google.com/",
               "http://www.cnn.com/" )

// START:time
def timeMethod(method: () => Unit) = {
 val start = System.nanoTime
 method()
 val end = System.nanoTime
 println("Method took " + (end - start)/1000000000.0 + " seconds.")
}
// END:time

// START:sequential
def getPageSizeSequentially() = {
 for(url <- urls) {
   val page = new Page(url)
   page.fetch()
   println(url + " size: " + page.size + " links: " + page.links.length)
 }
}
// END:sequential

// START:concurrent
def getPageSizeConcurrently() = {
 val caller = self

 for(url <- urls) {
   actor { caller ! (url, PageLoader.getPageSize(url)) }
 }

 for(i <- 1 to urls.size) {
   receive {
     case (url, size) =>
       println("Size for " + url + ": " + size)            
   }
 }
}
// END:concurrent

// START:script
println("Sequential run:")
timeMethod { getPageSizeSequentially }

println("Concurrent run")
timeMethod { getPageSizeConcurrently }
// END:script
