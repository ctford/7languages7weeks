import scala.io._
import scala.actors._
import Actor._

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

// START:concurrent
def getPageSizeConcurrently(urls:List[String]) = {
 val caller = self

 for(url <- urls) {
   actor { caller ! (url, {val page = new Page(url); page.fetch(); page}) }
 }

 for(i <- 1 to urls.size) {
   receive {
     case (url, page:Page) =>
       println("Size for " + url + ": " + page.size + "kb (" + page.links.size + " links)")            
   }
 }
}
// END:concurrent

val urls = List.fromArray(args)
timeMethod { () => getPageSizeConcurrently(urls) }
