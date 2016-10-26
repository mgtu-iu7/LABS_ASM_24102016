;Задача: сложить два 16 разрядных числа. У первого операнда значения младшего разряда хранится
;в памяти по адресу 0B00h (56), старшего по адресу 0B01h (1). У второго операнда значения младшего 
;разряда хранится в памяти по адресу 0B02h (253), старшего по адресу 0B01h (2).
;Результат сложения вывести: младший разряд в порт 30 (бит переноса + 00110101b), старший раряд в порт 35 (00000101b).
$ADR 0000h		;адрес начала программы
				
				;сброс портов 30h и 35h
MVI A, 0		;Загрузка в аккумулятор 0000h (56)
OUT 30h			;вывод резальтата аккумулятора в порт 30h
OUT 35h			;вывод резальтата аккумулятора в порт 35h
MVI E, 0		;сброс бита переноса

				;Инициализация ячеек памяти значениями
				;при вводе значений в P_manef удали строки с 15-26
MVI A,56		;Загрузка в аккумулятор 0038h (56)
LXI B, 0B00h	;Инициализация регистровой пары ВС адресом 0B00h
STAX B			;Запоминание содержимого аккумулятора в памяти по адресу 0B00h
MVI A,1			;Загрузка в аккумулятор 0001h (1)
LXI B, 0B01h	;Инициализация регистровой пары ВС адресом 0B01h
STAX B			;Запоминание содержимого аккумулятора в памяти по адресу 0B01h
MVI A,253		;Загрузка в аккумулятор 00FDh (253)
LXI B, 0B02h	;Инициализация регистровой пары ВС адресом 0B02h
STAX B			;Запоминание содержимого аккумулятора в памяти по адресу 0B02h
MVI A,2			;Загрузка в аккумулятор 0002h (2)
LXI B, 0B03h	;Инициализация регистровой пары ВС адресом 0B03h
STAX B			;Запоминание содержимого аккумулятора в памяти по адресу 0B03h

				;сложение младших битов				
LXI B, 0B00h	;Инициализация регистровой пары ВС адресом 0B00h
LDAX B			;Передача содержимого памяти по адресу 0B00h в аккумулятор
MOV D,A			;Передача содержимого аккумулятора в регистр D
LXI B, 0B02h	;Инициализация регистровой пары ВС адресом 0B02h
LDAX B			;Передача содержимого памяти по адресу 0B02h в аккумулятор
ADC D			;Прибавление содержимого регистра D к содержимому в аккумуляторе и сохранение в аккумуляторе
OUT 30h			;вывод резальтата аккумулятора в порт 30h (младший разряд)
JNC PERENOS		;проверка флага переноса (бит переноса) если равен 1 то перехожу на метку иначе перепрыгиваю через три команды
PERENOS: MVI E,1;Загрузка в регистр E бит переноса 0001h (1)
NOP;
NOP;				
				;сложение старших битов		
LXI B, 0B01h	;Инициализация регистровой пары ВС адресом 0B01h
LDAX B			;Передача содержимого памяти по адресу 0B01h в аккумулятор
MOV D,A			;Передача содержимого аккумулятора в регистр D
LXI B, 0B03h	;Инициализация регистровой пары ВС адресом 0B03h
LDAX B			;Передача содержимого памяти по адресу 0B03h в аккумулятор
ADC D			;Прибавление содержимого регистра D к содержимому в аккумуляторе и сохранение в аккумуляторе
ADC E			;Прибавление бита переноса к содержимому в аккумуляторе и сохранение в аккумуляторе
OUT 35h			;вывод резальтата аккумулятора в порт 35h (старший разряд)
				;конец программы
