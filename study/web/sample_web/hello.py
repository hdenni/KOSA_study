# -*-coding: utf8-*-

# note: 리눅스에서 실행되기 위해서는 쉘이 인식할 수 있도록
# 가장 상단에 #!/usr/bin/python 과 같이 실행 위치를 지정해야 함

from flask import Flask, request, session, render_template, make_response, url_for, abort, redirect
import member

app = Flask(__name__)
# app 객체 생성



# URL 패턴과 POST Method 를 정의하고, 바로 하단의 함수에서 URL 패턴 매칭되는 Action 을 처리
# '/' url 이 실행됐을 때 hello 함수가 실행되게 해주세요
@app.route('/')
def hello_world():
    print(member.get_emp(103))
    return render_template('hello.html', name=member.get_emp(103))
    #return render_template('hello.html', name="홍길동")
    #return 'hello world!'

@app.route('/emp/<int:employee_id>')
def emp(employee_id):
    result = member.get_emp(employee_id)
    return render_template('emp.html', data=result)

# 내부에 methods 항목을 통해 받을 REST Action Type 을 지정
# 지정 이외의 Action Type 을 사용하면 405 에러를 출력
# REST Action Type
# - GET: SELECT(입력양식) / POST: INSERT(로그인 과정) / PUT: UPDATE / DELETE
@app.route('/account/login', methods=['GET'])
def login_form():
    #return render_template('login_form.html')
    return render_template('login.html')


@app.route('/account/login', methods=['POST'])
def login():
    # request 모듈에서 POST 한 파라미터 값을 가져오기
    if request.method == 'POST':
        userId = request.form['id'] # id 파라미터가 없으면 400 에러
        pw = request.form['pw']

        if len(userId) == 0 or len(pw) == 0:
            return render_template('error.html', msg='로그인 정보를 제대로 입력하지 않았습니다.')
        session['logFlag'] = True
        session['userId'] = userId
        #return session['userId'] + ' 님 환영합니다.'
        return render_template("login.html", id=userId)
    else:
        return render_template('error.html', msg="login method(post) error")


# 특정 URL Alias 등 Redirect 가 필요한데 Post 데이터를 같이 보내서 Redirect 를 하려면
# url_for() 함수 사용시 상태 코드 값을 같이 보내야 함
@app.route('/login', methods=['POST', 'GET'])
def login_direct():
    if request.method == 'POST':
        return redirect(url_for('login'), code=307)
    else:
        return redirect(url_for('login'))


@app.route('/account/logout', methods=['POST','GET'])
def logout():
    # 둘중 하나만 하면 됨
    session['logFlag']=False
    session.pop('userId', None)
    # redirect: 사용자의 조회 위치를 변경할 수 있음
    # url_for: route 주소로 이동하는 것이 아닌, 정의된 함수를 호출
    # 이 예제에서 main 을 호출하는 대상은 main() 인 함수
    return redirect(url_for('login'))
    #return redirect('/account/login')
    # logout 후 새로운 html(template)를 요청(=Forward 방식)하는 것이 아닌,
    # (위 예시에서는 main)url(logout 후 실행할 기능(함수)을 포함하는 url) 을 다시 요청 = Redirect
    
    # session.clear()을 사용하면 따로 설정할 필요 없이 session 을 비울 수 있음


@app.route('/user', methods=['GET'])
def getUser():
    if session.get('logFlag') != True:
        return render_template('error.html', msg="session logFlag is false")

    if 'userId' in session:
        return '[GET][USER] USER ID : {0}'.format(session['userId'])
    else:
        abort(400)


# <> 로 URL 패턴을 변수로 처리가능
# 자료형: 형식으로 URL 패턴 검증 가능
# int: 는 정수만 입력 가능함을 의미
@app.route('/user/<username>')
def showUserProfile(username):
    app.logger.debug('RETRIEVE DATA - USER ID : %s' % username)
    app.logger.debug('RETRIEVE DATA - Check Complete')
    app.logger.warn('RETRIEVE DATA - Warning... User Not Found')
    app.logger.error('RETRIEVE DATA - ERR! User unauthenification')

    return 'User : %s' % username

# abort 를 사용하면 특정 error 를 발생시킬 수 있음
# ex. abort(400), abort(404) ...
@app.errorhandler(400)
def uncaughtError(error):
    return render_template('error.html', msg="userId is not in session")

@app.errorhandler(404)
def not_found(error):
    # make_response() 함수를 통해 반환되는 Object 를 만들고, 이를 처리할 수 있게 됨
    resp = make_response(render_template('error.html'), 404)
    resp.headers['X-Something'] = 'A value'
    return resp

app.secret_key = 'sample_secret_key'
if '__main__' == __name__:
    app.debug = True
    # app.debug는 개발의 편의를 위해 존재
    # True값인 경우 코드를 변경하면 자동으로 서버가 재실행됨
    # 웹상에서 Python 코드를 수행할 수 있게 되므로, 운영환경에서 사용을 유의해야 함

    # 에러가 발생하면 debug 메세지를 출력함
    # 개발 할때만 넣고 실제로는 False set

    # 세션 키를 생성하며, 로그인과 같이 세션을 맺는 경우 필수적으로 넣어야 함
    # 세션 생성 시 app.secret_key 로 키를 생성하지 않으면 Flask 가 500에러를 출력
    app.run()

# 현재 접근은 개발 소스가 존재하는 로컬에서만 접근 가능
# 외부에서도 접근을 가능하게 하려면 app.run(host='0.0.0.0')로 서버 실행부를 변경해야 함

