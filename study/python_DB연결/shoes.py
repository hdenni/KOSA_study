# -*- coding: utf-8 -*-
from header import conn
from prettytable import PrettyTable

'''def alias_print(data):
   cursor = conn.cursor()
   columns = [row[0] for row in cursor.description]
   for  i in columns:
       print("{:|<10}".format(i))'''
       
def alias_print(data, columns):
    x = PrettyTable()
    x.field_names = columns
    
    for i in data:
        x.add_row(list(i))
        
    print(x)       
       
class Shoes:
    def __init__(self, location, name, size, stock):
        self.location = location
        self.name = name
        self.size = size
        self.stock = stock
        
        self.set_series_and_code()
    
    def __str__(self):
        return "location: {}, code: {}, name: {}, serie1s: {}, size: {}, stock: {}"\
               .format(self.location, self.code, self.name, self.series, self.size, self.stock)

    def to_dict(self):
        return {"nk_location":self.location, "nk_item_code":self.code, "nk_item_name":self.name, "nk_series":self.series, "nk_size":self.size, "nk_stock":self.stock}
 

    def set_series_and_code(self):
        cursor = conn.cursor()
        cursor.execute("select nk_series, nk_code from nk_series where nk_item_name = :nk_item_name", (self.name,))
        temp = cursor.fetchone()
        
        size = (self.size - 225)/5
        if size<10:
            size = '0'+str(int(size))

        if not temp:
            self.series = '기타'
            self.code = self.location + '_' + 'etc_00_'+ size
        else:
            self.series = temp[0]
            self.code = self.location + '_' + temp[1] + '_' + size

    # 제품 조회(제품명, 사이즈)
    def search_item_stock(name, size):
        cursor = conn.cursor()
        cursor.execute("select * from nk_shoes where nk_item_name = :nk_item_name and nk_size=:nk_size",(name,size))
        columns = [row[0] for row in cursor.description]
        empty_error = cursor.fetchall()
        if not empty_error:
            print("재고가 존재하지 않습니다.")
        else:
            alias_print(empty_error, columns)
    
    # 제품 조회(지점)
    def search_location_stock(location):
        cursor = conn.cursor()
        cursor.execute("select * from nk_shoes where nk_location = :nk_location",(location,))
        columns = [row[0] for row in cursor.description]
        empty_error = cursor.fetchall()
        if not empty_error:
            print("재고가 존재하지 않습니다.")
        else:
            alias_print(empty_error, columns)
    

            
    #전체 제품 조회
    def get_all_shoes():
        cursor = conn.cursor()
        cursor.execute("select * from nk_shoes order by nk_location ")
        data  = cursor.fetchall()
        columns = [row[0] for row in cursor.description]
        
        alias_print(data, columns)
            
            
    
    
    # csv
    def export_shoes():
        file_name = input("파일명을 입력하세요")
        cursor = conn.cursor()
        cursor.execute("select * from nk_shoes")
        
        shoes = cursor.fetchall()
        colnames = [row[0] for row in cursor.description]
            
        import csv
        with open(file_name,'w',newline='',encoding ="UTF8") as file:
            w= csv.writer(file,quoting = csv.QUOTE_NONNUMERIC)
            w.writerow(colnames)
            w.writerows(shoes)
            
    


