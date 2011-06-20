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

// START:time
def timeMethod(method: () => Unit) = {
 val start = System.nanoTime
 method()
 val end = System.nanoTime
 println("Method took " + (end - start)/1000000000.0 + " seconds.")
}
// END:time

// START:sequential
def getPageSizeSequentially(urls:List[String]) = {
 for(url <- urls) {
   val page = new Page(url)
   page.fetch()
   println(url + " size: " + page.size + " links: " + page.links.size )
 }
}
// END:sequential

// START:concurrent
def getPageSizeConcurrently(urls:List[String]) = {
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

val urls = List.fromArray(args)

println("Sequential run:")
timeMethod { () => getPageSizeSequentially(urls) }

println("Concurrent run")
timeMethod { () => getPageSizeConcurrently(urls) }
