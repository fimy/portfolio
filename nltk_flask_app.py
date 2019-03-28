from flask import Flask, request
from concord_result import concordance
from nltk.text import ConcordanceIndex

import nltk

a=open("/home/nhousley/mysite/carbco_oral_histories.txt")
text=a.read()
text_a=text.lower()
text_b=text_a.split()
corpus=nltk.Text(text_b)

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def form_example():
	if request.method == 'POST':
		term = request.form.get('term')
		ci = ConcordanceIndex(corpus.tokens)
		results = concordance(ci, term)

		return '''<h1>The concordance result is:</h1>
            {}
        <br>
        Click <a href='/'>here</a> to try again'''.format(results)

	return '''<form method="POST">
			This form contains the text of all University of Utah Marriott Library Carbon County oral histories.<br>
			<br>
			Enter your search term to find its concordance in the text corpus.<br>
			<br>
			Term: <input type="text" name="term"><br>
			<input type="submit" value="Submit"><br>
			<br>
			This site uses <a href="http://www.nltk.org">NLTK</a> and <a href="http://flask.pocoo.org">Flask</a>.<br>
		</form>'''

if __name__ == '__main__':
	app.run()
