# -*- coding: utf-8 -*-
from header import conn
from shoes import Shoes

class Shoes_manager():      
    def insert_new_item():
        cursor = conn.cursor()
        location = input("지점을 입력해주세요: ")
        name =  input("이름을 입력해주세요: ")
        while True:
            size = int(input("사이즈를 입력해주세요: "))
            if size<230 or size>275 or size%5!=0:
                print("사이즈 범위를 벗어났습니다. 다시 입력해주세요.")
            else: 
                break
        stock = int(input("재고를 입력해주세요: "))
    
        s = Shoes(location,name,size,stock)
        cursor.execute("insert into nk_shoes values (:nk_location, :nk_item_code,:nk_item_name,:nk_series,:nk_size,:nk_stock)", s.to_dict())
                       
            
    # 재고관리
    def update_stock(location, name, size):
        cursor = conn.cursor()
        print("재고를 입력해주세요. (증가시키는 경우 양수/감소시키는 경우 음수로 입력해주세요.)")
        item_num = int(input("재고를 입력해주세요: "))
        
        cursor.execute("select nk_stock from nk_shoes where nk_location=:nk_location and nk_item_name=:nk_item_name and nk_size=:nk_size",(location, name, size))
        stock = int(cursor.fetchone()[0])        
        stock = stock + item_num
        
        cursor.execute("update nk_shoes set nk_stock = :nk_stock where nk_item_name = :nk_item_name",(stock,name))

    
        # 단종된 제품을 DB에서 삭제
    def delete_item(name):
        cursor = conn.cursor()
        cursor.execute("delete from nk_shoes where nk_item_name = :nk_item_name",(name,))
    
    
