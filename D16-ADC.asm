;Задача: сложить два 16 разрядных числа. У первого операнда значения младшего разряда хранится
;в памяти по адресу 0B00h (56), старшего по адресу 0B01h (180). У второго операнда значения младшего 
;разряда хранится в памяти по адресу 0B02h (253), старшего по адресу 0B01h (2).
;Результат сложения вывести: младший разряд в порт 30 (бит переноса + 00110101b), старший раряд в порт 35 (10110111b).
$ADR 0000h		;адрес начала программы
				
				;сброс портов 30h и 35h
MVI A, 0		;Загрузка в аккумулятор 0000h (56)
OUT 30h			;вывод резальтата аккумулятора в порт 30h
OUT 35h			;вывод резальтата аккумулятора в порт 35h

				;Инициализация ячеек памяти значениями
				;при вводе значений в P_manef удали строки с 14-21
MVI A,56		;Загрузка в аккумулятор 0038h (56)
STA 0B00h		;Запоминание содержимого аккумулятора в памяти по адресу 0B00h
MVI A,180		;Загрузка в аккумулятор 00B4h (180)
STA 0B01h		;Запоминание содержимого аккумулятора в памяти по адресу 0B01h
MVI A,253		;Загрузка в аккумулятор 00FDh (253)
STA 0B02h		;Запоминание содержимого аккумулятора в памяти по адресу 0B02h
MVI A,2			;Загрузка в аккумулятор 0002h (2)
STA 0B03h		;Запоминание содержимого аккумулятора в памяти по адресу 0B03h

				;сложение младших битов				
LDA 0B00h		;Передача содержимого памяти по адресу 0B00h в аккумулятор
MOV D,A			;Передача содержимого аккумулятора в регистр D
LDA 0B02h		;Передача содержимого памяти по адресу 0B02h в аккумулятор
ADD D			;Прибавление содержимого регистра D к содержимому в аккумуляторе и сохранение в аккумуляторе
OUT 30h			;Вывод резальтата аккумулятора в порт 30h (младший разряд)
				
				;сложение старших битов		
LDA  0B01h		;Передача содержимого памяти по адресу 0B01h в аккумулятор
MOV D,A			;Передача содержимого аккумулятора в регистр D
LDA	 0B03h		;Передача содержимого памяти по адресу 0B03h в аккумулятор
ADC D			;Прибавление содержимого регистра D и бита переноса к содержимому в аккумуляторе и сохранение в аккумуляторе
OUT 35h			;Вывод резальтата аккумулятора в порт 35h (старший разряд)
				;конец программы
