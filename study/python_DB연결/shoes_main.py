# -*- coding: utf-8 -*-
from header import conn
from shoes import Shoes as sh
from shoes_manager import  Shoes_manager as sm

def print_menu():
    print("\nNICENICENICENICENICE 메뉴 NICENICENICENICENICENICE\n")
    print("1. 신제품 추가")
    print("2. 재고 관리")
    print("3. 단종 제품 삭제")
    print("4. 제품 조회")
    print("5. 전체 제품 조회")
    print("6. 내보내기(csv)")
    print("0. 종료")
    print("**************************************************")
    
def main():
    print("**************************************************")
    print("***********나이키 신발 재고 관리 프로그램***********")
    print("**************************************************")
    while True:
        print_menu()
        menu = int(input("메뉴 선택: "))
        if menu==1:
            sm.insert_new_item()
            conn.commit()

        elif menu==2:
            location = input("지점 명을 입력해주세요: ")
            
            name = input("관리하려는 제품의 이름을 입력해주세요: ")
            size = int(input("사이즈를 입력해주세요: "))
            sm.update_stock(location, name, size)
            conn.commit()
            
        elif menu==3:
            name = input("삭제하려는 제품의 이름을 입력해주세요: ")
            sm.delete_item(name)
            conn.commit()

        elif menu==4:
            print("기능을 선택해주세요")
            print("(1) 제품 재고 확인")
            print("(2) 지점 별 재고 확인")

            while True:
                sub_menu = int(input("메뉴 선택: "))

                # 사고 싶은 제품을 찾는거(어느 지점에 얼마나 있는지)
                if sub_menu==1:
                    name = input("제품명을 입력해주세요: ")
                    size = input("사이즈를 입력해주세요: ")
                    sh.search_item_stock(name, size)
                    break

                # 회사용. A지점에 제품이 뭐가 있는지
                elif sub_menu==2:
                    location = input("지점명을 입력해주세요: ")
                    sh.search_location_stock(location)
                    break
                    
                else:
                    print("잘못 입력하셨습니다. 다시 입력해주세요.")
                    
        elif menu==5:
            sh.get_all_shoes()
          
        elif menu==6:
            sh.export_shoes()

        elif menu==0:
            print("프로그램을 종료합니다.")
            break

        else:
            print("잘못 입력하셨습니다. 다시 입력해주세요.")
 
    
if __name__=='__main__':
    main()