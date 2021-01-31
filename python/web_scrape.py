# feches internet content and converts it to text

from bs4 import BeautifulSoup

import argparse
import constant
import datetime
import json
import os
import re
import requests
import sys

# sys.tracebacklimit = 0



def json_to_dict(file_name):
    # first, check if file exists

    if not os.path.isfile(file_name): raise FileNotFoundError('File not found!\n')

    # then, try loading the JSON file
    # will raise an erorr if not a valid JSON file
    with open(file_name) as f:
        try:
            site_list = json.load(f)
        except:
            print("Not a valid JSON file!")
            raise
    
    return site_list



def save_text(site_name, title, content):
    # save content of body to new file under appropriate directory
            
    # get date + time for file name
    date = datetime.datetime.now()
    date = date.strftime('%x_%X')

    # can't have special characters like '/' or ':' in file names
    date = re.sub('[^A-Za-z0-9_]+', '.', date)

    # file name
    file_name = '../' + site_name + '/' + title + '_' + date + '.txt'

    # create and write to file
    file_to_write = open(file_name, 'w')
    for line in content:
        to_write = line.text
        if site_name=="Wikipedia": to_write = re.sub('\[[0-9]*\]', '', to_write) # get rid of footnotes in Wikipedia articles
        file_to_write.write(to_write + '\n')
    file_to_write.close()
    print("Successfully wrote to " + file_name)


def wikipedia_to_text(website_data):
    # fetches articles from Wikipedia and converts them to text
    list_of_articles = website_data["articles"]
    for article in list_of_articles:
        # get the content of the page
        page = requests.get(article)
        soup = BeautifulSoup(page.content, 'html.parser')

        # get article title
        title = soup.find(id=website_data["TITLE_ID"]).text

        # get main body of the article
        body = soup.find(id=website_data["MAIN_BODY_ID"])
        content = body.find_all(constant.HTML_P_TAG)

        save_text(website_data["NAME"], title, content)




def sites_to_text(site_list):
    # calls for appropriate function depending on type of website
    for website in site_list:
        if website == 'Wikipedia':
            wikipedia_to_text(site_list[website])

    


def main():

    parser = argparse.ArgumentParser(description="Scrape the text from a list of websites.")
    parser.add_argument('json_file', metavar='file', type=str, nargs=None, help="A JSON file containing a list of websites to scrape")
    args = parser.parse_args()

    # check if file exists
    site_list = json_to_dict(args.json_file)
    sites_to_text(site_list)



main()