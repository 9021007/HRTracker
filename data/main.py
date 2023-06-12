# simple web server with Allow CORS
import http.server

class CORSRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        http.server.SimpleHTTPRequestHandler.end_headers(self)

if __name__ == '__main__':
    http.server.test(HandlerClass=CORSRequestHandler)