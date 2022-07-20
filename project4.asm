# <-- marsbot -->
.eqv HEADING    0xffff8010     # an angle between 0 and 359
.eqv MOVING     0xffff8050     # boolean: whether or not to move
.eqv LEAVETRACK 0xffff8020     # boolean: whether or not to leave a track
.eqv WHEREX     0xffff8030     # integer: current x-location of MarsBot
.eqv WHEREY     0xffff8040     # integer: current y-location of MarsBot
# <-- keymatrix -->
.eqv IN_ADDRESS_HEXA_KEYBOARD  0xffff0012  # input row to check
                                           # 0x01: check_row1
                                           # 0x02: check_row2
                                           # 0x04: check_row3
                                           # 0x08: check_row4

.eqv OUT_ADDRESS_HEXA_KEYBOARD 0xffff0014  # receive row and column of the key pressed 
                                           # 0 if not key pressed

.data
# key is 0 <--> DCE
pscript_of_keyboard_0: .ascii "90,2000,0;180,3000,0;"
                                                                                                 
                               "180,5790,1;80,500,1;70,500,1;60,500,1;50,500,1;40,500,1;"         
                               "30,500,1;20,500,1;10,500,1;0,500,1;350,500,1;340,500,1;"         #  D 
                               "330,500,1;320,500,1;310,500,1;300,500,1;290,500,1;280,490,1;"     
                           
                               "90,7000,0;270,500,1;260,500,1;250,500,1;240,500,1;230,500,1;"    
                               "220,500,1;210,500,1;200,500,1;190,500,1;180,500,1;170,500,1;"    # C
                               "160,500,1;150,500,1;140,500,1;130,500,1;120,500,1;110,500,1;"    
                               "100,500,1;90,1000,1;"                                            
                               
                               "90,5000,0;270,2000,1;0,5800,1;90,2000,1;180,2900,0;270,2000,1;"  #  E
                               "90,3000,0;\0"                                                    
                                                                                                 
# key is 4 <--> DUY   
pscript_of_keyboard_4: .ascii "90,2000,0;180,3000,0;"
                              
                                                                                                
                              "180,5790,1;80,500,1;70,500,1;60,500,1;50,500,1;40,500,1;"        
                              "30,500,1;20,500,1;10,500,1;0,500,1;350,500,1;340,500,1;"         # D
                              "330,500,1;320,500,1;310,500,1;300,500,1;290,500,1;280,490,1;"    
                           
                              "90,8000,0;180,5790,1;270,4000,1;0,5790,1;"             　　　　　　# U
                              
                              "90,6000,0;135,2398,1;180,3389,1;0,3392,0;45,2398,1;\0"           #  Y                               
                              
                               
                                                                                                
                                                                 
                                                                                                 
# key is 8 <-->　CHUNG
pscript_of_keyboard_8: .ascii    "90,2000,0;180,3000,0;"
                                 "90,3500,0;270,500,1;260,500,1;250,500,1;240,500,1;230,500,1;"    
                                 "220,500,1;210,500,1;200,500,1;190,500,1;180,500,1;170,500,1;"    # C
                                 "160,500,1;150,500,1;140,500,1;130,500,1;120,500,1;110,500,1;"    
                                 "100,500,1;90,1000,1;"                                            
                               
                                 "90,2000,0;0,5790,1;180,2790,0;90,3000,1;0,2790,0;180,5790,1;"    #  H
                                 
                                 "90,2000,0;0,5790,0;180,5790,1;90,4000,1;0,5790,1;"               # U
                                 
                                 "90,2000,0;180,5790,0;0,5790,1;150,6450,1;0,5790,1;"              # N
                                 
                                 "90,5000,0;270,500,1;260,500,1;250,500,1;240,500,1;230,500,1;"     
                                 "220,500,1;210,500,1;200,500,1;190,500,1;180,500,1;170,500,1;"    # G
                                 "160,500,1;150,500,1;140,500,1;130,500,1;120,500,1;110,500,1;"    
                                 "100,500,1;90,1000,1;0,3000,1;270,1200,1;\0"
                                  
                                                                                                    
log: .asciiz "No postscript  "
.text
# <-- Nhap chu so muon ve -->
       li $t3, IN_ADDRESS_HEXA_KEYBOARD
       li $t4, OUT_ADDRESS_HEXA_KEYBOARD
Polling:
       addi $at, $0, 0x01
       sb $at, 0($t3)                      # check_row1
       lb $t0, 0($t4)                      # load key pressed in row
       bne $t0, 0x11, NOT_KEYBOARD_0       # if OUT_ADDRESS_HEXA_KEYBOARD != 0x11 
                                           # then branch NOT_KEYBOARD_0
       la $a1, pscript_of_keyboard_0       # else 
       j START                             # draw pscript_of_keyboard_0 <--> DCE
       
       NOT_KEYBOARD_0:
       addi $at, $0, 0x02
       sb $at, 0($t3)                      # check_row2
       lb $t0, 0($t4)                      # load key pressed in row
       bne $t0, 0x12, NOT_KEYBOARD_4       # if OUT_ADDRESS_HEXA_KEYBOARD != 0x12 
                                           # then branch NOT_KEYBOARD_4
       la $a1, pscript_of_keyboard_4       # else 
       j START                             # draw pscript_of_keyboard_4 <--> HEDSPI
       
       NOT_KEYBOARD_4:
       addi $at, $0, 0x04
       sb $at, 0($t3)                      # check_row3
       lb $t0, 0($t4)                      # load key pressed in row
       bne $t0, 0x14, NOT_KEYBOARD_8       # if OUT_ADDRESS_HEXA_KEYBOARD != 0x14 
                                           # then branch NOT_KEYBOARD_8
       la $a1, pscript_of_keyboard_8       # else 
       j START                             # draw pscript_of_keyboard_8 <--> ハノイ工科大学
       
       NOT_KEYBOARD_8:                     # if key pressed is not 0,4,8
       li $v0, 4
       la $a0, log
       syscall      
       
        li $v0, 32
        li $a0, 2000
        syscall 
       j Polling                           # return polling
