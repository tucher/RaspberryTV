# coding: utf-8
import requests
import os

def get_streams(login='gorblnu4@gmail.com', password='havanaIN'):
    s = requests.Session()
    csrf_token = dict(s.get('http://tvrain.ru/login/').cookies)['YII_CSRF_TOKEN']
    login_data = {
        'User[email]': login,
        'User[password]': password,
        'YII_CSRF_TOKEN': csrf_token
    }
    s.post("http://tvrain.ru/login/", data=login_data)
    return s.get("http://tvrain.ru/api/live/streams/").json()['video']['RTMP'][-1]['url']



if __name__ == '__main__':
    #templ = open('main.templ.qml').read()
    #templ = templ.replace('STREAM_LINK', get_streams())
    #text_file = open("main.qml", "w")
    #text_file.write(templ)
    #text_file.close()
    print get_streams()
    #os.environ['LD_LIBRARY_PATH'] = '/opt/libstdc++6.0.19'
    #os.system('./stream_player')