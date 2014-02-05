# coding: utf-8
import requests


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
    # return json.loads(streams)


if __name__ == '__main__':
    print get_streams()