# <-- end -->

START:
       jal GO
       addi $t6, $0, -1                    # $t6 là thanh ghi lưu thứ tự của các chữ số khi
                                           # đọc từ postscript, ví dụ khi đọc  '123,45,6; ..'
                                           # thì đọc 1->2->3->","->4... tương ứng $t6 có giá  
                                           # trị 0->1->2->3->4->...
READ_PSCRIPT:       
       #--------------------------------------------------------------------------------------
       addi $t0, $0, 0                     # value of rootate, init value = 0
       addi $t1, $0, 0                     # value of time, init value = 0
       addi $t2, $0, 0                     # value of track 0=untrack | 1=track
       
       read_rootate:
       addi $t6, $t6, 1                    
       add $t7, $a1, $t6                   # $a1 chứa địa chỉ của postscript
       lb $t5, 0($t7)                      # đọc ký tự
       beq $t5, 44, read_time              # nếu gặp kí tự ',' thì nhảy đến read_time
       
       addi $t5, $t5, -48                  #--------------------------------------------------
                                           # nếu không gặp kí tự ',' thì
                                           # chuyển kí tự số vừa mới đọc (char) về int
       	                             # trừ đi 48 bởi vì trong bảng mã ascii thì chúng 
       	                             # cách nhau 48. Ví dụ: kí tự '2' có giá trị hệ 10 
       	                             # là 50, khi đó $t5 = 50(decimal), sau khi chạy 
       	                             # lệnh $t5, $t5, -48 thì $t5=50-48=2
       
       mul $t0, $t0, 10                    
       add $t0, $t0, $t5	               # rootate = $t0 = $t0*10 + $t5
       j read_rootate                      # nhảy về read_rootate để đọc tiếp chữ số tiếp 
                                           # theo của rootate
                                           
       #--------------------------------------------------------------------------------------
       read_time: 
       addi $t6, $t6, 1                         
       add $t7, $a1, $t6                   # $a1 chứa địa chỉ của postscript   
       lb $t5, 0($t7)                      # đọc ký tự     
       beq $t5, 44, read_track             # nếu gặp kí tự ',' thì nhảy đến read_track
       
       addi $t5, $t5, -48                  # chuyển chữ số về int
       mul $t1, $t1, 10
       add $t1, $t1, $t5                   # time = $t1 = $t1*10 + $t5
       j read_time
       
       #--------------------------------------------------------------------------------------
       read_track:
       addi $t6, $t6, 1
       add $t7, $a1, $t6                   # $a1 chứa địa chỉ của postscript   
       lb $t5, 0($t7)                      # đọc ký tự     
       beq $t5, 59, run_and_next_move      # nếu gặp kí tự ';' thì nhảy đến run_and_next_move
       
       addi $t5, $t5, -48                  # chuyển chữ số về int
       mul $t2, $t2, 10
       add $t2, $t2, $t5                   # time = $t2 = $t2*10 + $t5
       j read_track
       
       #--------------------------------------------------------------------------------------
       run_and_next_move:
       # set rootate
       add $a0, $t0, $zero
       jal ROTATE
       # set value for time
       addi $v0, $0, 32
       add $a0, $0, $t1
       # set value for track
       jal SETVALUE_TRACK
       # run
       syscall
       jal UNTRACK
       jal TRACK
       # next_move
       addi $t6, $t6, 1                    # chuyển sang kí tự tiếp theo sau dấu ';'
       add $t7, $a1, $t6
       lb $t5, 0($t7)                      # đọc ký tự
       beq $t5, 0, END                     # nếu gặp null thì kết thúc chương trình
       addi $t6, $t6, -1
       j READ_PSCRIPT
# <-- end -->
GO: 
       li $at, MOVING 
       addi $k0, $zero,1 
       sb $k0, 0($at) 
       jr $ra

STOP: 
       li $at, MOVING 
       sb $zero, 0($at)
       jr $ra
SETVALUE_TRACK:
       li $at, LEAVETRACK
       sb $t2, 0($at)
       jr $ra
TRACK: 
       li $at, LEAVETRACK 
       addi $k0, $zero,1 
       sb $k0, 0($at) 
       jr $ra 
UNTRACK:
       li $at, LEAVETRACK 
       sb $zero, 0($at) 
       jr $ra  
ROTATE: 
       li $at, HEADING 
       sw $a0, 0($at) 
       jr $ra
END:
       jal STOP
       li $v0, 10
       syscall
